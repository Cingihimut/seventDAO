const SeventFinance = artifacts.require("SeventFinance")

module.exports = function(deployer) {
    deployer.deploy(SeventFinance)
};