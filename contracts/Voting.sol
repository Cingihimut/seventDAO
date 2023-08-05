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

    struct Proposal {
        uint256 id;
        uint256 voteCountYes;
        uint256 voteCountNO;
        uint256 startTime;
        uint256 endTime;
    }
    EnumerableSet.AddressSet private votedUsers;

    IERC20 public votingToken;
    Proposal[] public proposals;

    uint256 public candidatesCount;
    
    mapping(address => mapping(uint256 => bool)) public hasVoted;

    event NewVote(uint256 indexed proposalId, uint256 voteCountYes, uint256 voteCountNo);

    modifier onlyVotingToken() {
        require(address(votingToken) == 0x0fd466C1b04Ad37502f1eE31392E398B2C01f29E, "Invalid Token Address");
        _;
    }

    modifier hasNotVotedYet() {
        require(!votedUsers.contains(msg.sender), "Already Voted");
        _;
    }

    constructor(address _votingToken) {
        require(_votingToken == 0x0fd466C1b04Ad37502f1eE31392E398B2C01f29E);
        votingToken = IERC20(_votingToken);
    }

    function createProposals(uint256 _durationInDay) public onlyVotingToken {
        uint256 proposalId = proposals.length; 
        uint256 startTime = block.timestamp;
        uint256 endTime = startTime.add(_durationInDay.mul(1 days));
        proposals.push(Proposal (proposalId, startTime, endTime, 0, 0));
    }

    function getProposal(uint256 _proposalId) public view returns(uint256, uint256, uint256, uint256, uint256, bool){
        Proposal storage proposal = proposals[_proposalId];
        uint256 currentTime = block.timestamp;
        bool isVotingOpen = currentTime >= proposal.startTime && currentTime <= proposal.endTime;

        return (
            proposal.id,
            proposal.startTime,
            proposal.endTime,
            proposal.voteCountYes,
            proposal.voteCountNO,
            isVotingOpen
        );
    }

    function vote(uint256 _proposalId, bool _voteYes) external onlyVotingToken {
        require(_proposalId < proposals.length, "Invalid Proposal Id");

        Proposal storage proposal = proposals[_proposalId];
        require(block.timestamp > proposal.startTime && block.timestamp <= proposal.endTime, "Voting Not Allowed Now");

        hasVoted[msg.sender][_proposalId] = true;

        if(_voteYes) {
            proposal.voteCountYes = proposal.voteCountYes.add(1);
        }
        else {
            proposal.voteCountNO = proposal.voteCountNO.add(1);
        }

        votedUsers.add(msg.sender);

        emit NewVote(_proposalId, proposal.voteCountYes, proposal.voteCountNO);

    } 

    function getProposalId(uint256 _proposalId) external view returns(uint) {
        require(_proposalId < proposals.length, "Invalid Proposal Id");
        return(proposals[_proposalId].id);
    }

    function getVoteCounts(uint256 _proposalId, bool _voteYes) external view returns(uint) {
        require(_proposalId < proposals.length, "Invalid Proposal Id");
        Proposal storage proposal = proposals[_proposalId];
        return _voteYes ? proposal.voteCountYes : proposal.voteCountNO;
    }

    function getProposalCount() external view returns(uint) {
        return proposals.length;
    }

}