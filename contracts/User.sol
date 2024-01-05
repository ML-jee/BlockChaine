// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.0;

contract User {
    string public name;
    string public desciption;
    string public email;
    string public password;


    constructor(string memory _name) {
        name = _name;
        
    }

    function launch() public {
    }
}