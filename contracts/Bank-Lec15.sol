pragma solidity ^0.7.5;

import "./Ownable.sol";
import "./Destroyable.sol";

contract Bank is Ownable, Destroyable {
    mapping (address => uint) public balance;
    

event balanceAdded(uint amount, address depositedTo);
    

    function deposit() public payable returns (uint) {
        balance[msg.sender] += msg.value;
        emit balanceAdded (msg.value, msg.sender);
        return balance[msg.sender];
    }

    function withdraw (uint amount) public returns (uint) {
        //payable(msg.sender).transfer (amount);
        address toSend = 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2;
        payable(toSend).transfer(amount);
    }

    function totalBalance () public view returns (uint) {
        return address(this).balance;
    }

    function getBalance () public view returns (uint) {
        return balance[msg.sender];
    }

    function getOwner() public view returns(address) {
        return owner;
    }


    function transfer(address recipient, uint amount) public onlyOwner {
        
        require (msg.sender != recipient, "Sender and recipient couldn't be same");
        require (balance [msg.sender] >= amount, "You don't have sufficient funds to send.");
        uint previousSenderBalance = balance[msg.sender];
        balance [msg.sender] -= amount;
        balance [recipient] += amount;

        assert (balance[msg.sender] == previousSenderBalance - amount);

    }
}