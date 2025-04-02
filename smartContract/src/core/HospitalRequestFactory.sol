// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import "@openzeppelin/contracts/proxy/clones.sol";

contract HospitalRequestFactoryContract {
    use Clones for address;
HospitalRequestContract requestContract;
// RequestContract requestContract
// let kaleel help with this
//clone requests
    constructor(address _contract) public {
        requestContract = HospitalRequestContract(_contract.clone());
        requestContract.initialize();
    }
    


} 