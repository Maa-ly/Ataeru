// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "../Interface/IFixedPointedOracle.sol";

contract FixedPriceOracle {
    uint256 public price;
    address public core;

    event PriceSet(uint256 indexed timestamp, uint256 price);

    constructor(address _core, uint256 _price) {
        core = _core;
        price = _price;
    }

    function setPrice(
        uint256 _price //  onlyCoreRole(CoreRoles.ORACLE_MANAGER)
    ) external {
        require(_price > 0, "Price must be greater than zero");
        // require(msg.sender == core, "Only core can set price");
        // require(_price != price, "Price is already set to this value");
        price = _price;
        emit PriceSet(block.timestamp, _price);
    }
}
