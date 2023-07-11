pragma solidity ^0.7.5;

contract Ownable {
    address internal owner;
    modifier onlyOwner {
        require (owner == msg.sender, "You are not the owner");
        _;
    }

    constructor () {
        owner = msg.sender;
    }
}