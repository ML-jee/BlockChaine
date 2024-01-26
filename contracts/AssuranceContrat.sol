// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/access/Ownable.sol";

interface IUsers {

    struct User {
        string name;
        uint256 age;
        uint256 numberOfChildren;
        uint256 balance;
        address userAddress;
        string contractChosen;
        string email;
        bool isMarried;
    }

    // Events to log important actions
    event UserInfoUpdated(string name, uint256 age, uint256 numberOfChildren, uint256 balance, address userAddress, string contractChosen);
    event EmailUpdated(string email);
    event MarriageStatusUpdated(bool isMarried);

    // Function to update user details
    function updateUserNumberOfChildren(address addressUser, uint256 newNumberOfChildren) external;

    function addUser(string memory _name, uint256 _age, uint256 _numberOfChildren, uint256 _balance, address _userAddress, string memory _contractChosen, string memory _email, bool _isMarried) external;

    // Function to update user's email
    function updateEmail(address userAddress, string memory _email) external;

    // Function to update user's marriage status
    function updateMarriageStatus(address userAddress, bool _isMarried) external;

    // Function to get user details
    function getUser(address userAddress) external view returns (User memory);

    // Function to get user's balance
    function getBalance(address userAddress) external view returns (uint256);

    // Function to get user's chosen contract
    function getContract(address userAddress) external view returns (string memory);

    // Function to set user's balance
    function setBalance(address userAddress, uint256 amount) external;

}

 
interface IAssuranceWallet {
    // Events
    event Deposit(address indexed account, uint256 amount);
    event Withdraw(address indexed account, uint256 amount);

    // Functions to interact with the AssuranceWallet contract
    function deposit() external payable;
    function withdraw(uint256 _amount) external;
    function getBalance() external view returns (uint256);
    function getContractBalance() external view returns (uint256);
    function sendEther(address payable _receiver, uint256 _amount) external;
    function getAllTransactions() external view returns (IAssuranceWallet.Transaction[] memory);
    function getTransactionById(uint256 _id) external view returns (IAssuranceWallet.Transaction memory);
    function getTransactionsByWallet(address _wallet) external view returns (IAssuranceWallet.Transaction[] memory);

    // Ownership and wallet management functions
    function changeOwner(address _newOwner) external;
    function addWallet(address _wallet) external;
    function removeWallet(address _wallet) external;
    function addToTheInssuranceWallet(uint256 amount) external;
    function addToTheWallet(uint256 amount) external;
    function subFromThewallet(uint256 amount) external;
    function subFromTheInssuranceWallet(uint256 amount) external;

    // Internal structs and modifiers
    struct Transaction {
        uint256 transactionId;
        address walletSender;
        address walletReceiver;
        uint256 amount;
        uint256 date;
        bool isApproved;
        bytes32 signature;
    }
 
}


contract AssuranceContrat is Ownable {
  // Contract code goes here
   
   
   IUsers public users;
   IAssuranceWallet public assuranceWallet;
   
  // AssuranceContrat contract attributes


    constructor() Ownable(msg.sender) {
        _transferOwnership(msg.sender);
    }

    function changeOwner(address _newOwner) public onlyOwner {
        _transferOwnership(_newOwner);
    }
 
   


   
}
