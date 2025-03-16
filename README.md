# ElmerCrypto - ERC-20 Token with Blackjack

## 📌 Description
GameCoin (GCC) is an ERC-20 token developed in Solidity that incorporates a betting system based on the game of **Blackjack**. Players can bet their tokens in matches against the dealer, simulating a card game with basic rules.

## 🚀 Features
- Implements an **ERC-20** token based on OpenZeppelin.
- Allows **token-based betting**.
- **Blackjack** game with pseudo-random card generation.
- Functions for **placing bets (`placeBet`)**, **hitting (`hit`)**, and **standing (`stand`)**.
- Balance verification and game results via `getGameInfo()`.

## 📂 Contract Structure
- **`GameCoin.sol`**: Contains the implementation of the ERC-20 token and Blackjack game logic.

## 🔧 Installation and Usage

### 1️⃣ Compile the contract
You can compile it using **Remix IDE** or **Hardhat**.

#### Using Remix:
1. Go to [Remix Ethereum](https://remix.ethereum.org/)
2. Create a new file `GameCoin.sol` and paste the code.
3. Compile with **Solidity 0.8.26**.
4. Deploy it on a testnet (Sepolia, Goerli) or use Remix VM for local testing.

#### Using Hardhat:
If you prefer Hardhat, install the required dependencies:
```bash
npm install --save-dev hardhat @nomicfoundation/hardhat-toolbox dotenv
```

Compile the contract:
```bash
npx hardhat compile
```

### 2️⃣ Deploy to a testnet
To deploy on a testnet like **Sepolia**, edit `hardhat.config.js` and configure Infura or Alchemy to connect to the network.

Run the deployment script:
```bash
npx hardhat run scripts/deploy.js --network sepolia
```

## 🎮 How to Play Blackjack
1. **Place a bet:** Call `placeBet(amount_in_wei)`, transferring tokens to the contract.
2. **Check your score and the dealer's score:** Call `getGameInfo()`.
3. **Hit:** Call `hit()`. If you exceed 21, you lose.
4. **Stand:** Call `stand()`. The contract acts as the dealer and determines the result.
5. **Check balance:** Use `balanceOf(your_address)` to see your token balance.

## 📜 License
This project is licensed under **LGPL-3.0-only**.

## 🛠️ Future Improvements
- Improve randomness using **Chainlink VRF**.
- Game history tracking with **events**.
- Graphical interface with **Web3.js / Ethers.js**.


