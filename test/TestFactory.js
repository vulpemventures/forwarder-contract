const Factory = artifacts.require("ForwarderFactory.sol")

contract("ForwarderFactory", async (accounts) => {

  beforeEach(async () => {
    this.factory = await Factory.new()
  })

  it("should create some forwarder contract", async () => {
    const { logs } = await this.factory.create(2)

    assert.equal(logs[0].event, "ContractDeployed", "event is incorrect")
    assert.equal(logs[1].event, "ContractDeployed", "event is incorrect")
  })

  it("should not create more than 50 forwarders at once", async () => {
    try {
      await this.factory.create(51)

      assert.fail("should have thrown before")
    } catch(error) {
      assert.isAbove(error.message.search("revert"), -1, error.message)
    }
  })

})