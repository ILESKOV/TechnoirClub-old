// SPDX-License-Identifier: MIT
import "./utils/Ownable.sol";
import "./RobotMarketPlace.sol";

pragma solidity ^0.8.13;

contract RobotCore is Ownable, RobotMarketPlace {

  uint256 public constant CREATION_LIMIT_GEN0 = 10;

  // Counts the number of robots the contract owner has created.
  uint256 public gen0Counter;

  constructor(){
    // We are creating the first robot at index 0  
    _createRobot(0, 0, 0, type(uint).max, address(0));
  }

/*
       we get a 

       Basic binary operation

       >>> '{0:08b}'.format(255 & 1)
       '00000001'
       >>> '{0:08b}'.format(255 & 2)
       '00000010'
       >>> '{0:08b}'.format(255 & 4)
       '00000100'
       >>> '{0:08b}'.format(255 & 8)
       '00001000'
       >>> '{0:08b}'.format(255 & 16)
       '00010000'
       >>> '{0:08b}'.format(255 & 32)
       '00100000'
       >>> '{0:08b}'.format(255 & 64)
       '01000000'
       >>> '{0:08b}'.format(255 & 128)
       '10000000'

       So we use a mask on our random number to check if we will use the firstRobotParentId or the secondRobotParentID

       For example 205 is 11001101 in binary So
       firstRobotParent - firstRobotParent - secondRobotParent - secondRobotParent - firstRobotParent - firstRobotParent - secondRobotParent - firstRobotParent

*/
  function Modifying(uint256 _secondRobotParentId, uint256 _firstRobotParentId) public {
      require(_owns(msg.sender, _secondRobotParentId), "The user doesn't own the token");
      require(_owns(msg.sender, _firstRobotParentId), "The user doesn't own the token");

      require(_firstRobotParentId != _secondRobotParentId, "The robot can't modify himself without scheme of another robot");

      ( uint256 secondRobotParentId,,,,uint256 secondRobotParentGeneration ) = getRobot(_secondRobotParentId);

      ( uint256 firstRobotParentId,,,,uint256 firstRobotParentGeneration ) = getRobot(_firstRobotParentId);

      uint256 newRobotId;
      uint256 [8] memory IdArray;
      uint256 index = 7;
      uint8 random = uint8(block.timestamp % 255);
      uint256 i = 0;
      
      for(i = 1; i <= 128; i=i*2){

          /* We are */
          if(random & i != 0){
              IdArray[index] = uint8(firstRobotParentId % 100);
          } else {
              IdArray[index] = uint8(secondRobotParentId % 100);
          }
          firstRobotParentId /= 100;
          secondRobotParentId /= 100;
        index -= 1;
      }
     
      /* Add a random parameter in a random place */
      uint8 newIdIndex =  random % 7;
      IdArray[newIdIndex] = random % 99;

      /* We reverse the Id in the right order */
      for (i = 0 ; i < 8; i++ ){
        newRobotId += IdArray[i];
        if(i != 7){
            newRobotId *= 100;
        }
      }

      uint256 newRobotGeneration = 0;
      if (secondRobotParentGeneration < firstRobotParentGeneration){
        newRobotGeneration = firstRobotParentGeneration + 1;
        newRobotGeneration /= 2;
      } else if (secondRobotParentGeneration > firstRobotParentGeneration){
        newRobotGeneration = secondRobotParentGeneration + 1;
        newRobotGeneration /= 2;
      } else{
        newRobotGeneration = firstRobotParentGeneration + 1;
      }

      _createRobot(_firstRobotParentId, _secondRobotParentId, newRobotGeneration, newRobotId, msg.sender);
  }


  function createRobotGen0(uint256 _id) public onlyOwner {
    require(gen0Counter < CREATION_LIMIT_GEN0);

    gen0Counter++;

    // Gen0 have no owners they are own by the contract
    uint256 tokenId = _createRobot(0, 0, 0, _id, msg.sender);
    setOffer(0.2 ether, tokenId);
  }

  function getRobot(uint256 _id)
    public
    view
    returns (
    uint256 id,
    uint256 buildTime,
    uint256 firstRobotParentId,
    uint256 secondRobotParentId,
    uint256 generation
  ) {
    Robot storage robot = robots[_id];

    require(robot.buildTime > 0, "the robot doesn't exist");

    buildTime = uint256(robot.buildTime);
    firstRobotParentId = uint256(robot.firstRobotParentId);
    secondRobotParentId = uint256(robot.secondRobotParentId);
    generation = uint256(robot.generation);
    id = robot.id;
  }
}
