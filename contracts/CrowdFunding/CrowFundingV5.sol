// SPDX-License-Identifier: UNLICENSED
pragma solidity >= 0.7.0 <0.9.0;

contract CrowFundingV5 {

    string public id;
    string public name;
    string public description;
    address payable public author;
    uint public state;
    uint public funds;
    uint public fundraisingGoal;

    event ProjectStatedChanged(string id, uint state);
    event ProjectFunded(string id, uint value);

    modifier isAuthor() {
        require(msg.sender == author, "You need to be the project author");
        _;
    }

    modifier isNotAuthor() {
        require(msg.sender != author, "As author you can not fund your own project");
        _;
    }

    constructor(string memory _id, string memory _name, string memory _description, uint _fundraisingGoal) {
        id = _id;
        name = _name;
        description = _description;
        fundraisingGoal = _fundraisingGoal;
        author = payable(msg.sender);
    }

    function fundProject() public isNotAuthor payable {
        require(state != 1, "The project can not receive funds");
        author.transfer(msg.value); // wei (1 eth * ^e-18)
        funds += msg.value;
        emit ProjectFunded(id, msg.value);
    }

    function changeProjectState(uint newState) public isAuthor {
        require(state == newState, "New state must be different");
        state = newState;
        emit ProjectStatedChanged(id, newState);
    }
}
