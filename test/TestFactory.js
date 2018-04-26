const fs = require('fs')
const abiDecoder = require('abi-decoder')
const Factory = artifacts.require("ForwarderFactory.sol")

abiDecoder.addABI(Factory.abi)

contract("ForwarderFactory", async (accounts) => {

  beforeEach(async () => {
    this.factory = await Factory.new()
  })

  it("should create some forwarder contract", async () => {
    const { receipt, logs } = await this.factory.create(accounts[1], 2)
    
    // for testing purpose
    assert.equal(logs[0].event, "ContractDeployed", "event is incorrect")
    assert.equal(logs[1].event, "ContractDeployed", "event is incorrect")

    // for storage purpose
    fs.writeFileSync('events.json', JSON.stringify(abiDecoder.decodeLogs(receipt.logs), null, 2))
  })

})