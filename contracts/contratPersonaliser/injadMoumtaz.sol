// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IAlInjadAlMoumtazInsurance {
    // Enum to represent the coverage type
    enum CoverageType { Individuals, Vehicles }

    // Enum to represent the optional guarantees
    enum OptionalGuarantee { Assistance, HospitalizationIndemnity, DailyIndemnity, DeathOrDisabilityCapital, Oncology }

    // Events
    event PremiumPaid(address indexed policyHolder, uint256 amount);
    event ClaimProcessed(address indexed beneficiary, uint256 claimAmount);

    // Functions to interact with the insurance contract
    function payPremium() external payable;
    function processClaim(address _beneficiary, uint256 _claimAmount) external;
    function getCoverageType() external view returns (CoverageType);
    function getCoverageArea() external view returns (string memory coverageArea);
    function getBenefits() external view returns (bool thirdPartyPayment, bool directBilling, bool reimbursement);
    function getReimbursementRates() external view returns (uint256 hospitalizationRate, uint256 surgeryRate, uint256 chemistryRate, uint256 radiologyRate);

    // Functions related to health insurance
    function addCoverageForIndividual(address _individual) external;
    function addCoverageForVehicle(address _vehicle) external;
    function addOptionalGuarantee(OptionalGuarantee _guarantee) external;
    function removeOptionalGuarantee(OptionalGuarantee _guarantee) external;
    function isCoverageActiveForIndividual(address _individual) external view returns (bool);
    function isCoverageActiveForVehicle(address _vehicle) external view returns (bool);
    function isOptionalGuaranteeActive(OptionalGuarantee _guarantee) external view returns (bool);

    // Functions for premium details
    function getPremiumDetails(address _policyHolder) external view returns (uint256);
}
