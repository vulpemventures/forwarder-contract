pragma solidity ^0.4.21;

/**
 * @title SafeMath
 * @dev Math operations with safety checks that throw on error
 */
library SafeMath {

    /**
    * @dev Multiplies two numbers, throws on overflow.
    */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        if (a == 0) {
            return 0;
        }
        uint256 c = a * b;
        assert(c / a == b);
        return c;
    }

    /**
    * @dev Integer division of two numbers, truncating the quotient.
    */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        // assert(b > 0); // Solidity automatically throws when dividing by 0
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold
        return c;
    }

    /**
    * @dev Subtracts two numbers, throws on overflow (i.e. if subtrahend is greater than minuend).
    */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        assert(b <= a);
        return a - b;
    }

    /**
    * @dev Adds two numbers, throws on overflow.
    */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        assert(c >= a);
        return c;
    }
}

contract ERC20Basic {
    function totalSupply() public view returns (uint256);
    function balanceOf(address who) public view returns (uint256);
    function transfer(address to, uint256 value) public returns (bool);
    event Transfer(address indexed from, address indexed to, uint256 value);
}

contract MockToken is ERC20Basic {

    using SafeMath for uint256;

    uint256 public totalSupply_;
    mapping(address => uint256) public balances;
    uint256 public constant INITIAL_SUPPLY = 1000000000 * 10**uint256(8);
    
    /**
    * @dev Token Constructor
    */

    function MockToken() public {
        totalSupply_ = INITIAL_SUPPLY;   
        balances[msg.sender] = INITIAL_SUPPLY;
    }

    function balanceOf(address who) public view returns (uint256) {
        return balances[who];
    }

    function totalSupply() public view returns (uint256) {
        return totalSupply_;
    }

    function transfer(address beneficiary, uint256 amount) public returns (bool) {
        require(beneficiary != address(0));
        require(amount <= balances[msg.sender]);

        // SafeMath.sub will throw if there is not enough balance.
        balances[msg.sender] = balances[msg.sender].sub(amount);
        balances[beneficiary] = balances[beneficiary].add(amount);
        
        emit Transfer(msg.sender, beneficiary, amount);
        
        return true;
    }

}
