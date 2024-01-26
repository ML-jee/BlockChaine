// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "../AssuranceContrat.sol";

interface IInjadChamilInsurance {
    // Enum to represent the status of coverage
    enum CoverageStatus { Active, Inactive }

    // Enum to represent the relationship with the insured
    enum Relationship { Spouse, Child, Ascendant, FamilyMember, Car }

    // Events
    event ContributionPaid(address indexed policyHolder, uint256 amount);
    event InsuranceClaimProcessed(address indexed beneficiary, uint256 claimAmount);
    event IsNotEligible(address indexed policyHolder);

    // Functions to interact with the insurance contract
     function processInsuranceClaim(address _beneficiary) external;
    function isCoverageActive(address _beneficiary) external view returns (CoverageStatus);

    // Functions related to beneficiaries and covered individuals
    function addBeneficiary(address _beneficiary ) external;
    function removeBeneficiary(address _beneficiary) external;
    function isCoveredIndividual(address _individual) external view returns (bool);

    // Functions related to waiting period and effective date
    function getEffectiveDate(address _individual) external view returns (uint256);
    function getWaitingPeriod(address _individual) external view returns (uint256);

    // Functions for policy management
    function renewContract(address _individual) external;
    function terminateContract(address _individual) external;

    // Functions for contribution details
    function getContributions(address _policyHolder) external view returns (uint256);

    // Functions for coverage details
    function getCoverageDetails(address _individual) external view returns (uint256 coveragePeriodStart, uint256 coveragePeriodEnd, uint256 waitingPeriodEnd);
}

contract InjadChamilInsurance is AssuranceContrat, IInjadChamilInsurance {
    // IInjadChamilInsurance contract attributes

    struct ContractDetails {
        uint256 contractId;
        uint256 duration;
        uint256 capitalTotal;
        uint256 yearsSinceStart;
        address[] beneficiaries;
        CoverageStatus status;
    }

    mapping(address => ContractDetails) public contractDetailsOf;
    mapping(address => uint256) public wallets;

    // Constructor
    constructor() AssuranceContrat() {}


    function addContractDetails(
        address _policyHolder,
        uint256 _contractId,
        uint256 _duration,
        uint256 _capitalTotal,
        uint256 _yearsSinceStart,
        address[] memory _beneficiaries
    ) internal {
        contractDetailsOf[_policyHolder] = ContractDetails(
            _contractId,
            _duration,
            _capitalTotal,
            _yearsSinceStart,
            _beneficiaries,
            CoverageStatus.Inactive
        );
    }
    function getContributions(address _policyHolder) public view override returns (uint256) {
        if (contractDetailsOf[_policyHolder].duration < 2) {
            return contractDetailsOf[_policyHolder].capitalTotal;
        }else{
            return 0;
        }
    }

        function processInsuranceClaim(address _beneficiary) external override {
            // Add code to process insurance claim
            uint256 claimAmount = getContributions(_beneficiary);
            emit InsuranceClaimProcessed(_beneficiary, claimAmount);
        }

    function isCoverageActive(address _beneficiary) external view override returns (CoverageStatus) {
        if (contractDetailsOf[_beneficiary].yearsSinceStart > 0) {
            return CoverageStatus.Active;
        } else {
            return CoverageStatus.Inactive;
        }
    }

    function addBeneficiary(address _beneficiary ) external override {
        contractDetailsOf[_beneficiary].beneficiaries.push(_beneficiary);
    }

    function removeBeneficiary(address _beneficiary) external override {
        delete contractDetailsOf[_beneficiary].beneficiaries;
    }

    function isCoveredIndividual(address _individual) external view override returns (bool) {
        for (uint256 i = 0; i < contractDetailsOf[_individual].beneficiaries.length; i++) {
            if (contractDetailsOf[_individual].beneficiaries[i] == _individual) {
                return true;
            }
        }
        return false;
    }

    function getEffectiveDate(address _individual) external view override returns (uint256) {
        return contractDetailsOf[_individual].yearsSinceStart;
    }

    function getWaitingPeriod(address _individual) external view override returns (uint256) {
        return contractDetailsOf[_individual].yearsSinceStart;
    }

    function renewContract(address _individual) external override {
        contractDetailsOf[_individual].yearsSinceStart++;
    }

    function terminateContract(address _individual) external override {
        contractDetailsOf[_individual].yearsSinceStart = 0;
    }



    function getCoverageDetails(address _individual)
        external
        view
        override
        returns (
            uint256 coveragePeriodStart,
            uint256 coveragePeriodEnd,
            uint256 waitingPeriodEnd
        )
    {
        return (
            contractDetailsOf[_individual].yearsSinceStart,
            contractDetailsOf[_individual].yearsSinceStart + contractDetailsOf[_individual].duration,
            contractDetailsOf[_individual].yearsSinceStart + 1
        );
    }
}
