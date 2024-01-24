// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IInjadChamilInsurance {
    // Enum to represent the status of coverage
    enum CoverageStatus { Active, Inactive }

    // Enum to represent the relationship with the insured
    enum Relationship { Spouse, Child, Ascendant, FamilyMember, Passenger }

    // Events
    event ContributionPaid(address indexed policyHolder, uint256 amount);
    event InsuranceClaimProcessed(address indexed beneficiary, uint256 claimAmount);

    // Functions to interact with the insurance contract
    function payPremium() external payable;
    function processInsuranceClaim(address _beneficiary) external;
    function isCoverageActive() external view returns (CoverageStatus);
    function getTerritorialScope() external view returns (string[] memory maghrebCountries, string[] memory europeCountries);
    function getRenewalDate() external view returns (uint256 renewalDate);

    // Functions related to beneficiaries and covered individuals
    function addBeneficiary(address _beneficiary, Relationship _relationship) external;
    function removeBeneficiary(address _beneficiary) external;
    function isCoveredIndividual(address _individual) external view returns (bool);

    // Functions related to waiting period and effective date
    function getEffectiveDate() external view returns (uint256);
    function getWaitingPeriod() external view returns (uint256);

    // Functions for policy management
    function renewContract() external;
    function terminateContract() external;

    // Functions for contribution details
    function getContributions(address _policyHolder) external view returns (uint256);

    // Functions for coverage details
    function getCoverageDetails() external view returns (uint256 coveragePeriodStart, uint256 coveragePeriodEnd, uint256 waitingPeriodEnd);
}
