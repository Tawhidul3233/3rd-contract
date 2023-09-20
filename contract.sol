// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TokenManager {
    // Struct to represent a token
    struct Token {
        string name;
        string symbol;
        uint256 totalSupply;
    }

    // Array to store the list of created tokens
    Token[] public tokens;

    // Mapping to track token balances for each user by token symbol
    mapping(string => mapping(address => uint256)) public balances;

    // Event to log the creation of a new token
    event TokenCreated(string name, string symbol, uint256 totalSupply);

    // Function to create a new token
    function createToken(string memory name, string memory symbol, uint256 totalSupply) public {
        require(totalSupply > 0, "Total supply must be greater than zero");
        Token memory newToken = Token(name, symbol, totalSupply);
        tokens.push(newToken);
        balances[symbol][msg.sender] = totalSupply;
        emit TokenCreated(name, symbol, totalSupply);
    }

    // Function to transfer tokens to another address
    function transferToken(string memory symbol, address recipient, uint256 amount) public {
        require(balances[symbol][msg.sender] >= amount, "Insufficient balance");
        require(recipient != address(0), "Invalid recipient address");
        balances[symbol][msg.sender] -= amount;
        balances[symbol][recipient] += amount;
    }

    // Function to get the balance of a specific token for a given address
    function getBalanceByToken(string memory symbol, address account) public view returns (uint256) {
        return balances[symbol][account];
    }

    // Function to get the total number of created tokens
    function getTotalTokenCount() public view returns (uint256) {
        return tokens.length;
    }
}
