const {ethers} = require("hardhat");
require("dotenv").config({path:".env"});
const  {WHITELIST_CONTRACT_ADDRESS, METADATA_URL}= require("../constants");



async function main() {

  const whitelistContract = WHITELIST_CONTRACT_ADDRESS;
  const metaDataUrl = METADATA_URL;

  const cryptoDevsContract = await ethers.getContractFactory("CryptoDevs");
  const deployedCryptoDevs = await cryptoDevsContract.deploy(
    metaDataUrl,
    whitelistContract
  );

  console.log("CryptoDevs contract deployed at:",
  deployedCryptoDevs.address)
  
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
.then(()=>process.exit(0))
.catch((err)=>{
  console.error(err)
  process.exit(1)
})


/*-------------------------------contract address---------------------*/
//!CryptoDevs contract deployed at: 0x6986307dd5D0253b8567b69ff550840ae7401AC9
/*-------------------------------------------------------------------- */