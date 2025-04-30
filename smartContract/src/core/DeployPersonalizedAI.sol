// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import "./NftContract.sol";
import "../dataTypes/datastructures.sol";
import "../dataTypes/structs.sol";
import "../permissions/callable.sol";
import "../core/HRS.sol";
import "../core/VerificationOfParties.sol";

contract AiAgent is DataStructures {
    ProfileImageNfts internal mft;
    Structs.AgentInfo public agentInfo;
    Callable public canCall;
    HRS public hrs;
    VerificationOfParties public vop;

    constructor(address _hrs, address _vop) {
        hrs = HRS(_hrs);
        vop = VerificationOfParties(_vop);
    }

    function deployAiAgent(uint256 nftId, string memory agentName, string memory _des, ActivityConfinment _act)
        public
        returns (address agentAddress)
    {
        require(mft.ownerOf(nftId) == msg.sender, "You are not the owner of this NFT");

        agentInfo = Structs.AgentInfo({
            agentName: agentName,
            description: _des,
            activityConfinment: _act,
            nftId: nftId,
            //isAgent: true,
            status: Structs.AgentInfo.AgentStatus.DEPLOYED
        });

        agentAddress = address(new AiAgent(nftId, agentName, _des, _act));
        agents[msg.sender][agentAddress] = agentInfo;
        isAgent = true;

        _addAgentPermission(_act);

        return agentAddress; //Address to be added to premission based on permission type
    }

    function cancelAgent(address agentAddress) public {
        require(
            agents[msg.sender][agentAddress].status == Structs.AgentInfo.AgentStatus.DEPLOYED, "Agent is not deployed"
        );
        agents[msg.sender][agentAddress].status = Structs.AgentInfo.AgentStatus.CANCELLED;
        //(activity )= getAgentPermsission(agentAddress);
    }

    function reactivateAgent(address agentAddress) public {
        require(
            agents[msg.sender][agentAddress].status == Structs.AgentInfo.AgentStatus.CANCELLED, "Agent is not cancelled"
        );
        agents[msg.sender][agentAddress].status = Structs.AgentInfo.AgentStatus.DEPLOYED;
    }

    function updateAgent(address agentAddress, string memory agentName, string memory _des, ActivityConfinment _act)
        public
    {
        // check for ownaship

        // check old activity permision
        (activity) = getAgentPermsission(agentAddress);
        require(activity != _act, AgentActivityAlreadyThat());

        if (
            activity == agentInfo.ActivityConfinment.BOOKING || activity == agentInfo.ActivityConfinment.FULL
                || activity == agentInfo.ActivityConfinment.VERIFYAUTHENTICITY
        ) {
            _removeAgentPermission(activity);
        }

        require(
            agents[msg.sender][agentAddress].status == Structs.AgentInfo.AgentStatus.DEPLOYED, "Agent is not deployed"
        );
        agents[msg.sender][agentAddress].agentName = agentName;
        agents[msg.sender][agentAddress].description = _des;
        agents[msg.sender][agentAddress].activityConfinment = _act;

        _addAgentPermission(_act);
    }

    function getAgentInfo(address agentAddress) public view returns (Structs.AgentInfo memory) {
        return agents[msg.sender][agentAddress];
    }

    function _addAgentPermission(Struct.agentInfo.ActivityConfinment activity) internal {
        if (activity == Structs.AgentInfo.ActivityConfinment.BOOKING) {
            canCall.setAppointee(msg.sender, address(agentAddress), address(hrs), hrs.requestBooking.selector);
        }
        if (activity == Structs.AgentInfo.ActivityConfinment.FULL) {
            canCall.addAdmin(msg.sender, address(agentAddress));
        }
        if (activity == Structs.AgentInfo.ActivityConfinment.VERIFYAUTHENTICITY) {
            canCall.addAppointee(msg.sender, address(agentAddress), address(vop), vop.verifyAiAgent.selector);
        }
        //   canCall.addAdmin(msg.sender, address(this));
    }

    function _removeAgentPermission(Struct.agentInfo.ActivityConfinment activity) internal {
        if (activity == Structs.AgentInfo.ActivityConfinment.BOOKING) {
            canCall.removeAppointee(msg.sender, address(agentAddress), address(hrs), hrs.requestBooking.selector);
        }
        if (activity == Structs.AgentInfo.ActivityConfinment.FULL) {
            canCall.removeAdmin(msg.sender, address(agentAddress));
        }
        if (activity == Structs.AgentInfo.ActivityConfinment.VERIFYAUTHENTICITY) {
            canCall.removeAppointee(msg.sender, address(agentAddress), address(vop), vop.verifyAiAgent.selector);
        }
    }

    function getAgentPermsission(address agentAddress)
        public
        view
        returns (Structs.AgentInfo.ActivityConfinment activity)
    {
        return agents[msg.sender][agentAddress].activityConfinment;
    }
}
