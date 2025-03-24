//SPDX-License_Identifier: MIT
pragma solidity 0.8.26; 

lib DataStructures{

mapping(address => DonorInfo) public donors;
mapping(address => UserInfo) public users;
mapping(address => HospitalInfo) public hospitals;
mapping(address => mapping(address => DonorSet)) public donorSets;
mapping(address => mapping(address => UserSet)) public userSets;


}