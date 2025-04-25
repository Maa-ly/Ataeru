// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import "smartContract/src/core/HRS.sol";
//import "@openzeppelin/contracts/token/ERC721/ERC721.sol"; // will build a uinque nft minting for process
import "@openzeppelin/contracts/access/Ownable.sol";
import "smartContract/src/core/HRS.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol"; 

contract Process is Initializable{

 // so there has to  be a type, donor type

 uint256 step = 1;
 uint256 stepToComplete ;
 address nftReceipt;

 function initialize(address __nftReceipt, uint256 __stepToComplete )public initializer {
    nftReceipt =  __nftReceipt;
    stepToComplete = __stepToComplete;

 }

struct ProcessInfo{
    StepDetails stepDetails;
    bool fin;
}


struct StepDetails{
    string stepName;
    uint40 startTime;
    uint40 endTime;
    address _user;
    bytes32 DonorInfoHash;
  uint256 DonorReputation;
StepGrade stepGrade;
  uint256 Hrid;
  string stepSummary;
  uint256 stepId;
  bool isStarted;
  bool isCompleted;
 
 // uint256 StepToComplete ;
}
enum StepGrade {
    A,
    B,
    C 
}

mapping(uint256 => StepDetails) public stepInfo;

 function makeStep(StepDetails[] details) public {
    require(HRS.isMemeberOfSet(details._user , details.Hrid));
    uint256 length = details.length;
    for(uint256 index = 0; index < length ; index ++){
        _makeStep(details[i]);
    }
    

 }

 function _makeStep(StepDetails _details) internal {
    uint256 stepid = step;
    step++;

    stepInfo[stepid] = StepDetails({
        stepName: _details.stepName,
        startTine: _details.startTime,
        endTime: _details.endTime,
        DonorInfoHash : _details.DonorInfoHash,
        DonorReputation : HRS.getUserReputation,
        stepGrade: _details.stepGrade,
        Hrid: _details.Hrid,
        stepSummary:_deatils.stepSummary,
        stepId: stepid,
        isStarted: false,
        isCompleted: false
       // fin : false
      //  StepToComplete : _StepToComplete 
    });

 }

function startStep(_stepId) public {
       StepDetails memory info = stepInfo[_stepId];

       require(info.startTime >= block.timestamp, "Process_ setp hasnt started yet");
       info.isStarted = true;

}

function completeStep(StepDetails _details) public {
    StepDetails memory info = stepInfo[_details.stepId];

   require(info.startTime >= block.timestamp, "Process_ setp hasnt started yet");

   info.isCompleted = true;
   //info.StepToComplete = info.StepToComplete - 1; // remove 
   stepToComplete = stepToComplete - 1;

}


 function updateStepInfoGrade(StepDetails _details) public {
      StepDetails memory info = stepInfo[_stepId];
      require(info.isCompleted == true, "Process__has not completed");
      info.stepGrade = _details.stepGrade;
 }


//Complete Process will call this
 function updateReputation(StepDetails) internal{
     StepDetails memory info = stepInfo[_stepId];
    // info.user; 
    require( stepToComplete == 0, "Process not completed");
    require(info.fin == false, "AlreadyUpdated");
      //require(info.isCompleted == true, "Process__has not completed");
      if(info.stepGrade == A){
      info.DonorReputation = HRS.getUserReputation + 10
      }
      if(info.stepGrade == B){
        info.DonorReputation = HRS.getUserReputation + 5
      }

      if(info.stepGrade == C){
        info.DonorReputation = info.DonorReputation + 2
      }
      if(info.stepGrade == F){
        info.DonorReputation = HRS.getUserReputation - 10 // can be negative repution will be int 
      }
      info.fin = true;
      HRS.modifyReputation(info.user, info.DonorReputation);
 }


// should be updateable since some conditions are unpredictable
function setStepsTocomple(uint256 _stepToComplete ){ //add access control
    stepToComplete = _stepToComplete ;
}
function setReceiptAddress(address _newNFTReceipt) public { // add access control
    nftReceipt =  _newNFTReceipt;

}

function processComplete() public {
    uint256 stepstocomplete = stepToComplete ;
    require (stepsToComplete == 0, "Process__ Steps isnt completed" );
    updateReputation();
   // _mint(nftReceipt); // fix this
}
    
}