import { ethers } from "ethers";

const POSITION_MANAGER = "0x03a520b32C04BF3bEEf7BEb72E919cf822Ed34f";
const ABI = [
  "function positions(uint256 tokenId) view returns (uint96,address,address,address,uint24,int24,int24,uint128,uint256,uint256,uint128,uint128)",
  "function balanceOf(address owner) view returns (uint256)",
  "function tokenOfOwnerByIndex(address owner, uint256 index) view returns (uint256)"
];

async function listPositions(walletAddress: string) {
  const provider = new ethers.JsonRpcProvider(process.env.BASE_RPC_URL || "https://mainnet.base.org");
  const pm = new ethers.Contract(POSITION_MANAGER, ABI, provider);
  
  const balance = await pm.balanceOf(walletAddress);
  console.log(`Found ${balance} positions for ${walletAddress}`);
  
  for (let i = 0; i < Number(balance); i++) {
    const tokenId = await pm.tokenOfOwnerByIndex(walletAddress, i);
    const pos = await pm.positions(tokenId);
    console.log({
      tokenId: tokenId.toString(),
      token0: pos[2],
      token1: pos[3],
      fee: pos[4],
      tickLower: pos[5],
      tickUpper: pos[6],
      liquidity: pos[7].toString(),
    });
  }
}

listPositions(process.argv[2] || "0x0000000000000000000000000000000000000000");
