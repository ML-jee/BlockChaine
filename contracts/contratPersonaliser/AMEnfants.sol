// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "../AssuranceContrat.sol";
 
 
interface IAvenirMesEnfantsInsurance {
    // Enum to represent insurance types
    enum InsuranceType { Mandatory, Optional }

    // Events
    event ContributionReceived(address indexed contributor, uint256 amount);
    event InsuranceClaimProcessed(address indexed beneficiary, uint256 claimAmount);

    // Functions to interact with the insurance contract
    function contributeToSavings(uint256 _amount) external payable;
    function processInsuranceClaim(InsuranceType _insuranceType, address _beneficiary) external;
    function isInsuranceActive(InsuranceType _insuranceType) external view returns (bool);
    function getOperatingCosts() external view returns (uint256 acquisitionCost, uint256 managementCost);
    function getDeathBenefitGuarantee() external view returns (uint256);

    // Functions related to contributions and annuities
    function getContributions(address _contributor) external view returns (uint256);
    function calculateAnnuity() external view returns (uint256);
}


contract AMEnfants is AssuranceContrat{
  // Contract code goes here

  // AMEnfants contract attributes
  uint256 public numberOfChildren;
  uint256 public numberOfAdults;

  // Events to log important actions
  event NumberOfChildrenUpdated(uint256 numberOfChildren);
  event NumberOfAdultsUpdated(uint256 numberOfAdults);
}
