const SushiSwapChallenge = artifacts.require("SushiSwapChallenge");

module.exports = function (deployer) {
  deployer.deploy(SushiSwapChallenge,"0xd9e1cE17f2641f24aE83637ab66a2cca9C378B9F",//sushiRouter
  "0x6b3595068778dd592e39a122f4f5a5cf09c90fe2",//sushi
  "0x6B175474E89094C44Da98b954EedeAC495271d0F",//DAI
    "0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f" );//factory
};
