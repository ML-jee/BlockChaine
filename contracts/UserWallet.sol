// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./InsuranceContract.sol";

contract UserWallet {
  address public owner;
  mapping(address => uint256) public balances;
  InsuranceContract[] public insuranceContracts;

  event Deposit(address indexed account, uint256 amount);
  event Withdraw(address indexed account, uint256 amount);

  constructor() {
    owner = msg.sender;
  }

  modifier onlyOwner() {
    require(msg.sender == owner, "Only the owner can call this function");
    _;
  }

  function deposit() external payable {
    balances[msg.sender] += msg.value;
    emit Deposit(msg.sender, msg.value);
  }

  function withdraw(uint256 amount) external {
    require(amount <= balances[msg.sender], "Insufficient balance");
    balances[msg.sender] -= amount;
    payable(msg.sender).transfer(amount);
    emit Withdraw(msg.sender, amount);
  }

  function createInsuranceContract(uint256 premium) external onlyOwner {
    InsuranceContract newContract = new InsuranceContract(premium);
    insuranceContracts.push(newContract);
  }
}
