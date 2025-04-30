//SPDX-License_Identifier: MIT
pragma solidity 0.8.26; 

library DataStructures{

  
        mapping(address => DonorInfo) donors;
        mapping(address => UserInfo) users;
        mapping(address => HospitalInfo) hospitals;
        mapping(address => mapping(address => DonorSet)) donorSets;
        mapping(address => mapping(address => UserSet)) userSets;
        mapping(address => mapping(address => AgentInfo)) agents;
        mapping(address => mapping(bytes32 => mapping(bool => DonorInfo))) isRegisteredDonor;
        mapping(address => mapping(bytes32 => UserInfo)) registeredUser;
}