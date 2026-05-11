import { ethers } from "ethers";
// Calculate APY for a Uniswap v3 position
export function calculateAPY(feesEarned: bigint, principal: bigint, daysHeld: number): number {
  if (principal === BigInt(0) || daysHeld === 0) return 0;
  const dailyReturn = Number(feesEarned) / Number(principal) / daysHeld;
  return dailyReturn * 365 * 100;
}
export function tickToPrice(tick: number, token0Decimals: number, token1Decimals: number): number {
  return Math.pow(1.0001, tick) * Math.pow(10, token0Decimals - token1Decimals);
}