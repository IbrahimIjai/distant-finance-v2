// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {ReentrancyGuard} from "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
import {EnumerableSet} from "@openzeppelin/contracts/utils/structs/EnumerableSet.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {SafeERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

//standard NFT interfaces
import {IERC721} from "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import {ERC721Holder} from "@openzeppelin/contracts/token/ERC721/utils/ERC721Holder.sol";
import {IERC1155} from "@openzeppelin/contracts/token/ERC1155/IERC1155.sol";
import {IERC1155Receiver} from "@openzeppelin/contracts/token/ERC1155/IERC1155Receiver.sol";
import {ERC165} from "@openzeppelin/contracts/utils/introspection/ERC165.sol";
import {IERC165} from "@openzeppelin/contracts/utils/introspection/IERC165.sol";


import {IWETH} from "./interfaces/IWETH.sol";
import {INFTAdapter} from "./interfaces/INFTAdapter.sol";
import "./utils/NFTMarketBaseUtils.sol";

contract NFTMarketPlace is
    Ownable,
    ReentrancyGuard,
    ERC721Holder,
    IERC1155Receiver,
    ERC165
{
    using EnumerableSet for EnumerableSet.AddressSet;
    using EnumerableSet for EnumerableSet.UintSet;

    using SafeERC20 for IERC20;

    address public immutable WBNB;

    uint256 public constant TOTAL_MAX_FEE = 1000;

    address public adminAddress;
    address public treasuryAddress;

    uint256 public minimumAskPrice;
    uint256 public maximumAskPrice;

    mapping(address => uint256) public pendingRevenue;

    EnumerableSet.AddressSet private _collectionAddressSet;

    mapping(address => mapping(uint256 => Ask)) private _askDetails; // Ask details (price + seller address) for a given collection and a tokenId
    mapping(address => EnumerableSet.UintSet) private _askTokenIds; // Set of tokenIds for a collection
    mapping(address => Collection) private _collections; // Details about the collections
    mapping(address => mapping(address => EnumerableSet.UintSet))
        private _tokenIdsOfSellerForCollection;

    // Mapping to store supported adapter contracts by type (e.g., ERC721, ERC1155)
    mapping(bytes4 => address) public supportedAdapters;

    constructor(
        address _adminAddress
    )
        // address _treasuryAddress,
        // address _WBNBAddress,
        // uint256 _minimumAskPrice,
        // uint256 _maximumAskPrice
        Ownable(_adminAddress)
    {
        // require(_adminAddress != address(0), "Operations: Admin address cannot be zero");
        // require(_treasuryAddress != address(0), "Operations: Treasury address cannot be zero");
        // require(_WBNBAddress != address(0), "Operations: WBNB address cannot be zero");
        // require(_minimumAskPrice > 0, "Operations: _minimumAskPrice must be > 0");
        // require(_minimumAskPrice < _maximumAskPrice, "Operations: _minimumAskPrice < _maximumAskPrice");
        // adminAddress = _adminAddress;
        // treasuryAddress = _treasuryAddress;
        // WBNB = _WBNBAddress;
        // minimumAskPrice = _minimumAskPrice;
        // maximumAskPrice = _maximumAskPrice;
    }

 function withdrawERC721(address collection, uint256 tokenId, address to) external onlyOwner {
        IERC721(collection).safeTransferFrom(address(this), to, tokenId);
    }

    // Function to send ERC1155 tokens out of the contract
    function withdrawERC1155(address collection, uint256 tokenId, uint256 amount, address to) external onlyOwner {
        IERC1155(collection).safeTransferFrom(address(this), to, tokenId, amount, "");
    }

    // Function to send batch ERC1155 tokens out of the contract
    function withdrawERC1155Batch(
        address collection, 
        uint256[] calldata tokenIds, 
        uint256[] calldata amounts, 
        address to
    ) external onlyOwner {
        IERC1155(collection).safeBatchTransferFrom(address(this), to, tokenIds, amounts, "");
    }
    
    // Events
    event AskCancel(
        address indexed collection,
        address indexed seller,
        uint256 indexed tokenId
    );
    event AskNew(
        address indexed collection,
        address indexed seller,
        uint256 indexed tokenId,
        uint256 askPrice,
        uint256 amount
    );
    event AskUpdate(
        address indexed collection,
        address indexed seller,
        uint256 indexed tokenId,
        uint256 askPrice
    );
    event CollectionClose(address indexed collection);
    event CollectionNew(
        address indexed collection,
        address indexed creator,
        address indexed whitelistChecker,
        uint256 tradingFee,
        uint256 creatorFee,
        bytes4 adapterId
    );
    event CollectionUpdate(
        address indexed collection,
        address indexed creator,
        address indexed whitelistChecker,
        uint256 tradingFee,
        uint256 creatorFee,
        bytes4 adapterId
    );
    event NewAdminAndTreasuryAddresses(
        address indexed admin,
        address indexed treasury
    );
    event NewMinimumAndMaximumAskPrices(
        uint256 minimumAskPrice,
        uint256 maximumAskPrice
    );
    event NonFungibleTokenRecovery(
        address indexed token,
        uint256 indexed tokenId
    );
    event RevenueClaim(address indexed claimer, uint256 amount);
    event TokenRecovery(address indexed token, uint256 amount);
    event Trade(
        address indexed collection,
        uint256 indexed tokenId,
        address indexed seller,
        address buyer,
        uint256 askPrice,
        uint256 netPrice,
        bool withBNB,
        uint256 amount
    );
    event AdapterSet(bytes4 indexed adapterId, address indexed adapterAddress);

    // Required IERC1155Receiver implementations
    function onERC1155Received(
        address operator,
        address from,
        uint256 id,
        uint256 value,
        bytes calldata data
    ) external pure override returns (bytes4) {
        return this.onERC1155Received.selector;
    }

    function onERC1155BatchReceived(
        address operator,
        address from,
        uint256[] calldata ids,
        uint256[] calldata values,
        bytes calldata data
    ) external pure override returns (bytes4) {
        return this.onERC1155BatchReceived.selector;
    }

    // Required ERC165 implementation
    function supportsInterface(
        bytes4 interfaceId
    ) public view virtual override(ERC165, IERC165) returns (bool) {
        return
            interfaceId == type(IERC1155Receiver).interfaceId ||
            super.supportsInterface(interfaceId);
    }
}
