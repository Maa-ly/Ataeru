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


//  struct HospitalInfo{
//         string name;
//         string email;
//         string location;
//         uint contact;
//         string about;
//         bytes32 witnessHash; // health document hash
//         bool isHospital;
//     }
    function registerHospital(address _ha, string memory _name, string memory _email, string memory _location,string memory _about, unit _contact, bytes32 _witnessHash) public returns(address){
        //TODO
        require(isHospital == false, "Hospital already registered");
        hospitals = Structs.HospitalInfo(_name, _email, _location, _contact, _about, _witnessHash);
        _hID = keccak256(abi.encode(hospitals));
        isHospital = true;
        registeredHospital[_ha][_hID] = hospitals;
        return _ha;
    }
 

 function deregisterDonor(bytes32 _diD) public {
    Structs.DonorInfo storage donor = registeredDonor[msg.sender][_diD];
   require(msg.sender == donor, "EntryPoint__You are not the owner of this donor");
   isDonor = false;
   delete registeredDonor[msg.sender][_diD];
   emit DonorDeregistered(msg.sender, _diD);
 }
 event DonorDeregistered(address indexed _donor, bytes32 indexed dId);

 function deregisterUser(bytes32 _uID) public {
     Structs.UserInfo storage user = registeredUser[msg.sender][_uID];
    require(msg.sender == user, "EntryPoint__You are not the owner of this user");
    isUser = false;
    delete registeredUser[msg.sender][_uID];
    emit UserDeregistered(msg.sender, _uID);
 }
 event UserDeregistered(address indexed _user, bytes32 indexed uId);

 function deregisterHospital(bytes32 _hID) public {
     Structs.HospitalInfo storage hospital = registeredHospital[add][_hID];
     isHospital = false;
        delete registeredHospital[add][_hID];
        emit HospitalDeregistered(add, _hID);
 }
event HospitalDeregistered(address indexed _hospital, bytes32 indexed hId);

 function updateDonorInfomation(bytes32 _diD, string memory _name, string memory _email, string memory _bloodGroup, string memory _location, uint256 _age, uint256 _weight, uint256 _height, uint256 _contant, string memory _about,  DonorType _donorType) public {
   Structs.DonorInfo storage donor = registeredDonor[msg.sender][_diD];
   require(msg.sender == donor, "EntryPoint__You are not the owner of this donor");
   donor.name = _name;
    donor.email = _email;
    donor.bloodGroup = _bloodGroup;
    donor.location = _location;
    donor.age = _age;
    donor.weight = _weight;
    donor.height = _height;
    donor.contact = _contant;
    donor.about = _about;
    donor.donorType = _donorType;
 emit DonorUpdated(_donor, _name, _email, _bloodGroup, _location, _age, _weight, _height, _contant, _about, _witnessHash, _donorType, dId);
    
 }
 event DonorUpdated(address indexed _donor, string _name, string _email, string _bloodGroup, string _location, uint256 _age, uint256 _weight, uint256 _height, uint256 _contant, string _about, bytes32 _witnessHash,  DonorType _donorType, bytes32 indexed dId);


 function updateUserInfomation(bytes32 _uID, string memory _name, string memory _email, string memory _location, string memory _contact, string memory _about, ReceiverType _receiverType) public {
    Structs.UserInfo storage user = registeredUser[msg.sender][_uID];
    require(msg.sender == user, "EntryPoint__You are not the owner of this user");
    user.name = _name;
     user.email = _email;
     user.location = _location;
     user.contact = _contact;
     user.about = _about;
     user.receiverType = _receiverType;

     emit UserUpdated(_user, _name, _email, _location, _contact, _about, _witnessHash, _receiverType, uId);
 }
 event UserUpdated(address indexed _user, string _name, string _email, string _location, uint256 _contact, string _about, bytes32 _witnessHash, ReceiverType _receiverType, bytes32 indexed uId);


 function updateHospitalInfomation(address _add, bytes32 _hID, string memory _name, string memory _email, string memory _location,string memory _about, unit _contact) public  {
    Structs.HospitalInfo storage hospital = registeredHospital[add][_hID];
    // use can call check
    hospital.name = _name;
    hospital.email = _email;
    hospital.location = _location;
    hospital.about = _about;
    hospital.contact = _contact;
 //   emit(_name, _email,_location,_contact, _about, _hID);
    emit HospitalUpdated(_name, _email, _location, _contact, _about, _hID);

 }
event HospitalUpdated(string _name, string _email, string _location, uint256 _contact, string _about, bytes32 _hID);


}