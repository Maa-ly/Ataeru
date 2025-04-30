// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

//import "@openzeppelin/contracts/proxy/clones.sol";
import "@openzeppelin/contracts/proxy/Clones.sol";
import "./HospitalRequestContract.sol";

contract HospitalRequestFactoryContract {
    using Clones for address;

    HospitalRequestContract requestContract;
    // RequestContract requestContract
    // let kaleel help with this
    //clone requests

    constructor(address _contract) public {
        requestContract = HospitalRequestContract(_contract.clone());
        requestContract.initialize();
    }
}
