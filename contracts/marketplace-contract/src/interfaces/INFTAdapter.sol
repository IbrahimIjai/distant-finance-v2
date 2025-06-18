// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

interface INFTAdapter {
    // Function to handle NFT transfer from seller to marketplace for listing
    function transferNFTIn(address collection, address seller, uint256 tokenId, uint256 amount) external;

    // Function to handle NFT transfer from marketplace to buyer after purchase
    function transferNFTOut(address collection, address buyer, uint256 tokenId, uint256 amount) external;

    // Function to handle NFT transfer from marketplace back to seller on cancellation
    function returnNFT(address collection, address seller, uint256 tokenId, uint256 amount) external;

    // Function to check if a collection supports a specific adapter (e.g., ERC721, ERC1155)
    // This is different from IERC165's supportsInterface, as it checks the *collection's* type.
    function supportsNFTType(address collection) external view returns (bool);

    // Optional: Function to check balance of an NFT (important for ERC1155)
    // The `owner` parameter here would be the marketplace contract itself, or the original seller.
    function getNFTBalance(address collection, address owner, uint256 tokenId) external view returns (uint256);
}

