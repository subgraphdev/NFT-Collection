// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./IWhitelist.sol";

contract CryptoDevs is ERC721Enumerable,Ownable{

    /*
    ! The tokenURI on an NFT is a unique identifier of what the token "looks" like. A URI 
    ! could be an API call over HTTPS, an IPFS hash, or anything else unique.
     */
///////////////////////////////////////////////////////////////////////
    string _baseTokenURI;

    uint256 public _price=0.01 ether;

    bool public _paused;

    uint256 public maxTokenIds = 20;

    uint256 public tokenIds;

    IWhitelist whitelist;

    bool public presaleStarted;

    uint256 public presaleEnded;
////////////////////////////////////////////////////////////////////

modifier onlyWhenNotPaused {
    require(!_paused,"Contract is paused currently");
    _;
}



constructor (string memory baseURI,address whitelistContract)
ERC721("Crypto Devs Elite Club","CDEC"){
    _baseTokenURI = baseURI;
    whitelist = IWhitelist(whitelistContract);
}
/////////////////////////////////////////////////////////////////////
/* --------------------------   Function      ----------------------------------*/ 

/* 
!onlyOwner is a modifier, we are using from openzepppelon Ownable contract,
!it checks thw whether the msg.sender is owner of contract or not
*/

function startPresale() public onlyOwner {
    presaleStarted = true;
    presaleEnded = block.timestamp + 15 minutes;
}

 function presaleMint() public payable onlyWhenNotPaused {
          require(presaleStarted && block.timestamp < presaleEnded, "Presale is not running");
          require(whitelist.whitelistedAddresses(msg.sender), "You are not whitelisted");
          require(tokenIds < maxTokenIds, "Exceeded maximum Crypto Devs supply");
          require(msg.value >= _price, "Ether sent is not correct");
          tokenIds += 1;
          //_safeMint is a safer version of the _mint function as it ensures that
          // if the address being minted to is a contract, then it knows how to deal with ERC721 tokens
          // If the address being minted to is not a contract, it works the same way as _mint
          _safeMint(msg.sender, tokenIds);
      }

function mint() public payable onlyWhenNotPaused {
    require(presaleStarted && block.timestamp >= presaleEnded,"Presale is running wait for public mint to start");
    require(tokenIds < maxTokenIds,"All Tokens are minted");
    require(msg.value >= _price,"Not suffcient fund");

    tokenIds += 1;

    _safeMint(msg.sender,tokenIds);
}


function _baseURI() internal view virtual override returns (string memory){
    return _baseTokenURI;
}

function withdraw() public onlyOwner {
    address _owner = owner();
    uint256 amount = address(this).balance;
    (bool sent,) = _owner.call{value:amount}("");
    require(sent,"Failed to withdraw");
}
 function setPaused(bool val) public onlyOwner {
          _paused = val;
      }
       // Function to receive Ether. msg.data must be empty
      receive() external payable {}

      // Fallback function is called when msg.data is not empty
      fallback() external payable {}

}

/*
!A Fallback funtion is a  function within a smart contract that is called if 
no other function in the contract matches the specified function in the call
This can happen if the call has a typo or if it specifies no function call

! The receive() method is used as a fallback funtion if ether are sent to
the contract  and no calldata are provided(no function is specified).It can 
take any value.If contract does not have receive() method the it uses the 
fallback() method.

!The Fallback() function is used if a smart contract is called and no 
other function matches.

 */
