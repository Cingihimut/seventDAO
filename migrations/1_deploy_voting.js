const Voting = artifacts.require("Voting");

module.exports = function (deployer) {
    const votingTokenAddress = "0x0fd466C1b04Ad37502f1eE31392E398B2C01f29E";
    deployer.deploy(Voting, votingTokenAddress);
}