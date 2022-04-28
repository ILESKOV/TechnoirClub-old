// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract RobotFactory {

  
// A new robot is build
  
event Build( address owner, 
             uint256 robotId, 
             uint256 firstRobotParentId,
             uint256 secondRobotParentId, 
             uint256 id);

  
//A robot has been transfer
  
event Transfer( address indexed from, 
                address indexed to, 
                uint256 indexed tokenId);



struct Robot { 
              uint256 id;
              uint64 buildTime;
              uint32 firstRobotParentId;
              uint32 secondRobotParentId;
              uint16 generation;
              }

   Robot[] robots;

  mapping (uint256 => address) public robotIndexToOwner;
  mapping (address => uint256) ownershipTokenCount;

  // Add a list of approved robots, that are allowed to be transfered
  mapping (uint256 => address) public robotIndexToApproved;

  function _createRobot(
              uint256 _firstRobotParentId,
              uint256 _secondRobotParentId,
              uint256 _generation,
              uint256 _id,
              address _owner
    ) 
    internal returns (uint256) 
    {
        Robot memory _robot = Robot({
            id: _id,
            buildTime: uint64(block.timestamp),
            firstRobotParentId: uint32(_firstRobotParentId),
            secondRobotParentId: uint32(_secondRobotParentId),
            generation: uint16(_generation)
        });

        robots.push(_robot);
        uint newRobotId = robots.length - 1;

    // It's probably never going to happen, 4 billion robotss is A LOT, but
    // let's just be 100% sure this never happen.
    require(newRobotId == uint256(uint32(newRobotId)));

    // emit the build event
    emit Build(
        _owner,
        newRobotId,
        uint256(_robot.firstRobotParentId),
        uint256(_robot.secondRobotParentId),
        _robot.id
    );

    // This will assign ownership, and also emit the Transfer event as
    // per ERC721 draft
    _transfer(address(0), _owner, newRobotId);
    return newRobotId;
  }

  function _transfer(address _from, address _to, uint256 _tokenId) internal {

    // Since the number of robots is capped to 2^32 we can't overflow this
    ownershipTokenCount[_to]++;
    // transfer ownership
    robotIndexToOwner[_tokenId] = _to;

    if (_from != address(0)) {
        ownershipTokenCount[_from]--;

        delete robotIndexToApproved[_tokenId];
    }

    // Emit the transfer event.
    emit Transfer(_from, _to, _tokenId);
  }
}
