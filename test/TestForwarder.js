const Forwarder = artifacts.require("Forwarder.sol")

contract("Forwarder", async (accounts) => {

  beforeEach(async () => {
    this.forwarder = await Forwarder.new(accounts[0])
  })

  it("should forward eth sent to the contract to the owner", async () => {
    const prevBalance = web3.eth.getBalance(accounts[0]).toNumber()
    
    const { logs } = await this.forwarder.sendTransaction({ from: accounts[1], value: 2 * Math.pow(10, 18) })

    assert.equal(logs[0].event, "Transfer", "should be equal")

    const nextBalance = web3.eth.getBalance(accounts[0]).toNumber()
    const contractBalance = web3.eth.getBalance(this.forwarder.address).toNumber()

    assert.equal(nextBalance - prevBalance, 2 * Math.pow(10, 18), "should be equal")
    assert.equal(contractBalance, 0, "should be equal to zero")
  })

})