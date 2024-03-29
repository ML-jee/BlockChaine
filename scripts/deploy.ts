import { ethers } from "hardhat";

async function main() {
  const currentTimestampInSeconds = Math.round(Date.now() / 1000);
  const unlockTime = currentTimestampInSeconds + 60;

  const lockedAmount = ethers.parseEther("0.001");

  const InjazChamil = await ethers.deployContract("contracts/contratPersonaliser/InjazChamil.sol:InjazChamil");

  await InjazChamil.waitForDeployment();

  console.log(
    `Lock with ${ethers.formatEther(
      lockedAmount
    )} ETH and unlock timestamp ${unlockTime} deployed to ${InjazChamil.target}`
  );
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
