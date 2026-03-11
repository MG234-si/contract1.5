// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Voting {
    struct Poll {
        string question;
        string[] options;
        uint256[] votes;
        mapping(address => bool) hasVoted;
    }

    Poll[] public polls;

    function createPoll(string memory _question, string[] memory _options) public {
        require(_options.length >= 2, "At least 2 options required");
        Poll storage newPoll = polls.push();
        newPoll.question = _question;
        newPoll.options = _options;
        newPoll.votes = new uint256[](_options.length);
    }

    function vote(uint256 _pollId, uint256 _optionIndex) public {
        require(_pollId < polls.length, "Invalid poll ID");
        require(!polls[_pollId].hasVoted[msg.sender], "Already voted");
        require(_optionIndex < polls[_pollId].options.length, "Invalid option");

        polls[_pollId].votes[_optionIndex]++;
        polls[_pollId].hasVoted[msg.sender] = true;
    }

    function getPoll(uint256 _pollId) public view returns (string memory question, string[] memory options, uint256[] memory votes) {
        Poll storage p = polls[_pollId];
        return (p.question, p.options, p.votes);
    }

    function getPollCount() public view returns (uint256) {
        return polls.length;
    }
}