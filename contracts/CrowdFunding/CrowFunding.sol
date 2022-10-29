// SPDX-License-Identifier: UNLICENSED
pragma solidity >= 0.7.0 <0.9.0;

// TODO add only owner of contract can change status contract and he can not add funds himself
contract CrowFunding {

    string public id;
    string public name;
    string public description;
    address payable public author;
    string public state = "Opened";
    uint public funds;
    uint public fundraisingGoal;

    constructor(string memory _id, string memory _name, string memory _description, uint _fundraisingGoal) {
        id = _id;
        name = _name;
        description = _description;
        fundraisingGoal = _fundraisingGoal;
        author = payable(msg.sender);
    }

    function fundProject() public payable {
        author.transfer(msg.value); // wei (1 eth * ^e-18)
        funds += msg.value;
    }

    function changeProjectState(string calldata newState) public {
        state = newState;
    }
}
