// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

import {IERC721} from "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import {INFTAdapter} from "../interfaces/INFTAdapter.sol"; 

contract ERC721Adapter is
    INFTAdapter // No longer inherits ERC721Holder
{
    function transferNFTIn(
        address collection,
        address seller,
        uint256 tokenId,
        uint256 amount
    ) external override {
        require(amount == 1, "ERC721: Amount must be 1 for ERC721");
        // The marketplace (msg.sender here if adapter is called by marketplace) must be approved
        // The seller must have approved the marketplace for the NFT
        IERC721(collection).transferFrom(seller, msg.sender, tokenId); // Transfer to the caller (marketplace)
    }

    function transferNFTOut(
        address collection,
        address buyer,
        uint256 tokenId,
        uint256 amount
    ) external override {
        require(amount == 1, "ERC721: Amount must be 1 for ERC721");
        // The marketplace (msg.sender) must own the NFT and this adapter must be called by the marketplace
        IERC721(collection).safeTransferFrom(msg.sender, buyer, tokenId); // Transfer from the caller (marketplace)
    }

    function returnNFT(
        address collection,
        address seller,
        uint256 tokenId,
        uint256 amount
    ) external override {
        require(amount == 1, "ERC721: Amount must be 1 for ERC721");
        // The marketplace (msg.sender) must own the NFT and this adapter must be called by the marketplace
        IERC721(collection).transferFrom(msg.sender, seller, tokenId); // Transfer from the caller (marketplace)
    }

    function supportsNFTType(
        address collection
    ) external view override returns (bool) {
        // A simple way to check if it's an ERC721 is by checking its interface ID.
        return IERC721(collection).supportsInterface(0x80ac58cd);
    }

    function getNFTBalance(
        address collection,
        address owner,
        uint256 tokenId
    ) external view override returns (uint256) {
        return IERC721(collection).ownerOf(tokenId) == owner ? 1 : 0;
    }
}
