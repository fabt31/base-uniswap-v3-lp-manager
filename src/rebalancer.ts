import { ethers } from "ethers";
// Rebalance out-of-range Uniswap v3 positions
export async function rebalancePosition(tokenId: bigint, newTickLower: number, newTickUpper: number, provider: ethers.JsonRpcProvider) {
  console.log(`Rebalancing position ${tokenId} to [${newTickLower}, ${newTickUpper}]`);
  // 1. Remove liquidity from old range
  // 2. Collect fees
  // 3. Add liquidity to new range
}