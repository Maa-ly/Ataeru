// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import "../Interface/IFixedPointedOracle.sol";
import "../core/HealthDataNFT.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
/**
 * MarketPlace will be changed to an Auction marketplace, to incentivuce users more
 */

contract MarketPlace {
    IFixedPointedOracle oracle;

    using SafeERC20 for IERC20;

    uint256[] nftsOnSale;
    uint256 saleEpoch = 1;

    struct NFTSellDetails {
        address nftOwner;
        uint256 sellTimeStamp;
        uint256 _price;
        uint256 _saleEpoch;
        bool sold;
    }

    mapping(NFTSellDetails => uint256) public displayDetails;

    function sell(uint256 _nftId) public {
        uint256 currentEpoch = saleEpoch;
        saleEpoch++;
        HealthDataNFT.isOwnerOFToken(_nftId);

        displayDetails[_nftId] = NFTSellDetails({
            nftOwner: msg.sender,
            seTimeStamp: block.timestamp,
            _price: oracle.price,
            _saleEpoch: currentEpoch,
            sold: false
        });

        IERC20.safeTransferFrom(msg.sender, address(this), _nftId);
    }

    function buy(uint256 _nftId, uint256 epoch) public {
        require(displayDetails[_nftId]._saleEpoch != 0 && displayDetails[_nftId].sold == false, "Marketplace__Invalid");
        uint256 cureentPrice = displayDetails[_nftId]._price;
        address recepient = displayDetails[_nftId].nftOwner;
        displayDetails[_nftId].sold = true;
        IERC20.safeTransferFrom(msg.sender, recepient, cureentPrice);
        IERC20.safeTransfer(msg.sender, _nftId);
    }

    function getOnsale() public returns (uint256[]) {
        return nftsOnSale;
    }
}
