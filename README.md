# Token Creation

## Description
Coding a smart contract to create your own token on a local HardHat network. 
From remix, the contract owner can mint tokens to a provided address and any user can burn and transfer tokens to a address.
## Steps to run this project

1. In the remix ide, create your smart contract of tokens.
2. Run the npx hardhat node command in your pc's terminal in order to connect your pc to the local hardhat network.

```
npx hardhat node

```
3. Change the environment in the remix to connect to hardhat provider make sure you have run the previous command in the terminal also.

4. Deploy your contract by giving your token a name and symbol.

5. Interact with it using fucntions.


### Code
```javascript
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

    function transfer(address _to, uint256 _amount) public {
        require(_to != address(0), "Invalid address");
        require(_amount > 0, "Amount must be greater than zero");
        require(balanceOf[msg.sender] >= _amount, "Insufficient balance");

        balanceOf[msg.sender] -= _amount;
        balanceOf[_to] += _amount;

        emit Transfer(msg.sender, _to, _amount);
    }
}

```

### Constructor to create Token
This contructor creates token when an instance of contract is deployed.
Token will have a name and symbol while creation.

```javascript
constructor(string memory _name, string memory _symbol) {
        name = _name;
        symbol = _symbol;
        totalSupply = 0;
        owner = msg.sender;
    }
```

### Mint Function

This function takes 2 parameters - address and amount.
Then it mints the token and adds it to the address specified.
It can only be run by the owner of the contract.

```javascript
function mint(address _to, uint256 _amount) public onlyOwner {
        require(_to != address(0), "Invalid address");
        require(_amount > 0, "Amount must be greater than zero");

        balanceOf[_to] += _amount;
        totalSupply += _amount;

        emit Mint(_to, _amount);
        emit Transfer(address(0), _to, _amount);
    }

```
### Burn Function
This function also takes 2 parameters - adrress and amount.
It burns the tokens in the address specified.
It can be used by users.

```javascript
 function burn(address _to, uint256 _amount) public {
        require(_to != address(0), "Invalid address");
        require(balanceOf[_to] >= _amount, "Insufficient balance");

        balanceOf[_to] -= _amount;
        totalSupply -= _amount;

        emit Burn(_to, _amount);
        emit Transfer(address(0), _to, _amount);
    }
```

### Transfer Function
This function also takes 3 parameters - adrress from,address to and amount.
It transfers the tokens from one address to the other.
It can be used by users.

```javacsript
function transfer(address _to, address _from, uint256 _amount) public {
        require(_to != address(0), "Invalid address");
        require(_amount > 0, "Amount must be greater than zero");
        require(balanceOf[_from] >= _amount, "Insufficient balance");

        balanceOf[_from] -= _amount;
        balanceOf[_to] += _amount;

        emit Transfer(_from, _to, _amount);
    }

```
## Authors

- [@JohnPyWick](https://github.com/JohnPyWick)


## License

This project is licensed under the MIT License - see the LICENSE.md file for details


