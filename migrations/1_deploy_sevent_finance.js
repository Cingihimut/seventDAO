const SeventFinance = artifacts.require("SeventFinance");
const PROXY = "0x0fd466C1b04Ad37502f1eE31392E398B2C01f29E";

module.exports = function(deployer) {
    deployer.deploy(SeventFinance)
};