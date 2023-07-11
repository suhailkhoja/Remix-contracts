pragma solidity ^0.7.5;

contract Testing {
    string message;

    constructor (string memory _message) {
        message = _message;
    }

    function get () public pure returns (string memory) {
        return message;
    }
}