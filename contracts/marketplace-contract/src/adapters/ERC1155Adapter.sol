// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;


import {IERC1155} from "@openzeppelin/contracts/token/ERC1155/IERC1155.sol";
import {INFTAdapter} from "../interfaces/INFTAdapter.sol"; 

contract ERC1155Adapter is INFTAdapter {

    function transferNFTIn(address collection, address seller, uint256 tokenId, uint256 amount) external override {
        require(amount > 0, "ERC1155: Amount must be greater than 0");
        // The marketplace (msg.sender here if adapter is called by marketplace) must be approved
        // The seller must have approved the marketplace for the NFT
        IERC1155(collection).safeTransferFrom(seller, msg.sender, tokenId, amount, ""); // Transfer to the caller (marketplace)
    }

    function transferNFTOut(address collection, address buyer, uint256 tokenId, uint256 amount) external override {
        require(amount > 0, "ERC1155: Amount must be greater than 0");
        // The marketplace (msg.sender) must own the NFT and this adapter must be called by the marketplace
        IERC1155(collection).safeTransferFrom(msg.sender, buyer, tokenId, amount, ""); // Transfer from the caller (marketplace)
    }

    function returnNFT(address collection, address seller, uint256 tokenId, uint256 amount) external override {
        require(amount > 0, "ERC1155: Amount must be greater than 0");
        // The marketplace (msg.sender) must own the NFT and this adapter must be called by the marketplace
        IERC1155(collection).safeTransferFrom(msg.sender, seller, tokenId, amount, ""); // Transfer from the caller (marketplace)
    }

    function supportsNFTType(address collection) external view override returns (bool) {
        // Check for ERC1155 interface ID
        return IERC1155(collection).supportsInterface(0xd9b67a26); // ERC1155 interface ID
    }

    function getNFTBalance(address collection, address owner, uint256 tokenId) external view override returns (uint256) {
        return IERC1155(collection).balanceOf(owner, tokenId);
    }
}


