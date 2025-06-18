// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

enum CollectionStatus {
    Pending,
    Open,
    Close
}

struct Ask {
    address seller;
    uint256 price;
    uint256 amount;
}

struct Collection {
    CollectionStatus status;
    address creatorAddress;
    address whitelistChecker;
    uint256 tradingFee;
    uint256 creatorFee;
    bytes4 adapterId;
}

