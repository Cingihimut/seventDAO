const SeventToken = artifacts.require("SeventToken")

module.exports = function(deployer) {
    deployer.deploy(SeventToken)
};