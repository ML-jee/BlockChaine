// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.0;
contract Claim {
  struct ClaimData {
    address claimant;
    uint256 amount;
    bool processed;
    bool approved;
    string denialReason;
  }

  mapping(uint256 => ClaimData) public claims;
  uint256 public claimCount;

  function fileClaim(uint256 amount) external {
    claims[claimCount] = ClaimData(msg.sender, amount, false, false, "");
    claimCount++;
  }

  function processClaim(uint256 claimId) external {
    require(!claims[claimId].processed, "Claim has already been processed");
    claims[claimId].processed = true;
    // Calculate payout logic here
  }

  function approveClaim(uint256 claimId) external {
    require(claims[claimId].processed, "Claim has not been processed yet");
    require(!claims[claimId].approved, "Claim has already been approved");
    claims[claimId].approved = true;
    // Perform payout logic here
  }

  function denyClaim(uint256 claimId, string memory reason) external {
    require(claims[claimId].processed, "Claim has not been processed yet");
    require(!claims[claimId].approved, "Claim has already been approved");
    claims[claimId].denialReason = reason;
  }
}
