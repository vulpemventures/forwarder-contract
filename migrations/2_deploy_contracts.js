const ForwarderFactory = artifacts.require("./ForwarderFactory.sol")

module.exports = function(deployer, network, accounts) {
  deployer.deploy(ForwarderFactory)
}