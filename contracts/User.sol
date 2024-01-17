// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.0;
contract User {
    struct UserDetails {
        string name;
        uint age;
        string email;
    }

    mapping(address => UserDetails) private users;
    mapping(address => string[]) private userPolicies;

    function registerUser(string memory name, uint age, string memory email) public {
        users[msg.sender] = UserDetails(name, age, email);
    }

    function getUserDetails(address userAddress) public view returns (string memory, uint, string memory) {
        UserDetails memory userDetails = users[userAddress];
        return (userDetails.name, userDetails.age, userDetails.email);
    }

    function updateUserDetails(string memory name, uint age, string memory email) public {
        UserDetails storage userDetails = users[msg.sender];
        userDetails.name = name;
        userDetails.age = age;
        userDetails.email = email;
    }

    function getUserPolicies() public view returns (string[] memory) {
        return userPolicies[msg.sender];
    }
}
