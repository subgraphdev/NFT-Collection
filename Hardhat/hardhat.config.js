require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config({path:".env"});

const ALCHEMY_API_KEY_URL = process.env.ALCHEMY_API_KEY_URL;

const GOERLI_PRIVATE_KEY = process.env.GOERLI_PRIVATE_KEY;


module.exports = {
  solidity: "0.8.6",
  networks:{
    goerli:{
      url: ALCHEMY_API_KEY_URL,
      accounts: [GOERLI_PRIVATE_KEY],
    }
  }

};


/*-------------------------------contract address---------------------*/
//!CryptoDevs contract deployed at:    0x968c4ffA9615239e3cbB5Da0c4C335340A5Ce6dD
/*-------------------------------------------------------------------- */