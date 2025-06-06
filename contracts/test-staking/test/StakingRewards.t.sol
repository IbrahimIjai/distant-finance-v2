// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Staking.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract StakingRewardsTest is Test {
    StakingRewards public stakingRewards;
    ERC20 public stakingToken;
    ERC20 public rewardsToken;

    address public owner = address(0x1);
    address public rewardsDistributor = address(0x2);
    address public user1 = address(0x3);
    address public user2 = address(0x4);

    uint256 public initialReward = 1_000_000 ether;
    uint256 public stakeAmount = 100 ether;

    function setUp() public {
        // Deploy mock tokens
        stakingToken = new ERC20("Staking Token", "STK");
        rewardsToken = new ERC20("Rewards Token", "RWD");

        // Mint tokens to users
        stakingToken._mint(user1, 1_000 ether);
        stakingToken._mint(user2, 1_000 ether);
        rewardsToken._mint(address(this), initialReward);

        // Deploy StakingRewards contract
        stakingRewards = new StakingRewards(
            owner,
            rewardsDistributor,
            address(rewardsToken),
            address(stakingToken)
        );

        // Transfer rewards to the staking contract
        rewardsToken.transfer(address(stakingRewards), initialReward);

        // Notify reward amount
        vm.prank(rewardsDistributor);
        stakingRewards.notifyRewardAmount(initialReward);
    }

    function testStakingAndEarnings() public {
        // Users approve staking tokens
        vm.prank(user1);
        stakingToken.approve(address(stakingRewards), stakeAmount);
        vm.prank(user2);
        stakingToken.approve(address(stakingRewards), stakeAmount);

        // Users stake tokens
        vm.prank(user1);
        stakingRewards.stake(stakeAmount);
        vm.prank(user2);
        stakingRewards.stake(stakeAmount);

        // Fast forward time by 1 day
        vm.warp(block.timestamp + 1 days);

        // Users claim rewards
        vm.prank(user1);
        stakingRewards.getReward();
        vm.prank(user2);
        stakingRewards.getReward();

        // Check rewards balance
        uint256 user1Reward = rewardsToken.balanceOf(user1);
        uint256 user2Reward = rewardsToken.balanceOf(user2);

        emit log_named_uint("User1 Reward after 1 day", user1Reward);
        emit log_named_uint("User2 Reward after 1 day", user2Reward);

        // Calculate and log APY
        uint256 apy = (user1Reward * 365) / stakeAmount;
        emit log_named_uint("Approximate APY (%)", apy);
    }

    function testMultipleStakingRounds() public {
        // Users approve staking tokens
        vm.prank(user1);
        stakingToken.approve(address(stakingRewards), stakeAmount);
        vm.prank(user2);
        stakingToken.approve(address(stakingRewards), stakeAmount);

        // Round 1
        vm.prank(user1);
        stakingRewards.stake(stakeAmount);
        vm.warp(block.timestamp + 1 days);
        vm.prank(user1);
        stakingRewards.getReward();
        uint256 reward1 = rewardsToken.balanceOf(user1);
        emit log_named_uint("User1 Reward after Round 1", reward1);

        // Round 2
        vm.prank(user2);
        stakingRewards.stake(stakeAmount);
        vm.warp(block.timestamp + 1 days);
        vm.prank(user2);
        stakingRewards.getReward();
        uint256 reward2 = rewardsToken.balanceOf(user2);
        emit log_named_uint("User2 Reward after Round 2", reward2);

        // User1 withdraws
        vm.prank(user1);
        stakingRewards.withdraw(stakeAmount);
        uint256 remainingStake = stakingRewards.balanceOf(user1);
        emit log_named_uint("User1 Remaining Stake", remainingStake);
    }
}
