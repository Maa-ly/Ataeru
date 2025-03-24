//SPDX-License_Identifier: MIT
pragma solidity 0.8.26; 

import{Structs} from "./dataTypes/structs.sol";

contract EntryPoint{

Structs.DonorInfo[] public donors;
Structs.UserInfo[] public users;
Structs.HospitalInfo[] public hospitals;

    function registerDonor() public {
        //TODO
    }

    function registerUser() public {
        //TODO
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


 function _addDonorToSet() public {}

 function _addUserToSet() public {}

 function getsetDonor() public view returns() {}

 function getsetUser() public {}

}