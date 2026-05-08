// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@uniswap/v3-periphery/contracts/interfaces/INonfungiblePositionManager.sol";
import "@uniswap/v3-core/contracts/interfaces/IUniswapV3Pool.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/// @title LPManager - Uniswap v3 LP position manager for Base L2
contract LPManager is Ownable {
    INonfungiblePositionManager public immutable positionManager;

    address public constant UNISWAP_V3_FACTORY = 0x33128a8fC17869897dcE68Ed026d694621f6FDfD;

    event FeesCollected(uint256 indexed tokenId, uint256 amount0, uint256 amount1);
    event PositionRebalanced(uint256 indexed oldTokenId, uint256 indexed newTokenId);

    constructor(address _positionManager) Ownable(msg.sender) {
        positionManager = INonfungiblePositionManager(_positionManager);
    }

    /// @notice Collect accumulated fees for a position
    function collectFees(uint256 tokenId) external returns (uint256 amount0, uint256 amount1) {
        require(positionManager.ownerOf(tokenId) == msg.sender, "Not owner");
        INonfungiblePositionManager.CollectParams memory params = INonfungiblePositionManager.CollectParams({
            tokenId: tokenId,
            recipient: msg.sender,
            amount0Max: type(uint128).max,
            amount1Max: type(uint128).max
        });
        (amount0, amount1) = positionManager.collect(params);
        emit FeesCollected(tokenId, amount0, amount1);
    }

    /// @notice Decrease liquidity and collect all tokens
    function withdrawPosition(uint256 tokenId, uint128 liquidity) external {
        require(positionManager.ownerOf(tokenId) == msg.sender, "Not owner");
        positionManager.decreaseLiquidity(INonfungiblePositionManager.DecreaseLiquidityParams({
            tokenId: tokenId,
            liquidity: liquidity,
            amount0Min: 0,
            amount1Min: 0,
            deadline: block.timestamp + 300
        }));
        positionManager.collect(INonfungiblePositionManager.CollectParams({
            tokenId: tokenId,
            recipient: msg.sender,
            amount0Max: type(uint128).max,
            amount1Max: type(uint128).max
        }));
    }
}
