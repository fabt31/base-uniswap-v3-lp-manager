# base-uniswap-v3-lp-manager

> Uniswap v3 liquidity position manager for Base L2

Autocompound fees, rebalance price ranges, and monitor all your Uniswap v3 LP positions on Base network in one place.

## Features

- 📊 Real-time LP position tracking (current tick, in-range status, fees earned)
- 🔄 Automated fee compounding via smart contracts
- 🎯 Price range rebalancer with customizable tick spacing
- 📈 Historical APY calculator per position
- 🛡️ Slippage protection and deadline management
- 🔗 Supports Base mainnet and Base Sepolia testnet

## Installation

```bash
git clone https://github.com/fabt31/base-uniswap-v3-lp-manager
cd base-uniswap-v3-lp-manager
npm install
cp .env.example .env  # Add your RPC URL and private key
```

## Configuration

```env
BASE_RPC_URL=https://mainnet.base.org
PRIVATE_KEY=your_private_key
UNISWAP_V3_FACTORY=0x33128a8fC17869897dcE68Ed026d694621f6FDfD
NONFUNGIBLE_POSITION_MANAGER=0x03a520b32C04BF3bEEf7BEb72E919cf822Ed34f
```

## Usage

```bash
# List all open positions
npm run positions

# Compound fees for a position
npm run compound -- --tokenId 12345

# Rebalance out-of-range position
npm run rebalance -- --tokenId 12345 --tickLower -887220 --tickUpper 887220
```

## Smart Contracts

| Contract | Address (Base Mainnet) |
|---|---|
| UniswapV3Factory | `0x33128a8fC17869897dcE68Ed026d694621f6FDfD` |
| NonfungiblePositionManager | `0x03a520b32C04BF3bEEf7BEb72E919cf822Ed34f` |
| SwapRouter02 | `0x2626664c2603336E57B271c5C0b26F421741e481` |

## Tech Stack

- Solidity 0.8.20 + Foundry
- TypeScript / ethers.js v6
- Base L2 (OP Stack)

## License

MIT
