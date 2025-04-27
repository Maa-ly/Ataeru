// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

import "smartContract/src/Interface/IFixedPointedOracle.sol";


contract FixedPriceOracle is IFixedPointedOracle {
    uint256 public price;

    event PriceSet(uint256 indexed timestamp, uint256 price);

    constructor(address _core, uint256 _price)  {
        price = _price;
    }

    function setPrice(uint256 _price) external onlyCoreRole(CoreRoles.ORACLE_MANAGER) {
        price = _price;
        emit PriceSet(block.timestamp, _price);
    }

    // function getPrice() public returns(uint256) {
    //     returns price ; 
    // }
}
