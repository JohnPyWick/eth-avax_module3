// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MyToken {
    string public name;
    string public symbol;
    uint256 public totalSupply;
    mapping(address => uint256) public balanceOf;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Burn(address indexed from, uint256 value);
    event Mint(address indexed to, uint256 value);

    address public owner;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the contract owner can call this function");
        _;
    }

    constructor(string memory _name, string memory _symbol) {
        name = _name;
        symbol = _symbol;
        totalSupply = 0;
        owner = msg.sender;
    }

    function mint(address _to, uint256 _amount) public onlyOwner {
        require(_to != address(0), "Invalid address");
        require(_amount > 0, "Amount must be greater than zero");

        balanceOf[_to] += _amount;
        totalSupply += _amount;

        emit Mint(_to, _amount);
        emit Transfer(address(0), _to, _amount);
    }

    function burn(address _to, uint256 _amount) public {
        require(_to != address(0), "Invalid address");
        require(balanceOf[_to] >= _amount, "Insufficient balance");

        balanceOf[_to] -= _amount;
        totalSupply -= _amount;

        emit Burn(_to, _amount);
        emit Transfer(address(0), _to, _amount);
    }

    function transfer(address _to, address _from, uint256 _amount) public {
        require(_to != address(0), "Invalid address");
        require(_amount > 0, "Amount must be greater than zero");
        require(balanceOf[_from] >= _amount, "Insufficient balance");

        balanceOf[_from] -= _amount;
        balanceOf[_to] += _amount;

        emit Transfer(_from, _to, _amount);
    }
}

