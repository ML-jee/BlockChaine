// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

contract AssuranceWallet is Ownable {

    // No need to declare 'owner' again, it's already declared in Ownable

    struct Transaction {
        uint256 transactionId;
        address walletSender;
        address walletReceiver;
        uint256 amount;
        uint256 date;
        bool isApproved;
        bytes32 signature;
    }

    Transaction[] public transactions;

    mapping(address => uint256) public wallets;

    event Deposit(address indexed account, uint256 amount);
    event Withdraw(address indexed account, uint256 amount);

    modifier onlytheOwner() {
        require(msg.sender == owner(), "Only owner can call this function");
        _;
    }

    modifier walletExists(address _wallet) {
        require(wallets[_wallet] > 0, "Wallet does not exist");
        _;
    }

    modifier sufficientBalance(address _wallet, uint256 _amount) {
        require(wallets[_wallet] >= _amount, "Insufficient funds");
        _;
    }

    // Constructor to set the owner to the account that deploys the contract
    constructor(address initialOwner) Ownable(initialOwner) {
        _transferOwnership(msg.sender);
    }

    function changeOwner(address _newOwner) public onlyOwner {
        _transferOwnership(_newOwner);
    }

    function addWallet(address _wallet) public onlyOwner {
        wallets[_wallet] = 0;
    }

    function deposit() public payable {
        wallets[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    function withdraw(uint256 _amount) public walletExists(msg.sender) sufficientBalance(msg.sender, _amount) {
        wallets[msg.sender] -= _amount;
        payable(msg.sender).transfer(_amount);
        emit Withdraw(msg.sender, _amount);
    }

    function getBalance() public view returns (uint256) {
        return wallets[msg.sender];
    }

    function getContractBalance() public view returns (uint256) {
        return address(this).balance;
    }

    function sendEther(address payable _receiver, uint256 _amount) public onlyOwner sufficientBalance(_receiver, _amount) {
        require(_amount <= address(this).balance, "Insufficient funds");
        _receiver.transfer(_amount);
        transactions.push(Transaction(transactions.length, msg.sender, _receiver, _amount, block.timestamp, true, bytes32(0)));
    }

    function getAllTransactions() public view returns (Transaction[] memory) {
        return transactions;
    }

    function getTransactionById(uint256 _id) public view returns (Transaction memory) {
        return transactions[_id];
    }

    function getTransactionsByWallet(address _wallet) public view returns (Transaction[] memory) {
        Transaction[] memory _transactions = new Transaction[](transactions.length);
        uint256 counter = 0;
        for (uint256 i = 0; i < transactions.length; i++) {
            if (transactions[i].walletSender == _wallet || transactions[i].walletReceiver == _wallet) {
                _transactions[counter] = transactions[i];
                counter++;
            }
        }
        return _transactions;
    }
}
