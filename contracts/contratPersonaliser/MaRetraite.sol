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
    function suspendWithdrawals() external;
    function resumeWithdrawals() external;
    
    // Functions to get information about the policy
    function getContributions(address _contributor) external view returns (uint256);
    function getPolicyValue() external view returns (uint256);
    function getCoverageAmount(CoverageType _coverageType) external view returns (uint256);
    function isCoverageActive(CoverageType _coverageType) external view returns (bool);

    // Functions related to profit-sharing and remuneration
    function calculateInterest() external view returns (uint256);
    function getProfitSharePercentage() external view returns (uint256);
}
