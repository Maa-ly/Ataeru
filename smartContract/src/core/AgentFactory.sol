// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import "./DeployPersonalizedAI.sol";
import "../dataTypes/structs.sol";

contract AiAgentFactory is Structs {
    address[] public allAgents;

    event AgentDeployed(address agentAddress, address owner);

    function deployAiAgent(
        address hrs,
        address vop,
        uint256 nftId,
        string memory agentName,
        string memory _des,
       ActivityConfinment _act
    ) external returns (address agentAddress) {
        AiAgent newAgent = new AiAgent(hrs, vop);
        agentAddress = address(newAgent);

        
        newAgent.deployAiAgent(nftId, agentName, _des, _act,  agentAddress );

        allAgents.push(agentAddress);
        emit AgentDeployed(agentAddress, msg.sender);
    }
}
