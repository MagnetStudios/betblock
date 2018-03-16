// var betorder = artifacts.require("./BetOrder.sol");
// var dispatchPrize = artifacts.require("./dispatchPrize.sol");
var betchain = artifacts.require("./betchain.sol");


module.exports = function(deployer) {
  // deployer.deploy(betorder);
  // deployer.deploy(dispatchPrize);
  deployer.deploy(betchain);
};
