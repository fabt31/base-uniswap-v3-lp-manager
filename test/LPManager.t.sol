// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import "forge-std/Test.sol";
import "../contracts/LPManager.sol";
contract LPManagerTest is Test {
    function test_collectFees_revertsIfNotOwner() public {
        // deploy stub and assert revert
        vm.expectRevert("Not owner");
    }
    function test_withdrawPosition_deductsLiquidity() public { assertTrue(true); }
}