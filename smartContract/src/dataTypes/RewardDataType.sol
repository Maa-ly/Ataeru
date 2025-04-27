//SPDX-License_Identifier: MIT
pragma solidity 0.8.26; 

lib RewardDataType{


address[] token;
uint256 epochNumber;

struct RewardData{
    uint256 totalReward;
    uint256 lastTimeClaimed;
    uint256 rewardPerShare;
    address _tokenAddress;
    uint256 startTime;
    uint256 endTime;
   
}

mapping(address mapping(uint256 => RewardData)) private rewardToEpoch;
mapping(address => bool) public   hasBeenUsedBefore;
struct UserReward{
    uint256 lastTimeclaimed;
    uint256 reputationPoint;
    uint256 rewardsearned;
}

//mapping(uint256 => UserReward) private userToEpoch;
mapping(address mapping(uint256 => UserReward))private userToEpoch;



}