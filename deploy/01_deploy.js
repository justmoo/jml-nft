const { ethers } = require("hardhat");
let { networkConfig } = require("../helper-hardhat-config");

module.exports = async ({ getNamedAccounts, deployments, getChainId }) => {
  const { deploy, log } = deployments;
  const { deployer } = await getNamedAccounts();
  const chainId = await getChainId();

  const CamelNFT = await deploy("CamelNFT", {
    from: deployer,
    log: true,
  });

  const camelNFTContract = await ethers.getContractFactory("CamelNFT");
  const accounts = await ethers.getSigners();
  const signer = accounts[0];

  const camelNft = new ethers.Contract(
    CamelNFT.address,
    camelNFTContract.interface,
    signer
  );

  const networkName = networkConfig[chainId]["name"];

  log(
    ` Verify with : \n  npx hardhat verify --network ${networkName}  ${CamelNFT.address}`
  );
  const nftCounter = await camelNft.getCounter();
  const transaction = await camelNft.create();
  await transaction.wait(1);
  log("You have made an NFT!");
  log(`you can view token uri here: ${await camelNft.tokenURI(nftCounter)}`);
};
