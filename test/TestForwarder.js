const Forwarder = artifacts.require("Forwarder.sol")
const Token = artifacts.require("MockToken.sol")

contract("Forwarder", async (accounts) => {

  beforeEach(async () => {
    this.token = await Token.new()
    this.forwarder = await Forwarder.new(accounts[0])
  })

  it("should forward eth sent to the contract to the owner", async () => {
    const prevBalance = web3.eth.getBalance(accounts[0]).toNumber()
    
    await this.forwarder.sendTransaction({ from: accounts[1], value: 2 * Math.pow(10, 18) })

    const nextBalance = web3.eth.getBalance(accounts[0]).toNumber()
    const contractBalance = web3.eth.getBalance(this.forwarder.address).toNumber()

    assert.equal(nextBalance - prevBalance, 2 * Math.pow(10, 18), "should be equal")
    assert.equal(contractBalance, 0, "should be equal to zero")
  })

  it("should forward erc20 token sent to the contrat to the owner", async () =>  {
    const amount = 1000 * Math.pow(10, 8)

    await this.token.transfer(this.forwarder.address, amount, { from: accounts[0] })

    const prevBalance = await this.token.balanceOf(this.forwarder.address)
    
    assert.equal(prevBalance.toNumber(), amount, "should be equal")

    await this.forwarder.sendTokens(this.token.address);

    const nextBalance = await this.token.balanceOf(this.forwarder.address)
    const ownerBalance = await this.token.balanceOf(accounts[0])
    const totalSupply = await this.token.totalSupply()

    assert.equal(nextBalance.toNumber(), 0, "should be equal to zero")
    assert.equal(ownerBalance.toNumber(), totalSupply.toNumber(), "should be equal")
  })

})