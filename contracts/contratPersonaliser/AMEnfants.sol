// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "../AssuranceContrat.sol";
contract AMEnfants is AssuranceContrat{
  // Contract code goes here

  // AMEnfants contract attributes
  uint256 public numberOfChildren;
  uint256 public numberOfAdults;

  // Events to log important actions
  event NumberOfChildrenUpdated(uint256 numberOfChildren);
  event NumberOfAdultsUpdated(uint256 numberOfAdults);
}
