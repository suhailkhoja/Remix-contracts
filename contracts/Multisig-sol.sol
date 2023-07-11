pragma solidity ^0.7.5;
pragma abicoder v2;

contract Wallet {

    address[] public owners;
    uint limit;
    
    modifier onlyOwners() {
        bool owner = false;
        for(uint i=0; i<owners.length; i++) {
            if(owners[i] == msg.sender){
                owner = true;
            }
        }
        require(owner == true);
        _;
    }

    constructor(address [] memory _owners, uint _limit) {
        owners = _owners;
        limit = _limit;
    }

    function deposit() public payable{}
    
    struct Transfer {
        uint amount;
        address payable receiver;
        uint approvals;
        bool hasBeenSent;
        uint id;
    }

    event transferRequestCreated (uint _id, uint _amount, address _initiator, address _receiver);
    event ApprovalReceived (uint _id, uint _approvals, address _approver);
    event TranferApproved (uint _id);
    
    Transfer [] transferRequests;
    
    function createTransfer(uint _amount, address payable _receiver) public onlyOwners {
        emit transferRequestCreated(transferRequests.length, _amount, msg.sender, _receiver);
        transferRequests.push(Transfer(_amount, _receiver, 0, false, transferRequests.length));
    }
    
    mapping(address => mapping(uint => bool)) approvals;
    
    function approve (uint _id) public onlyOwners {
        require(transferRequests[_id].hasBeenSent == false);
        require(approvals[msg.sender][_id] == false, "You already voted");

        approvals[msg.sender][_id] = true;
        transferRequests[_id].approvals++;

        emit ApprovalReceived(_id, transferRequests[_id].approvals, msg.sender);

        if(transferRequests[_id].approvals >= limit) {
            transferRequests[_id].hasBeenSent = true;
            transferRequests[_id].receiver.transfer(transferRequests[_id].amount);
            emit TranferApproved (_id);
        }
    }

    function getTransferRequests() public view returns (Transfer[] memory) {
        return transferRequests;
    }

    function getBalance() public view returns(uint) {
        return address(this).balance;
    }

}

//["0x5B38Da6a701c568545dCfcB03FcB875f56beddC4", "0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2", "0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db"]