// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/NFTMarketPlace.sol";
import "../src/mocks/BoredApe.sol";
import "../src/mocks/CallOfDutySMGs.sol";

contract NFTMarketPlaceTest is Test {
    NFTMarketPlace public marketplace;
    BoredApe public boredApe;
    CallOfDutySMGs public codSMGs;
    
    address public owner = address(0x1);
    address public user1 = address(0x2);
    address public user2 = address(0x3);

    function setUp() public {
        vm.startPrank(owner);
        
        // Deploy contracts
        marketplace = new NFTMarketPlace(owner);
        boredApe = new BoredApe();
        codSMGs = new CallOfDutySMGs();
        
        vm.stopPrank();
    }

    function testERC721SendAndReceive() public {
        console.log("=== Testing ERC721 (Bored Ape) Send and Receive ===");
        
        vm.startPrank(owner);
        
        // Mint a Bored Ape NFT to user1
        uint256 tokenId = boredApe.mint(user1);
        console.log("Minted Bored Ape token ID:", tokenId);
        
        vm.stopPrank();
        vm.startPrank(user1);
        
        // Check initial ownership
        assertEq(boredApe.ownerOf(tokenId), user1);
        console.log("Initial owner of token", tokenId, ":", boredApe.ownerOf(tokenId));
        
        // Send NFT to marketplace
        boredApe.safeTransferFrom(user1, address(marketplace), tokenId);
        console.log("Sent token", tokenId, "to marketplace");
        
        // Verify marketplace now owns the NFT
        assertEq(boredApe.ownerOf(tokenId), address(marketplace));
        console.log("Marketplace now owns token", tokenId);
        
        vm.stopPrank();
        vm.startPrank(owner);
        
        // Send NFT from marketplace to user2
        marketplace.withdrawERC721(address(boredApe), tokenId, user2);
        console.log("Withdrew token", tokenId, "from marketplace to user2");
        
        // Verify user2 now owns the NFT
        assertEq(boredApe.ownerOf(tokenId), user2);
        console.log("Final owner of token", tokenId, ":", boredApe.ownerOf(tokenId));
        
        vm.stopPrank();
    }

    function testERC721BatchOperations() public {
        console.log("=== Testing ERC721 Batch Operations ===");
        
        vm.startPrank(owner);
        
        // Mint multiple Bored Ape NFTs
        uint256[] memory tokenIds = boredApe.mintBatch(user1, 3);
        console.log("Minted", tokenIds.length, "Bored Ape tokens");
        
        vm.stopPrank();
        vm.startPrank(user1);
        
        // Send all NFTs to marketplace
        for (uint256 i = 0; i < tokenIds.length; i++) {
            boredApe.safeTransferFrom(user1, address(marketplace), tokenIds[i]);
            console.log("Sent token", tokenIds[i], "to marketplace");
        }
        
        vm.stopPrank();
        vm.startPrank(owner);
        
        // Withdraw all NFTs to user2
        for (uint256 i = 0; i < tokenIds.length; i++) {
            marketplace.withdrawERC721(address(boredApe), tokenIds[i], user2);
            assertEq(boredApe.ownerOf(tokenIds[i]), user2);
            console.log("Withdrew token", tokenIds[i], "to user2");
        }
        
        vm.stopPrank();
    }

    function testERC1155SendAndReceive() public {
        console.log("=== Testing ERC1155 (Call of Duty SMGs) Send and Receive ===");
        
        vm.startPrank(owner);
        
        // Mint different SMG tokens to user1
        codSMGs.mint(user1, codSMGs.MP5(), 10);      // 10 MP5s
        codSMGs.mint(user1, codSMGs.UMP45(), 5);     // 5 UMP45s
        codSMGs.mint(user1, codSMGs.P90(), 8);       // 8 P90s
        codSMGs.mint(user1, codSMGs.VECTOR(), 3);    // 3 VECTORs
        codSMGs.mint(user1, codSMGs.MP7(), 12);      // 12 MP7s
        
        console.log("Minted SMG tokens to user1:");
        console.log("- MP5:", codSMGs.balanceOf(user1, codSMGs.MP5()));
        console.log("- UMP45:", codSMGs.balanceOf(user1, codSMGs.UMP45()));
        console.log("- P90:", codSMGs.balanceOf(user1, codSMGs.P90()));
        console.log("- VECTOR:", codSMGs.balanceOf(user1, codSMGs.VECTOR()));
        console.log("- MP7:", codSMGs.balanceOf(user1, codSMGs.MP7()));
        
        vm.stopPrank();
        vm.startPrank(user1);
        
        // Send some tokens to marketplace
        codSMGs.safeTransferFrom(user1, address(marketplace), codSMGs.MP5(), 5, "");
        codSMGs.safeTransferFrom(user1, address(marketplace), codSMGs.P90(), 3, "");
        codSMGs.safeTransferFrom(user1, address(marketplace), codSMGs.MP7(), 7, "");
        
        console.log("Sent tokens to marketplace:");
        console.log("- 5 MP5s");
        console.log("- 3 P90s"); 
        console.log("- 7 MP7s");
        
        // Verify marketplace balances
        assertEq(codSMGs.balanceOf(address(marketplace), codSMGs.MP5()), 5);
        assertEq(codSMGs.balanceOf(address(marketplace), codSMGs.P90()), 3);
        assertEq(codSMGs.balanceOf(address(marketplace), codSMGs.MP7()), 7);
        
        vm.stopPrank();
        vm.startPrank(owner);
        
        // Withdraw tokens from marketplace to user2
        marketplace.withdrawERC1155(address(codSMGs), codSMGs.MP5(), 3, user2);
        marketplace.withdrawERC1155(address(codSMGs), codSMGs.P90(), 2, user2);
        marketplace.withdrawERC1155(address(codSMGs), codSMGs.MP7(), 5, user2);
        
        console.log("Withdrew tokens from marketplace to user2:");
        console.log("- 3 MP5s");
        console.log("- 2 P90s");
        console.log("- 5 MP7s");
        
        // Verify user2 balances
        assertEq(codSMGs.balanceOf(user2, codSMGs.MP5()), 3);
        assertEq(codSMGs.balanceOf(user2, codSMGs.P90()), 2);
        assertEq(codSMGs.balanceOf(user2, codSMGs.MP7()), 5);
        
        // Verify remaining marketplace balances
        assertEq(codSMGs.balanceOf(address(marketplace), codSMGs.MP5()), 2);
        assertEq(codSMGs.balanceOf(address(marketplace), codSMGs.P90()), 1);
        assertEq(codSMGs.balanceOf(address(marketplace), codSMGs.MP7()), 2);
        
        vm.stopPrank();
    }

    function testERC1155BatchOperations() public {
        console.log("=== Testing ERC1155 Batch Operations ===");
        
        vm.startPrank(owner);
        
        // Prepare batch mint data
        uint256[] memory ids = new uint256[](5);
        uint256[] memory amounts = new uint256[](5);
        
        ids[0] = codSMGs.MP5();
        ids[1] = codSMGs.UMP45();
        ids[2] = codSMGs.P90();
        ids[3] = codSMGs.VECTOR();
        ids[4] = codSMGs.MP7();
        
        amounts[0] = 20;
        amounts[1] = 15;
        amounts[2] = 10;
        amounts[3] = 8;
        amounts[4] = 25;
        
        // Batch mint to user1
        codSMGs.mintBatch(user1, ids, amounts);
        console.log("Batch minted SMG tokens to user1");
        
        vm.stopPrank();
        vm.startPrank(user1);
        
        // Batch transfer to marketplace
        uint256[] memory transferAmounts = new uint256[](5);
        transferAmounts[0] = 10; // MP5
        transferAmounts[1] = 8;  // UMP45
        transferAmounts[2] = 5;  // P90
        transferAmounts[3] = 4;  // VECTOR
        transferAmounts[4] = 12; // MP7
        
        codSMGs.safeBatchTransferFrom(user1, address(marketplace), ids, transferAmounts, "");
        console.log("Batch transferred tokens to marketplace");
        
        vm.stopPrank();
        vm.startPrank(owner);
        
        // Batch withdraw from marketplace to user2
        uint256[] memory withdrawAmounts = new uint256[](5);
        withdrawAmounts[0] = 5;  // MP5
        withdrawAmounts[1] = 4;  // UMP45
        withdrawAmounts[2] = 3;  // P90
        withdrawAmounts[3] = 2;  // VECTOR
        withdrawAmounts[4] = 6;  // MP7
        
        marketplace.withdrawERC1155Batch(address(codSMGs), ids, withdrawAmounts, user2);
        console.log("Batch withdrew tokens from marketplace to user2");
        
        // Verify final balances
        for (uint256 i = 0; i < ids.length; i++) {
            uint256 user2Balance = codSMGs.balanceOf(user2, ids[i]);
            uint256 marketplaceBalance = codSMGs.balanceOf(address(marketplace), ids[i]);
           
            console.log("Token ID:", ids[i]);
            console.log("  User2 balance:", user2Balance);
            console.log("  Marketplace balance:", marketplaceBalance);
            
            assertEq(user2Balance, withdrawAmounts[i]);
            assertEq(marketplaceBalance, transferAmounts[i] - withdrawAmounts[i]);
        }
        
        vm.stopPrank();
    }

    function testMixedOperations() public {
        console.log("=== Testing Mixed ERC721 and ERC1155 Operations ===");
        
        vm.startPrank(owner);
        
        // Mint both types of tokens
        uint256 apeTokenId = boredApe.mint(user1);
        codSMGs.mint(user1, codSMGs.MP5(), 10);
        
        vm.stopPrank();
        vm.startPrank(user1);
        
        // Send both to marketplace
        boredApe.safeTransferFrom(user1, address(marketplace), apeTokenId);
        codSMGs.safeTransferFrom(user1, address(marketplace), codSMGs.MP5(), 5, "");
        
        console.log("Sent both ERC721 and ERC1155 tokens to marketplace");
        
        vm.stopPrank();
        vm.startPrank(owner);
        
        // Withdraw both to user2
        marketplace.withdrawERC721(address(boredApe), apeTokenId, user2);
        marketplace.withdrawERC1155(address(codSMGs), codSMGs.MP5(), 3, user2);
        
        // Verify final ownership
        assertEq(boredApe.ownerOf(apeTokenId), user2);
        assertEq(codSMGs.balanceOf(user2, codSMGs.MP5()), 3);
        assertEq(codSMGs.balanceOf(address(marketplace), codSMGs.MP5()), 2);
        
        console.log("Successfully completed mixed operations test");
        
        vm.stopPrank();
    }

    function testOnlyOwnerRestrictions() public {
        vm.startPrank(owner);
        uint256 tokenId = boredApe.mint(address(marketplace));
        vm.stopPrank();
        
        // Try to withdraw as non-owner (should fail)
        vm.startPrank(user1);
        vm.expectRevert();
        marketplace.withdrawERC721(address(boredApe), tokenId, user1);
        vm.stopPrank();
        
        // Owner should be able to withdraw
        vm.startPrank(owner);
        marketplace.withdrawERC721(address(boredApe), tokenId, user1);
        assertEq(boredApe.ownerOf(tokenId), user1);
        vm.stopPrank();
    }
}
