//SPDX-License_Identifier: MIT
pragma solidity 0.8.26; 

lib Errors{

    error NotAdmin();
    error AdminAlreadySet();
    error AdminAlreadyPending();
    error AdminNotPending();
    error AdminNotSet();
    error AdminSelf();
    error AdminLimitReached();
    error AdminZeroAddress();
    error AdminNotZeroAddress();
    error AdminNotContract();
    error AdminContract();
    error AdminNotOwner();
    error CannotHaveZeroAdmins();
    error AdminNotSet();
   error  AppointeeNotSet()

   error AgentActivityAlreadyThat();

  

}