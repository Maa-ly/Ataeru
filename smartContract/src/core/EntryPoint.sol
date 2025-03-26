//SPDX-License_Identifier: MIT
pragma solidity 0.8.26; 

import{Structs} from "./dataTypes/structs.sol";
import "../src/dataTypes/datastructures.sol";

contract EntryPoint is DataStructures{

Structs.DonorInfo public donors;
Structs.UserInfo public users;
Structs.HospitalInfo public hospitals;

event DonorRegistered(address indexed _donor, string _name, string _email, string _bloodGroup, string _location, uint256 _age, uint256 _weight, uint256 _height, uint256 _contant, string _about, bytes32 _witnessHash,  DonorType _donorType, bytes32 indexed dId);

//Add to enumerableset
//ToDo
    function registerDonor(string memory _name, string memory _email, string memory _bloodGroup, string memory _location, uint256 _age, uint256 _weight, uint256 _height, uint256 _contant, string memory _about, bytes32 _witnessHash,  DonorType _donorType) public returns(bytes32 _dId){
           require(isDonor == false, "Donor already registered");
              donors = Structs.DonorInfo(_name, _email, _bloodGroup, _location, _age, _weight, _height, _contant, _about, _witnessHash, _donorType);   
           _dId = keccak256(abi.encode(donors));
           isDonor = true;
           registeredDonor[msg.sender][_did][isDonor] = donors;

           return _dId;
          emit DonorRegistered(msg.sender, _name, _email, _bloodGroup, _location, _age, _weight, _height, _contant, _about, _witnessHash, _donorType, _dId); 
    }


event UserRegistered(address indexed _user, string _name, string _email, string _location, uint256 _contact, string _about, bytes32 _witnessHash, ReceiverType _receiverType, bytes32 indexed uId);
    function registerUser(string memory _name, string memory _email, string memory _location, string memory _contact, string memory _about, bytes32 _witnessHash, ReceiverType _receiverType) public returns(bytes32 _uId){ 
        
        require(isUser == false, "User already registered");
        users = Structs.UserInfo(_name, _email, _location, _contact, _about, _witnessHash, _receiverType);
        _uId = keccak256(abi.encode(users));
        isUser = true;
        registeredUser[msg.sender][_uId] = users;
        return _uId;
        emit UserRegistered(msg.sender, _name, _email, _location, _contact, _about, _witnessHash, _receiverType, _uId);
    }

    function registerHospital() public {
        //TODO
    }
 

 function deregisterDonor() public {}

 function deregisterUser() public {}

 function deregisterHospital() public {}


 function updateDonorInfomation() public {}


 function updateUserInfomation() public {}


 function updateHospitalInfomation() public {}



}