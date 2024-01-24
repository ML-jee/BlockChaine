// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IAlInjadChaabiInsurance {
    // Enum to represent the assistance types
    enum AssistanceType { Medical, VehicleRelated, TechnicalVehicle, Death }

    // Events
    event PremiumPaid(address indexed policyHolder, uint256 amount);
    event ClaimProcessed(address indexed beneficiary, uint256 claimAmount);

    // Functions to interact with the insurance contract
    function payPremium() external payable;
    function processClaim(address _beneficiary, AssistanceType _assistanceType) external;

    // Functions related to medical assistance
    function getHospitalizationCoverage() external view returns (uint256 coveragePercentage, bool privateRoom, bool surgeryLimitation, uint256 dailyAllowance);
    function getMedicalAssistance() external view returns (bool medicalTransport, bool accommodationExpenses, bool admissionAdvance, bool internationalMedicalExpenses, bool medicalAdvice);

    // Functions related to vehicle-related assistance
    function getDriverAssistance() external view returns (bool chauffeurService, bool vehicleImmobilization, bool defenseAbroad, bool foreignCriminalCaution);
    
    // Functions related to technical vehicle assistance
    function getTechnicalAssistance() external view returns (bool vehicleRecovery, bool towing, bool sparePartsShipping, bool storageExpenses, bool legalAbandonmentFees);

    // Functions related to death assistance
    function getDeathAssistance() external view returns (bool funeralTransport, bool burialRepatriation, bool escortAbroad, bool returnHome);

    // Functions for premium details
    function getPremiumDetails(address _policyHolder) external view returns (uint256);

    // Functions for policy management
    function getEffectiveDate() external view returns (uint256);
}
