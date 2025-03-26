//SPDX-License_Identifier: MIT
pragma solidity 0.8.26; 

lib DataStructures{

mapping(address => DonorInfo) public donors;
mapping(address => UserInfo) public users;
mapping(address => HospitalInfo) public hospitals;
mapping(address => mapping(address => DonorSet)) public donorSets;
mapping(address => mapping(address => UserSet)) public userSets;

mapping(address mapping(address =>AgentInfo)) public agents; // maps the owner to the agent address to the agent info
bool isAgent;

  bool isDonor;

  mapping((address => bytes32) =>  mapping(bool => DonorInfo)) public is registeredDonor;

  mapping(address => bytes32 => UserInfo) public registeredUser;
}