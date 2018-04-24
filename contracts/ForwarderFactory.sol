pragma solidity ^0.4.21;

import "./Forwarder.sol";

contract ForwarderFactory {

    event ContractDeployed(address forwarderAddress);
    
    function create(address beneficiary, uint256 number) public {
    
        for (uint256 i = 0; i < number; i++) { 
            emit ContractDeployed(new Forwarder(beneficiary));
        }
        
    }
}