pragma solidity ^0.7.5;

contract Helloworld {

string message = "Hello to all members";
 
     function hello () public view returns (string memory) {
        
        return message;
    }

}