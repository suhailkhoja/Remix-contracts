pragma solidity ^0.8.6;

contract Bank {
    mapping (address => uint) balance;

    function addBalance(uint _toAdd) public returns (uint) {
        balance[msg.sender] += _toAdd;
        return balance[msg.sender];
    } 

    function getBalance () public view returns (uint) {
        return balance[msg.sender];
    }

    function transfer(address recipient, uint amount) public {
        require (msg.sender != recipient, "Sender and recipient couldn't be same");
        require (balance [msg.sender] >= amount, "You don't have sufficient funds to send.");
        balance [msg.sender] -= amount;
        balance [recipient] += amount;

    }
}