// const SeventFinance = artifacts.require("SeventFinance");
// const { BN, expectRevert } = require("@openzeppelin/test-helpers");

// contract("SeventFinance", (accounts) => {
//   let seventFinance;

//   // Deploy the contract before each test case
//   beforeEach(async () => {
//     seventFinance = await SeventFinance.new();
//   });

//   it("should have the correct name and symbol", async () => {
//     const name = await seventFinance.name();
//     const symbol = await seventFinance.symbol();

//     assert.equal(name, "SeventFinance", "Name should be SeventFinance");
//     assert.equal(symbol, "Sevent", "Symbol should be Sevent");
//   });

//   it("should have the correct initial total supply", async () => {
//     const totalSupply = await seventFinance.totalSupply();

//     assert.equal(
//       totalSupply.toString(),
//       "200000000000000000000000000",
//       "Initial total supply should be 200,000,000"
//     );
//   });

//   it("should allow transfer between accounts", async () => {
//     const amount = web3.utils.toBN("1000000000000000000"); // 1 token

//     await seventFinance.transfer(accounts[4], amount, {
//       from: accounts[0],
//     });

//     const account1Balance = await seventFinance.balanceOf(accounts[1]);
//     const account0Balance = await seventFinance.balanceOf(accounts[0]);

//     assert.equal(
//       account1Balance.toString(),
//       amount.toString(),
//       "Account 1 balance should be 1 token"
//     );
//     assert.equal(
//       account0Balance.toString(),
//       "199999999000000000000000000",
//       "Account 0 balance should be decreased by 1 token"
//     );
//   });

//   it("should allow transfer between accounts", async () => {
//       const amount = new BN("1000000000000000000"); // 1 token
      
//       await seventFinance.transfer(accounts[1], amount, {
//           from: accounts[0],
//     });

//     const account1Balance = await seventFinance.balanceOf(accounts[1]);
//     const account0Balance = await seventFinance.balanceOf(accounts[0]);

//     assert.equal(
//       account1Balance.toString(),
//       amount.toString(),
//       "Account 1 balance should be 1 token"
//     );
//     assert.equal(
//       account0Balance.toString(),
//       new BN("199999999000000000000000000").toString(),
//       "Account 0 balance should be decreased by 1 token"
//       );
//     });
// });