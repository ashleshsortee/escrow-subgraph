const hre = require("hardhat");
// const { ethers } = require("hardhat");

async function main() {
  const USDT = await hre.ethers.getContractFactory("USDT");
  const usdt = await USDT.deploy("1000000000000");

  await usdt.deployed();

  console.log("USDT deployed to:", usdt.address);

  const Escrow = await hre.ethers.getContractFactory("Escrow");
  const escrow = await Escrow.deploy(usdt.address);

  console.log("Escrow deployed to:", escrow.address);

  // const tx = await usdt.approve(
  //   "0x9e4e33eF13F67be8Fcfd94c61F0164123de2dF6F",
  //   ethers.utils.parseUnits("10")
  // );

  // console.log("tx", tx);

  // const res = await tx.wait(3);
  // console.log("res", res);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
