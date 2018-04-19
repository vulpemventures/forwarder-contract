pragma solidity ^0.4.21;

import "./Forwarder.sol";

contract ForwarderFactory {
    address[] public contracts;

    event ContractDeployed(address forwarderAddress);
    
    function create(uint256 number) public {
        require(number <= 50);

        for (uint256 i = 0; i < number; i++) { 
            address _contract = new Forwarder(msg.sender);

            contracts.push(_contract);

            emit ContractDeployed(_contract);
        }
    }
}