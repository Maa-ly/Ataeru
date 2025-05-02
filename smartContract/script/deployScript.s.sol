// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;
import {Script} from "forge-std/Script.sol";
import {FixedPriceOracle} from "../src/Oracle/FixedPriceOracle.sol";
import {AiAgent} from "../src/core/DeployPersonalizedAI.sol";
import {EntryPoint} from "../src/core/EntryPoint.sol";
import {HealthDataNFT } from "../src/core/HealthDataNFT.sol";
import {HospitalRequestContract} from "../src/core/HospitalRequestContract.sol";
import {HospitalRequestFactoryContract } from "../src/core/HospitalRequestFactory.sol";
import { HRC} from "../src/core/HRS.sol";
import {MarketPlace} from "../src/core/MarketPlace.sol";
import {ProfileImageNfts} from "../src/core/NftContract.sol";
import { Process} from "../src/core/Process.sol";
import {ProcessFactoryContract} from "../src/core/ProcessFactory.sol";
import { VerificationOfParties } from "../src/core/VerificationOfParties.sol";
import  "../src/core/reward.sol";
import "forge-std/console.sol";


contract DeployScript is Script {
FixedPriceOracle oracle;
AiAgent ai;
EntryPoint entry;
HealthDataNFT hnft;
HospitalRequestContract requestContract;
HospitalRequestFactoryContract requestFactory;
HRC hrc;
MarketPlace market;
ProfileImageNfts pnft;
Process process;
ProcessFactoryContract processFactory;
VerificationOfParties verification;

RewardContract reward;


    // function run() public {
    //     vm.createSelectFork(vm.rpcUrl("anvil"));
    //     vm.startBroadcast();
    //     oracle = new FixedPriceOracle();
    //     ai = new AiAgent();
    //     entry = new EntryPoint();
    //     hnft = new HealthDataNFT();
    //     requestFactory= new HospitalRequestFactoryContract ();
    //     requestContract = new HospitalRequestContract ();
    //     hrc =  new HRC();
    //     market = new MarketPlace();
    //     pnft = new ProfileImageNfts();
    //     process = new Process();
    //     processFactory = new ProcessFactoryContract ();
    //     verification = new VerificationOfParties();
    //     reward = new RewardContract();
    //     vm.stopBroadcast();
    // }
}