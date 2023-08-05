// contracts/Voting.sol
//SPDX-License-Identifier: MIT

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/Context.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/structs/EnumerableSet.sol";

pragma solidity ^0.8.19;

contract Voting is Ownable{
    using SafeMath for uint256;
    using EnumerableSet for EnumerableSet.AddressSet;

    struct Candidate {
        uint256 id;
        uint256 voteCountYes;
        uint256 voteCountNO;
        uint256 startTime;
        uint256 endTime;
    }
    EnumerableSet.AddressSet private votedUsers;

    IERC20 public votingToken;
    // Proposal[] public proposals;

    uint256 public candidatesCount;
    
    mapping(uint => Candidate) public candidates;
    mapping(address => mapping(uint256 => bool)) public hasVoted;

    event newVote(uint256 indexed proposalId, uint256 voteCountYes, uint256 voteCountNo);

    modifier onlyVotingToken() {
        require(address(votingToken) == 0x0fd466C1b04Ad37502f1eE31392E398B2C01f29E, "Invalid Token Address");
        _;
    }

    modifier hasNotVotedYet() {
        require(!votedUsers.contains(msg.sender), "Already Voted");
        _;
    }

    constructor(address _votingToken) {
        votingToken = IERC20(_votingToken);
    }

}