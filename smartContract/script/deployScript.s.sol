// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;
import {Script} from "forge-std/Script.sol";
import{FixedPriceOracle} from "smartContract/src/Oracle/FixedPriceOracle.sol";
import {AiAgent} from "smartContract/src/core/DeployPersonalizedAI.sol";
import {EntryPoint} from "smartContract/src/core/EntryPoint.sol";
import {HealthDataNFT } from "smartContract/src/core/HealthDataNFT.sol";
import {HospitalRequestContract} from "smartContract/src/core/HospitalRequestContract.sol";
import {HospitalRequestFactoryContract } from "smartContract/src/core/HospitalRequestFactory.sol";
import { HRC} from "smartContract/src/core/HRS.sol";
import {MarketPlace} from "smartContract/src/core/MarketPlace.sol";
import {ProfileImageNfts} from "smartContract/src/core/NftContract.sol";
import{ Process} from "smartContract/src/core/Process.sol";
import{ProcessFactoryContract} from "smartContract/src/core/ProcessFactory.sol";
import{ VerificationOfParties } from "smartContract/src/core/VerificationOfParties.sol";
import {RewardContract} from "smartContract/src/core/reward.sol";
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


    function run() public {
        vm.createSelectFork(vm.rpcUrl("anvil"));
        vm.startBroadcast();
        oracle = new FixedPriceOracle();
        ai = new AiAgent();
        entry = new EntryPoint();
        hnft = new HealthDataNFT();
        requestFactory= new HospitalRequestFactoryContract ();
        requestContract = new HospitalRequestContract ();
        hrc =  new HRC();
        market = new MarketPlace();
        pnft = new ProfileImageNfts();
        process = new Process();
        processFactory = new ProcessFactoryContract ();
        verification = new VerificationOfParties();
        reward = new RewardContract();
        vm.stopBroadcast();
    }
}