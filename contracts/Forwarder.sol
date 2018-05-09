pragma solidity ^0.4.21;

contract Forwarder {
    // Address to which any funds (ETH) sent to this contract will be forwarded
    address public beneficiary;

    event Transfer(address _to, uint _value);
    /**
    * Create the contract, and sets the destination address to that of the creator
    */
    function Forwarder(address _beneficiary) public {
        beneficiary = _beneficiary;
    }

    /**
    * Default function; Gets called when Ether is deposited, and forwards it to the parent address
    */
    function() public payable {
        // throws on failure
        beneficiary.transfer(msg.value);

        emit Transfer(beneficiary, msg.value);
    }
}