//SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/SafeMath.sol";

// The only available version of SafeMath.sol at this time is 0.8.int208
// We migrated to that version to use the openzeppelin interface.

contract Crowdsale {
   using SafeMath for uint256;
 
   address public owner; // the owner of the contract
   address public escrow; // wallet to collect raised ETH
   uint256 public savedBalance; // Total amount raised in ETH (Initialization to zero has been removed)
   mapping (address => uint256) public balances; // Balances in incoming Ether
   
   event Ownable(address _address);
 
   // Initialization (changed to contructor in order to use the version 0.8.0 compatible with SafeMath)
   constructor(address _escrow) {
       owner = msg.sender;  // tx.origin has been replaced by msg.sender
       // add address of the specific contract
       escrow = _escrow;
   }
  
   // function to receive ETH (changed to fallback)
   fallback() external payable {
       require(msg.data.length == 0); // Data must be empty if only te receive ether
       balances[msg.sender] = balances[msg.sender].add(msg.value);
       savedBalance = savedBalance.add(msg.value);
       payable(escrow).transfer(msg.value);
   }
   
   receive() external payable {
       emit Ownable(owner);
   }
  
   // refund investisor
   function withdrawPayments() public{
       address payee = msg.sender;
       uint256 payment = balances[payee];
 
       balances[payee] = 0;
       savedBalance = savedBalance.sub(payment);
       
       payable(payee).transfer(payment);  // External call must be done efter state changes
   }
}
