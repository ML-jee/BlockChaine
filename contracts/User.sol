// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Users {

     address public owner;
     

    struct User{  
        string name;
        uint256 age;
        uint256 numberOfChildren;
        uint256 balance;
        address userAddress;
        string contractChosen;
        string email;
        bool isMarried;
    }

        mapping(address => User) public users;

        // Events to log important actions
        event UserInfoUpdated(string name, uint256 age, uint256 numberOfChildren, uint256 balance, address userAddress, string contractChosen);
        event EmailUpdated(string email);
        event MarriageStatusUpdated(bool isMarried);

        // Constructor to initialize user details
 
       
    
    function addUser(string memory _name, uint256 _age, uint256 _numberOfChildren, uint256 _balance, address _userAddress, string memory _contractChosen, string memory _email, bool _isMarried) public {
        
        User storage user = users[_userAddress];
        user.name = _name;
        user.age = _age;
        user.numberOfChildren = _numberOfChildren;
        user.balance = _balance;
        user.userAddress = _userAddress;
        user.contractChosen = _contractChosen;
        user.email = _email;
        user.isMarried = _isMarried;
        emit UserInfoUpdated(_name, _age, _numberOfChildren, _balance, _userAddress, _contractChosen);
    }
    // Function to update user details
    function updateUserNumberOfChildren(
        address addressUser,
         uint256 newNumberOfChildren) public {
        User storage user = users[addressUser];

        user.numberOfChildren = newNumberOfChildren;}

    // Function to update user's email
    function updateEmail(address userAddress, string memory _email) public {
        User storage user = users[userAddress];
        user.email = _email;
        emit EmailUpdated(_email);
    }

    // Function to update user's marriage status
    function updateMarriageStatus(address userAddress, bool _isMarried) public {
        User storage user = users[userAddress];

        user.isMarried = _isMarried;

        emit MarriageStatusUpdated(_isMarried);
    }

    // Function to get user details
    function getUser(address userAddress) public view returns (User memory) {
        return users[userAddress];
    }

    function getBalance(address userAddress) public view returns (uint256) {
        return users[userAddress].balance;
    }

    function getContract(address userAddress) public view returns (string memory) {
        return users[userAddress].contractChosen;
    }

    function setBalance(address userAddress, uint256 amount) public{
        User storage user = users[userAddress];
        user.balance = amount;
    }    

}
