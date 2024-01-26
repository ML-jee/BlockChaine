// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "../AssuranceContrat.sol";
import "@openzeppelin/contracts/utils/math/Math.sol";


interface IMaRetraiteInsurance {
    // Enum to represent the type of insurance coverage
    enum CoverageType { Acquired, Optional }

    // Events
    event ContributionMade(address indexed contributor, uint256 amount);
    event PolicyRedeemed(address indexed policyHolder, uint256 redeemedAmount);
    event ContractAdded(address indexed policyHolder, uint256 addedAmount);

    // Functions to interact with the insurance contract
    function addContract(uint256 _amount, address gateway) external payable;

    function contributeToSavings(uint256 _amount) external payable;
    function redeemPolicy(uint256 _amount) external;
    function getPolicyValue() external view returns (uint256);

    // Functions to get information about the policy
    function getContributions() external view returns (uint256);
    function getDeathAmount(address user) external view returns (uint256);
    function getCoverageIncapability(uint256 moneyInNeed) external view returns (uint256);
    
    function getAllContract() external view returns (uint256);
    // Functions related to profit-sharing and remuneration
}

contract maRetraite is AssuranceContrat, IMaRetraiteInsurance {
    // MaRetraiteInsurance contract attributes
    struct ContractDetails {
        address policyHolder;
        address addressGateway;
        uint256 capitalTotal;
        uint256 yearsSinceStart;
        uint256 monthsSinceStart;
    }

    mapping(address => ContractDetails) public contractDetailsOf;

    // Contract code goes here
    constructor() AssuranceContrat() {}

    modifier userDoesNotHaveContract() {
        require(
            contractDetailsOf[msg.sender].capitalTotal == 0,
            "You already have a contract"
        );
        _;
    }

    function addContract(uint256 _amount, address gateway) external payable override userDoesNotHaveContract {
        contractDetailsOf[msg.sender].capitalTotal = _amount;
        contractDetailsOf[msg.sender].policyHolder = msg.sender;
        contractDetailsOf[msg.sender].addressGateway = gateway;
        contractDetailsOf[msg.sender].yearsSinceStart = 0;
        contractDetailsOf[msg.sender].monthsSinceStart = 0;
        emit ContractAdded(msg.sender, _amount);
    }

    function contributeToSavings(uint256 _amount) external payable override {
        // Determine the interest rate based on the number of years
        uint256 interestRate;
        if (contractDetailsOf[msg.sender].yearsSinceStart < 5) {
            interestRate = 10; // 10% interest for the first 5 years
        } else if (contractDetailsOf[msg.sender].yearsSinceStart < 8) {
            interestRate = 5; // 5% interest for years 5-8
        } else {
            interestRate = 3; // 3% interest after 8 years
        }

        uint256 interestAmount = _amount * interestRate / 100;

        contractDetailsOf[msg.sender].capitalTotal = contractDetailsOf[msg.sender].capitalTotal+_amount +interestAmount;
        contractDetailsOf[msg.sender].monthsSinceStart += 1;
        assuranceWallet.addToTheInssuranceWallet(interestAmount);
        assuranceWallet.subFromThewallet(_amount);
        emit ContributionMade(msg.sender, _amount);
    }

    function redeemPolicy(uint256 _amount) external override {
        uint256 amountToRedeem;
        require(
            contractDetailsOf[msg.sender].capitalTotal >= _amount,
            "You don't have enough money"
        );
        if (contractDetailsOf[msg.sender].yearsSinceStart < 5) {
            amountToRedeem = _amount.mul(9).div(10);
            assuranceWallet.addToTheInssuranceWallet(_amount.mul(1).div(10));
        } else {
            amountToRedeem = _amount.mul(19).div(20);
            assuranceWallet.addToTheInssuranceWallet(_amount.mul(1).div(20));
        }
        contractDetailsOf[msg.sender].capitalTotal = contractDetailsOf[msg.sender].capitalTotal.sub(_amount);
        assuranceWallet.addToTheWallet(amountToRedeem);
        assuranceWallet.subFromTheInssuranceWallet(amountToRedeem);
        emit PolicyRedeemed(msg.sender, amountToRedeem);
    }

    function getContributions() external view override returns (uint256) {
        return contractDetailsOf[msg.sender].capitalTotal;
    }

    function getPolicyValue() external view override returns (uint256) {
        uint256 interestRate;
        if (contractDetailsOf[msg.sender].yearsSinceStart < 5) {
            interestRate = 10; // 10% interest for the first 5 years
        } else if (contractDetailsOf[msg.sender].yearsSinceStart < 8) {
            interestRate = 5; // 5% interest for years 5-8
        } else {
            interestRate = 3; // 3% interest after 8 years
        }
        return interestRate;
    }

    function getDeathAmount(address user) external view override returns (uint256) {
        contractDetailsOf[user].capitalTotal = 40;
        contractDetailsOf[msg.sender].capitalTotal += contractDetailsOf[msg.sender].capitalTotal;

        users.setBalance(
            contractDetailsOf[msg.sender].addressGateway,
            contractDetailsOf[msg.sender].capitalTotal
        );
        assuranceWallet.subFromTheInssuranceWallet(40);

        return contractDetailsOf[msg.sender].capitalTotal;
    }

    function getCoverageIncapability(
        uint256 moneyInNeed
    ) external view override returns (uint256) {
        uint256 result;
        result = contractDetailsOf[msg.sender].capitalTotal;

        assuranceWallet.subFromTheInssuranceWallet(40);

        return 2 * result + moneyInNeed;
    }

    function getAllContract() external view override returns (uint256) {
        return 0; // Placeholder, you need to implement logic to get all contracts
    }


}
