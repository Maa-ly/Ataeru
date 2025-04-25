// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import "../src/permissions/callable.sol";
import "../src/core/EntryPoint.sol";
import "../src/dataTypes/HRSstorage.sol";
contract HRC is Callable,  HRSDataStorage{

EntryPoint entry;
 HospitalRequestContract  requestContract;
 using  HRSStorage for Set;

struct SetParam{
    address hrs;
    uint256 id;
    bytes32 data;
}
//uint256 reputationPoint = 50;
mapping(uint256 => address) public userToRepuation;

// mapping(address => setParam) public registeredSet;
//   mapping(address hrs => EnumerableSet.UintSet) internal _sets;

constructor(address _entryPoint, address _requestContract) {
    entry = EntryPoint(_entryPoint);
    requestContract = HospitalRequestContract(_requestContract);
}

mapping(address => bool) public isRegisteredToHRS;
 function registerWithHRC(address user, uint256 _id, address _hrs) public isAdmin(address, msg.sender){
      Set storage set = Set({
        hrs: _hrs,
        id: _id
    });

    bytes32 _key = set.key();
    require(_sets[set.hrs].contains(_key), "HRS__Set does not exist");
    isRegisteredToHRS[msg.sender] = true;
    emit RegisteredWithHRC(user, _id, _hrs);
 }
 event RegisteredWithHRC(address indexed _user, uint256 indexed _id, address indexed _hrs);

/// first step is to requestBooking based on the hospital request
 function requestBooking(bytes32 _id, uint256 _rid) public canCall(){
    require(entry.isRequestExpired(_id), "HRS__Users must be registered");
    require(requestContract.isRequestExist(_rid), "HRS__Request does not exist");
    require(requestContract.isRequestExpired(_rid), "HRS__Request is expired");
    require(!requestContract.requestMaxDonor(_rid), "HRS__Request has max donor");
   // registeredBooking[msg.sender][_id] = _rid;
   registeredBooking[_rid] = Booking({
        id: _id,
        user:msg.sender,
       // rid: _rid,
        isBooked: true,
        createdAt: block.timestamp
    });
    emit BookingRequested(msg.sender, _id, _rid);
 }

 function cancelBooking(bytes32 _id, uint256 _rid) public isAdmin() {
    require(entry.isRequestExpired(_id), "HRS__Users must be registered");
    require(requestContract.isRequestExist(_rid), "HRS__Request does not exist");
    require(requestContract.isRequestExpired(_rid), "HRS__Request is expired");
    require(!requestContract.requestMaxDonor(_rid), "HRS__Request has max donor");
  //  registeredBooking[msg.sender][_id] = 0;
    registeredBooking[_rid] = Booking({
          id: _id,
          user:msg.sender,
         // rid: _rid,
          isBooked: false,
          createdAt: block.timestamp
     });
     emit BookingCancelled(msg.sender, _id, _rid);
 }

function getBookingStatus( uint256 _rid) public view returns (uint256) {
    return registeredBooking[_rid];
    }
 function acceptOrRejectBooking(address user, uint256 _rid) public canCall() {
    require(getBookingStatus.isBooked, "HRS__Booking is not booked");
 //  () = entry.getUsernDonorInfo(_id);
     _addToSet(user, _id, msg.sender, setParam);
    // entry.getUsernDonorInfo(_id);
    // requestContract.acceptOrRejectBooking(user, _rid);
    emit BookingAcceptedOrRejected(user, _rid); 
 }

 //function hospitalContractRequest() public {} // will remove and make a request contract

     struct RegistrationStatus {
        bool isRegistered;
     }
 function _addToSet(address _user, bytes32 _id, address hrs, SetParam setParam) public isAdmin{
    // check user is registered
    require(entry.isUserRegistered(_id), "HRS__User is not registered");

    Set storage set = Set({
        hrs: hrs,
        id: _id,
        data: setParam
    });

    //Add user to the set
    bytes32 _key = set.key();
   // _sets[set.hrs].add(_key);
     
    registeredSet[_user].add(_key);
    _setMembers[_key].add(_user);
    emit SetAdded(set.hrs, set.id, set.data);

     registrationStatus[_user][set.key()].isRegistered = true;
     registerWithHRC(user, _id, _hrs);
      userToRepuation[user] = 50;

 }
 event SetAdded(address indexed _hrs, uint256 indexed _id, bytes32 data);

function removeFromSet(address _user, bytes32 _id) public isAdmin{
    require(entry.isUserRegistered(_id), "HRS__User is not registered");
    Set storage set = Set({
        hrs: hrs,
        id: _id
    });

    bytes32 _key = set.key();
    require(_sets[set.hrs].contains(_key), "HRS__Set does not exist");
    //_sets[set.hrs].remove(_key);
    registeredSet[_user].remove(_key);
    _setMembers[_key].remove(_user);
    emit SetRemoved(set.hrs, set.id);
}
////////////////////////////////////////////////////
 mapping( Booking => uint256) public registeredBooking;

 function isMemeberOfSet(address _user, bytes _id) public returns(bool){
     Set memory set ;  
    bytes32 _key = set.key();
     require(_sets[set.hrs].contains(_key), "HRS__Set does not exist");
     require(  _setMembers[_key].contains(_user), "HRS__not memeber");
    return  isRegisteredToHRS[_user] == true;

 }

struct Booking {
    bytes32 id;
    address user;
    //uint256 rid;
    bool isBooked;
   
    uint256 createdAt;
}

function getUserReputation public returns(uint256){
     userToRepuation[msg.sender];
}

function modifyReputation(address user, uint256 newReputation) public {
    userToRepuation[user] =newReputation;
}
}