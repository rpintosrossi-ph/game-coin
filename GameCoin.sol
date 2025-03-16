// SPDX-License-Identifier: LGPL-3.0-only
pragma solidity ^0.8.26;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";


contract GameCoin is ERC20 {
    uint256 public minBet = 1 * 1e18; // Apuesta mínima en tokens (1 ECR)
    uint256 public maxBet = 100 * 1e18; // Apuesta máxima en tokens (100 ECR)

    struct Game {
        uint256 bet;
        uint8 playerScore;
        uint8 dealerScore;
        bool active;
    }

    mapping(address => Game) public games;
    
    constructor() ERC20("GameCoin", "GCC") {
        _mint(msg.sender, 10000 * 1e18); // Suministro inicial
    }

    function placeBet(uint256 _bet) external {
        require(_bet >= minBet && _bet <= maxBet, "Apuesta fuera de limites");
        require(balanceOf(msg.sender) >= _bet, "Fondos insuficientes");
        require(!games[msg.sender].active, "Ya tienes un juego en curso");
        
        _transfer(msg.sender, address(this), _bet);
        games[msg.sender] = Game({
            bet: _bet,
            playerScore: uint8((block.timestamp % 10) + 12), // Simula primera carta
            dealerScore: uint8((block.difficulty % 10) + 12), // Simula carta del dealer
            active: true
        });
    }

    function hit() external {
        require(games[msg.sender].active, "No tienes un juego activo");
        require(games[msg.sender].playerScore < 21, "Ya no puedes tomar mas cartas");

        uint8 newCard = uint8((block.timestamp + block.number) % 10) + 1;
        games[msg.sender].playerScore += newCard;
        
        if (games[msg.sender].playerScore > 21) {
            games[msg.sender].active = false; // Pierde automáticamente
        }
    }

    function stand() external {
        require(games[msg.sender].active, "No tienes un juego activo");
        
        while (games[msg.sender].dealerScore < 17) {
            uint8 newCard = uint8((block.difficulty + block.number) % 10) + 1;
            games[msg.sender].dealerScore += newCard;
        }
        
        if (games[msg.sender].dealerScore > 21 || games[msg.sender].playerScore > games[msg.sender].dealerScore) {
            _transfer(address(this), msg.sender, games[msg.sender].bet * 2);
        }
        
        games[msg.sender].active = false;
    }

    function getGameInfo() external view returns (uint256 bet, uint8 playerScore, uint8 dealerScore, bool active) {
        require(games[msg.sender].active, "No tienes un juego activo");
    
        Game storage game = games[msg.sender];
        return (game.bet, game.playerScore, game.dealerScore, game.active);
}

}
