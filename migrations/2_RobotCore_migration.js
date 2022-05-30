const RobotCore = artifacts.require("./RobotCore");

module.exports = function(deployer) {
  deployer.deploy(RobotCore);
};

