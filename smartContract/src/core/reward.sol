// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import "../core/HRS.sol";
import "../dataTypes/RewardDataType.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

contract RewardContract is RewardDataType {
 using SafeERC20 for IERC20;

 function earned(uint256 _epoch, address __token) public {
    userToEpoch[msg.sender][_epoch] = UserReward({
        lastTimeClaimed : 0,
        reputationPoint: HRS.getUserReputation,
        rewardsearned:  rewardToEpoch[_token][_epoch].rewardPerShare * reputationPoint
    });
        
    }

    //function isRewardToken() public {}
    function addRewardMultiple(RewardData rewardData) public returns(uint256[] _epochNumber){
        uint256 length = rewardData.length;

        for(uint256 index = 0 ; index > length ; index ++){

          _epochNUmber =  addReward(rewardData[i]);
        }
    }

    function addReward(RewardData rewardData) public returns(uint256  _epochNumber) {
 require(rewardData.startTime < block.timestamp & rewardData.endTIme < rewardData.startTime, "Reward__Invalid_time");
  
   uint256 diff = reward.endTime - reward.startTime;
   uint256 distributionperiod = rewardData.totalReward / diff ;
    address tokenA = rewardData._tokenAddress ;

  uint256 unUsedReward =  rewardData.totalReward - (distributionperiod * diff); // i will use the disP * diff
  uint256 usedReward = distributionperiod * diff;

        _epochNumber = epochNUmber;
        epochNumber++;

        rewardToEpoch[tokenA][_epochNumber] = RewardData({
            totalReward : usedReward,
            lastTimeUpdated : block.timestamp,
            rewardPerShare : distributionperiod,
            _tokenAddress: tokenA  , // remove 
            startTime: rewardData.startTime,
            endTIme: rewardData.endTime
          
        });
        
       
       if(!hasBeenUsedBefore[tokenA]){
        
         token.push(tokenA);
       }

      hasBeenUsedBefore[tokenA] = true;
       
        IERC20(tokenA).safeTransferFrom(msg.sender, address(this), usedReward);

        return  _epochNumber; 


    }

   

function claim(uint256 _epoch, address _token) public {
    earned(_epoch, _token);
    uint256 rewardsForUser  =  userToEpoch[msg.sender][_epoch].rewardsearned;
   
    uint256 _totalReward = rewardToEpoch[_epochNumber].totalReward;
   require(rewardsForUser > 0 && _totalReward <= rewardsForUser, "Rewards__Cannot Process");

 address tokenA =  rewardToEpoch[_token][_epochNumber]._tokenAddress;
 rewardToEpoch[_epochNumber].totalReward = _totalReward - rewardsForUser; 
  
 IERC20(tokenA).safeTransfer(msg.sender, rewardsForUser);

    }


    function getRewardAddress() public returns(address[] memory){
      return token;
    }


}