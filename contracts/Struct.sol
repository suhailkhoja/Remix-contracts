pragma solidity ^0.8.0;

contract Team {

    Player [] public players;

    struct Player {
        string firstName;
        string lastName;
        uint age;
        }

        function addPlayer(string memory _firstName, string memory _lastName, uint _age) public {
            players.push (Player(_firstName, _lastName, _age));
        }
}
