// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IMaRetraiteInsurance {
    // Enum to represent the type of insurance coverage
    enum CoverageType { Acquired, Optional }

    // Events
    event ContributionMade(address indexed contributor, uint256 amount);
    event PolicyRedeemed(address indexed policyHolder, uint256 redeemedAmount);
    event PolicyAdvanced(address indexed policyHolder, uint256 advancedAmount);

    // Functions to interact with the insurance contract
    function contributeToSavings(uint256 _amount) external payable;
    function redeemPolicy(uint256 _amount) external;
    function requestPolicyAdvance(uint256 _amount) external;

    
    // Functions to get information about the policy
    function getContributions(address _contributor) external view returns (uint256);
    function getPolicyValue() external view returns (uint256);
    function getCoverageAmount(CoverageType _coverageType) external view returns (uint256);
    function isCoverageActive(CoverageType _coverageType) external view returns (bool);

    // Functions related to profit-sharing and remuneration
    function calculateInterest() external view returns (uint256);
    function getProfitSharePercentage() external view returns (uint256);
}

contract maRetraite is AssuranceContrat, IMaRetraiteInsurance{
  // Add an opening curly brace here

    // IMaRetraiteInsurance contract attributes
    struct contractDetails{
          uint256 contractId;
          uint256 duration;
          uint256 capitalTotal;
          uint256 yearsSinceStart;
          }

     mapping(address => contractDetails) public contractDetailsOf;
      
     mapping(address => amount) public wallets;

  
    // Contract code goes here
    function contributeToSavings(address userAddress,uint256 _amount) external payable override{
        // Add code here
     contractDetailsOf[userAddress].capitalTotal+=_amount*0.97;
    wallets[userAddress].capitalTotal += _amount * 0.03;
    }
    }

    function redeemPolicy(uint256 _amount) external override{
        // Add code here
        uint256 amountToRedeem ;
        require(contractDetailsOf[msg.sender].capitalTotal >= _amount,"you don't have enough money");
        if(contractDetailsOf[msg.sender].yearsSinceStart<5){amountToRedeem- = _amount*0.9;
        }else{amountToRedeem=_amount*0.95;}
    }


    function requestPolicyAdvance(uint256 _amount) external override{
        // Add code here
        require(contractDetailsOf[msg.sender].capitalTotal >= _amount,"you don't have enough money");
        contractDetailsOf[msg.sender].capitalTotal- = _amount;
        wallets[msg.sender].capitalTotal+ = _amount;
    }

    function getContributions(address _contributor) external view override returns (uint256){
        // Add code here
        return contractDetailsOf[_contributor].capitalTotal;
    }

    function getPolicyValue() external view override returns (uint256){
        // Add code here
        return 0.93;
    }
    
    function getDeathAmount(address user) external view override returns (uint256){
        // Add code here
         contractDetailsOf[user].capitalTotal =36.90;
        wallets[user].capitalTotal+ =  36.90;
    }

    function getCoverageIncapability(uint256 moneyInNeed, address user) external view override returns (uint256){
        // Add code here
        uint256 result ;
         result= contractDetailsOf[user].capitalTotal;
         
        return 2*result+moneyInNeed;
       }
}

 



