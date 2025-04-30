//SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

library ErrorStuff {
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
    error AppointeeAlreadySet();
    //  error AdminNotSet();
    error AppointeeNotSet();

    error AgentActivityAlreadyThat();
}
