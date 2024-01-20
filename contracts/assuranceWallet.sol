
// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.0;
contract  assuranceWallet{

  address public owner;
  uint256 public myBalance;

  mapping(address => uint256) public wallets;


  event Deposit(address indexed account, uint256 amount);
  event Withdraw(address indexed account, uint256 amount);

  constructor() {
    owner = msg.sender;
    myBalance=msg.sender.balance;
  }

  modifier onlyOwner() {
    require(msg.sender == owner, "Only the owner can call this function");
    _;
  }

 
}