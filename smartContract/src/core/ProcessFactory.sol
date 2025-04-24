// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import "@openzeppelin/contracts/proxy/clones.sol";

contract ProcessFactoryContract {
    use Clones for address;
Process processContract;
// RequestContract requestContract
// let kaleel help with this
//clone requests
    constructor(address _contract) public {
        processContract = Process(_contract.clone());
        processContract.initialize();
    }
    


} 