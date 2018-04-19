pragma solidity ^0.4.21;

contract ERC20Basic {
    function totalSupply() public view returns (uint256);
    function balanceOf(address who) public view returns (uint256);
    function transfer(address to, uint256 value) public returns (bool);
    event Transfer(address indexed from, address indexed to, uint256 value);
}

contract Forwarder {
    // Address to which any funds (ETH or ERC20 token) sent to this contract will be forwarded
    address public beneficiary;

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
    }

    function sendTokens(ERC20Basic token) public {
        uint256 amount = token.balanceOf(this);

        token.transfer(beneficiary, amount);
    }

}