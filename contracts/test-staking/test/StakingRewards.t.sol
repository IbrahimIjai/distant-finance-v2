// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "../src/Staking.sol";

// Mock ERC20 tokens for testing
contract MockERC20 is ERC20 {
    constructor(string memory name, string memory symbol) ERC20(name, symbol) {
        _mint(msg.sender, 1000000 * 10**18); // 1M tokens
    }
    
    function mint(address to, uint256 amount) external {
        _mint(to, amount);
    }
}

contract StakingRewardsTest is Test {
    StakingRewards public stakingContract;
    MockERC20 public stakingToken;
    MockERC20 public rewardsToken;
    
    address public owner = address(0x1);
    address public rewardsDistributor = address(0x2);
    address public alice = address(0x3);
    address public bob = address(0x4);
    address public charlie = address(0x5);
    
    uint256 constant INITIAL_BALANCE = 10000 * 1e18; // 10k tokens
    uint256 constant REWARD_AMOUNT = 1000 * 1e18; // 1k reward tokens
    uint256 constant STAKE_AMOUNT = 1000 * 1e18; // 1k staking tokens
    
    function setUp() public {
        // Deploy tokens
        stakingToken = new MockERC20("Staking Token", "STAKE");
        rewardsToken = new MockERC20("Reward Token", "REWARD");
        
        // Deploy staking contract
        vm.prank(owner);
        stakingContract = new StakingRewards(
            owner,
            rewardsDistributor,
            address(rewardsToken),
            address(stakingToken)
        );
        
        // Setup initial balances
        stakingToken.mint(alice, INITIAL_BALANCE);
        stakingToken.mint(bob, INITIAL_BALANCE);
        stakingToken.mint(charlie, INITIAL_BALANCE);
        rewardsToken.mint(address(stakingContract), REWARD_AMOUNT * 10); // 10k rewards
        
        // Approve spending
        vm.prank(alice);
        stakingToken.approve(address(stakingContract), type(uint256).max);
        vm.prank(bob);
        stakingToken.approve(address(stakingContract), type(uint256).max);
        vm.prank(charlie);
        stakingToken.approve(address(stakingContract), type(uint256).max);
        
        console.log("=== SETUP COMPLETE ===");
        console.log("Staking Token:", address(stakingToken));
        console.log("Rewards Token:", address(rewardsToken));
        console.log("Staking Contract:", address(stakingContract));
        console.log("Alice Balance: %d STAKE", stakingToken.balanceOf(alice) / 1e18);
        console.log("Bob Balance: %d STAKE", stakingToken.balanceOf(bob) / 1e18);
        console.log("Charlie Balance: %d STAKE", stakingToken.balanceOf(charlie) / 1e18);
        console.log("");
    }
    
    function testComprehensiveStaking() public {
        // Set shorter duration for faster testing
        vm.prank(owner);
        stakingContract.setRewardsDuration(120); // 2 minutes
        
        console.log("=== SETTING UP REWARDS ===");
        console.log("Rewards Duration: 120 seconds (2 minutes)");
        
        // Start rewards
        vm.prank(rewardsDistributor);
        stakingContract.notifyRewardAmount(REWARD_AMOUNT);
        
        uint256 rewardRate = stakingContract.rewardRate();
        console.log("Reward Rate: %d per second", rewardRate);
        console.log("Total Rewards for Period: %d REWARD", REWARD_AMOUNT / 1e18);
        
        // Calculate and display APY
        displayAPY(REWARD_AMOUNT, STAKE_AMOUNT, 120);
        console.log("");
        
        console.log("=== ROUND 1: INITIAL STAKING ===");
        
        // Alice stakes first
        vm.prank(alice);
        stakingContract.stake(STAKE_AMOUNT);
        console.log("Alice staked: %d STAKE", STAKE_AMOUNT / 1e18);
        displayUserStatus(alice, "Alice");
        
        // Wait 10 seconds and check earnings
        vm.warp(block.timestamp + 10);
        console.log("\n--- After 10 seconds ---");
        displayUserStatus(alice, "Alice");
        
        // Bob joins
        vm.prank(bob);
        stakingContract.stake(STAKE_AMOUNT / 2); // 500 tokens
        console.log("\nBob staked: %d STAKE", (STAKE_AMOUNT / 2) / 1e18);
        displayUserStatus(alice, "Alice");
        displayUserStatus(bob, "Bob");
        
        // Wait another 15 seconds
        vm.warp(block.timestamp + 15);
        console.log("\n--- After 15 more seconds (25 total) ---");
        displayUserStatus(alice, "Alice");
        displayUserStatus(bob, "Bob");
        
        console.log("\n=== ROUND 2: CHARLIE JOINS & PARTIAL WITHDRAWALS ===");
        
        // Charlie stakes
        vm.prank(charlie);
        stakingContract.stake(STAKE_AMOUNT * 2); // 2000 tokens
        console.log("Charlie staked: %d STAKE", (STAKE_AMOUNT * 2) / 1e18);
        displayAllUsers();
        
        // Wait 20 seconds
        vm.warp(block.timestamp + 20);
        console.log("\n--- After 20 more seconds (45 total) ---");
        displayAllUsers();
        
        // Alice withdraws half
        uint256 aliceBalance = stakingContract.balanceOf(alice);
        vm.prank(alice);
        stakingContract.withdraw(aliceBalance / 2);
        console.log("\nAlice withdrew: %d STAKE", (aliceBalance / 2) / 1e18);
        displayAllUsers();
        
        console.log("\n=== ROUND 3: REWARD CLAIMS & MORE STAKING ===");
        
        // Wait 30 seconds
        vm.warp(block.timestamp + 30);
        console.log("--- After 30 more seconds (75 total) ---");
        displayAllUsers();
        
        // Bob claims rewards
        uint256 bobRewardsBefore = rewardsToken.balanceOf(bob);
        vm.prank(bob);
        stakingContract.getReward();
        uint256 bobRewardsAfter = rewardsToken.balanceOf(bob);
        console.log("\nBob claimed rewards: %d REWARD", (bobRewardsAfter - bobRewardsBefore) / 1e18);
        displayAllUsers();
        
        // Alice stakes more
        vm.prank(alice);
        stakingContract.stake(STAKE_AMOUNT / 4); // 250 tokens
        console.log("\nAlice staked additional: %d STAKE", (STAKE_AMOUNT / 4) / 1e18);
        displayAllUsers();
        
        console.log("\n=== ROUND 4: FINAL PERIOD & EXIT ===");
        
        // Wait until near end of reward period
        vm.warp(block.timestamp + 35); // 110 total seconds
        console.log("--- Near end of reward period (110 total seconds) ---");
        displayAllUsers();
        
        // Charlie exits completely
        uint256 charlieRewardsBefore = rewardsToken.balanceOf(charlie);
        vm.prank(charlie);
        stakingContract.exit();
        uint256 charlieRewardsAfter = rewardsToken.balanceOf(charlie);
        console.log("\nCharlie exited completely!");
        console.log("Charlie claimed rewards: %d REWARD", (charlieRewardsAfter - charlieRewardsBefore) / 1e18);
        console.log("Charlie unstaked: %d STAKE", (STAKE_AMOUNT * 2) / 1e18);
        displayAllUsers();
        
        // Wait past reward period end
        vm.warp(block.timestamp + 20); // 130 total seconds (past 120)
        console.log("\n--- After reward period ended (130 total seconds) ---");
        displayAllUsers();
        
        // Final claims
        console.log("\n=== FINAL REWARD CLAIMS ===");
        uint256 aliceRewardsBefore = rewardsToken.balanceOf(alice);
        vm.prank(alice);
        stakingContract.getReward();
        uint256 aliceRewardsAfter = rewardsToken.balanceOf(alice);
        
        uint256 bobRewardsBefore2 = rewardsToken.balanceOf(bob);
        vm.prank(bob);
        stakingContract.getReward();
        uint256 bobRewardsAfter2 = rewardsToken.balanceOf(bob);
        
        console.log("Alice final reward claim: %d REWARD", (aliceRewardsAfter - aliceRewardsBefore) / 1e18);
        console.log("Bob final reward claim: %d REWARD", (bobRewardsAfter2 - bobRewardsBefore2) / 1e18);
        
        console.log("\n=== TEST SUMMARY ===");
        console.log("Total rewards distributed: %d REWARD", REWARD_AMOUNT / 1e18);
        console.log("Alice total rewards: %d REWARD", rewardsToken.balanceOf(alice) / 1e18);
        console.log("Bob total rewards: %d REWARD", rewardsToken.balanceOf(bob) / 1e18);
        console.log("Charlie total rewards: %d REWARD", rewardsToken.balanceOf(charlie) / 1e18);
        
        uint256 totalClaimed = rewardsToken.balanceOf(alice) + rewardsToken.balanceOf(bob) + rewardsToken.balanceOf(charlie);
        console.log("Total claimed: %d REWARD", totalClaimed / 1e18);
        console.log("Remaining in contract: %d REWARD", rewardsToken.balanceOf(address(stakingContract)) / 1e18);
        
        displayFinalAPYAnalysis();
    }
    
    function displayAPY(uint256 rewardAmount, uint256 stakeAmount, uint256 duration) internal pure {
        // APY = ((reward/stake) * (365*24*3600/duration)) * 100
        uint256 rewardRatio = (rewardAmount * 1e18) / stakeAmount; // Reward per token staked
        uint256 periodsPerYear = (365 * 24 * 3600) / duration; // How many periods in a year
        uint256 apy = (rewardRatio * periodsPerYear) / 1e16; // Convert to percentage (divide by 1e18 then multiply by 100)
        
        console.log("========================================");
        console.log("            APY CALCULATION           ");
        console.log("========================================");
        console.log("Reward Amount: %d REWARD", rewardAmount / 1e18);
        console.log("Stake Amount:  %d STAKE", stakeAmount / 1e18);
        console.log("Duration:      %d seconds", duration);
        console.log("Periods/Year:  %d", periodsPerYear);
        console.log("");
        console.log(" ESTIMATED APY: %d%%", apy);
        console.log("========================================");
    }
    
    function displayUserStatus(address user, string memory name) internal view {
        uint256 staked = stakingContract.balanceOf(user);
        uint256 earned = stakingContract.earned(user);
        uint256 rewardBalance = rewardsToken.balanceOf(user);
        
        console.log("%s", name);
        console.log("   Staked: %d STAKE", staked / 1e18);
        console.log("   Earned (unclaimed): %d REWARD", earned / 1e18);
        console.log("   Reward Balance: %d REWARD", rewardBalance / 1e18);
        console.log("   Total Value: %d tokens", (staked + earned) / 1e18);
    }
    
    function displayAllUsers() internal view {
        console.log(" ALL USERS STATUS:");
        displayUserStatus(alice, "Alice");
        displayUserStatus(bob, "Bob");
        displayUserStatus(charlie, "Charlie");
        console.log("Total Staked in Contract: %d STAKE", stakingContract.totalSupply() / 1e18);
        console.log("");
    }
    
    function displayFinalAPYAnalysis() internal view {
        console.log("\n========================================");
        console.log("          FINAL APY ANALYSIS          ");
        console.log("========================================");
        
        uint256 aliceRewards = rewardsToken.balanceOf(alice);
        uint256 bobRewards = rewardsToken.balanceOf(bob);
        uint256 charlieRewards = rewardsToken.balanceOf(charlie);
        
        // Calculate effective APY for each user based on their actual rewards
        // This is simplified and assumes they held their average stake for the full period
        console.log("Alice realized APY: ~%d%%", (aliceRewards * 100) / STAKE_AMOUNT);
        console.log("Bob realized APY: ~%d%%", (bobRewards * 200) / STAKE_AMOUNT); // Bob staked half
        console.log("Charlie realized APY: ~%d%%", (charlieRewards * 50) / STAKE_AMOUNT); // Charlie staked double
        console.log("");
        console.log(" APY varies based on:");
        console.log("   - When you stake/unstake");
        console.log("   - Total pool size changes");
        console.log("   - Reward claiming timing");
        console.log("========================================");
    }

    // Additional test for quick APY verification
    function testAPYCalculation() public pure {
        console.log("\n=== APY CALCULATION TEST ===");
        // Test different scenarios
        displayAPY(1000 * 1e18, 1000 * 1e18, 120); // 100% over 2 minutes
        displayAPY(100 * 1e18, 1000 * 1e18, 86400); // 10% over 1 day  
        displayAPY(1000 * 1e18, 10000 * 1e18, 604800); // 10% over 1 week
    }

    // Test individual staking mechanics
    function testBasicStaking() public {
        console.log("\n=== BASIC STAKING TEST ===");
        
        // Set up rewards
        vm.prank(owner);
        stakingContract.setRewardsDuration(60); // 1 minute
        
        vm.prank(rewardsDistributor);
        stakingContract.notifyRewardAmount(100 * 1e18);
        
        // Alice stakes
        vm.prank(alice);
        stakingContract.stake(1000 * 1e18);
        
        assertEq(stakingContract.balanceOf(alice), 1000 * 1e18);
        assertEq(stakingContract.totalSupply(), 1000 * 1e18);
        
        // Wait and check earnings
        vm.warp(block.timestamp + 30); // Half the reward period
        
        uint256 earned = stakingContract.earned(alice);
        console.log("Alice earned after 30 seconds: %d REWARD", earned / 1e18);
        
        // Should be approximately 50 tokens (half of 100)
        assertApproxEqRel(earned, 50 * 1e18, 0.01e18); // 1% tolerance
    }
}