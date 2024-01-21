// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract User {
    string public name;
    uint256 public age;
    uint256 public numberOfChildren;
    uint256 public balance;
    address public userAddress;
    string public contractChosen;

    // Additional attributes
    string public email;
    bool public isMarried;

    // Events to log important actions
    event UserInfoUpdated(string name, uint256 age, uint256 numberOfChildren, uint256 balance, address userAddress, string contractChosen);
    event EmailUpdated(string email);
    event MarriageStatusUpdated(bool isMarried);

    // Constructor to initialize user details
    constructor(
        string memory _name,
        uint256 _age,
        uint256 _numberOfChildren,
        uint256 _balance,
        address _userAddress,
        string memory _contractChosen,
        string memory _email,
        bool _isMarried
    ) {
        name = _name;
        age = _age;
        numberOfChildren = _numberOfChildren;
        balance = _balance;
        userAddress = _userAddress;
        contractChosen = _contractChosen;
        email = _email;
        isMarried = _isMarried;

        emit UserInfoUpdated(_name, _age, _numberOfChildren, _balance, _userAddress, _contractChosen);
        emit EmailUpdated(_email);
        emit MarriageStatusUpdated(_isMarried);
    }

    // Function to update user details
    function updateUserInfo(
        string memory _name,
        uint256 _age,
        uint256 _numberOfChildren,
        uint256 _balance,
        string memory _contractChosen
    ) public {
        name = _name;
        age = _age;
        numberOfChildren = _numberOfChildren;
        balance = _balance;
        contractChosen = _contractChosen;

        emit UserInfoUpdated(_name, _age, _numberOfChildren, _balance, userAddress, _contractChosen);
    }

    // Function to update user's email
    function updateEmail(string memory _email) public {
        email = _email;

        emit EmailUpdated(_email);
    }

    // Function to update user's marriage status
    function updateMarriageStatus(bool _isMarried) public {
        isMarried = _isMarried;

        emit MarriageStatusUpdated(_isMarried);
    }

    // Function to get user details
    function getUserDetails() public view returns (string memory, uint256, uint256, uint256, address, string memory, string memory, bool) {
        return (name, age, numberOfChildren, balance, userAddress, contractChosen, email, isMarried);
    }
}
