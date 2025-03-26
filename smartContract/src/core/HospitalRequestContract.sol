// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import "../src/dataTypes/structs.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
contract HospitalRequestContract is Initializable {

uint256 public id;
address public hospitalAddress;
Structs.HospitalRequest public hospitalRequest;
uint256 maxDonor;

mapping(address => mapping(uint256 => HospitalRequest)) public hospitalRequests;


function initialize(address _hospitalAddress, uint256 _maxDonor) public initializer {
    hospitalAddress = _hospitalAddress;
    maxDonor = _maxDonor;
}
function makeADonorRequest( DonorType _donorType, string memory _rules, uint256 _date, uint256 _time, uint256 _maxDonor, uint256 _minAmount, uint256 _maxAmount, RequestStatus _status, string memory _des ) public returns(uint256 _id) {

hospitalRequest = 
Structs.HospitalRequest(_donorType, _rules, _date, _time, _maxDonor, _minAmount, _maxAmount, _status, _des, true);

id = id + 1;
hospitalRequests[hospitalAddress][id] = hospitalRequest;
return id;
}

function makeMultipleDonorRequest(DonorType[] _donorType, string[] memory _rules, uint256[] _date, uint256[] _time, uint256[] _maxDonor, uint256[] _minAmount, uint256[] _maxAmount, RequestStatus[] _status, string[] memory _des )  public returns(uint256 _id){

    for(uint256 i = 0; i < _donorType.length; i++) {
        hospitalRequest = 
        Structs.HospitalRequest(_donorType[i], _rules[i], _date[i], _time[i], _maxDonor[i], _minAmount[i], _maxAmount[i], _status[i], _des[i], true[i]);
        _id = id + 1;
        hospitalRequests[hospitalAddress][id] = hospitalRequest;

        return _id;
    }
}

function isRequestExpired(uint256 _id) public view returns(bool) {
    if(hospitalRequests[hospitalAddress][_id].date > block.timestamp) {
        return true;
    }
    return false;
}
function requestMaxDonor(uint256 _id) public view returns(bool) {
    return hospitalRequests[hospitalAddress][_id].maxDonors == maxDonor;
}
function isRequestExist(uint256 _id) public view returns(bool) {
    if(hospitalRequests[hospitalAddress][_id].isActive == true) {
        return true;
    }
    return false;
}

function getRequest(uint256 _id) public view returns(Structs.HospitalRequest memory) {
        return hospitalRequests[hospitalAddress][_id];
        
        }


   
}