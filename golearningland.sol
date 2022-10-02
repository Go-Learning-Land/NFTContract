//          GO LEARNING LAND 
//           /\/\/\/\/\/\/\                    
//          ,_---~~~~~----._            
//   _,,_,*^____      _____``*g*\"*,    
//  / __/ /'     ^.  /      \ ^@q   f   
// [  @f | @))    |  | @))   l  0 _/    
//  \`/   \~____ / __ \_____/    \       
//   |           _l__l_           I     
//   }          [______]           I    
//   ]            | | |            |    
//   ]             ~ ~             |    
//   |            GLL              |     
//    |       LETS GOOOO!         |     

// SPDX-License-Identifier: MIT

pragma solidity 0.8.7;
//
import "@openzeppelin/contracts/access/Ownable.sol";
import "erc721a/contracts/ERC721A.sol";

contract GoLearningLand is ERC721A, Ownable {
  // "Private" Variables
  address private constant GOPHER1 = 0xGOPHER1;
  address private constant GOPHER2 = 0xGOPHER2;
  address private constant GOPHER3 = 0xGOPHER3;
  address private constant GOPHER4 = 0xGOPHER4;
  string private baseURI= "https://address.execute-api.eu-west-1.amazonaws.com/prod/metadata/";

  // Public Variables
  bool public started = true;
  bool public claimed = false;
  uint256 public constant MAX_SUPPLY = 3333;
  uint256 public constant MAX_MINT = 1;
  uint256 public constant TEAM_CLAIM_AMOUNT = 111;

  

  constructor() ERC721A("Go Learning Land", "GLL") {
      
  }

  // Start tokenid at 1 instead of 0
  function _startTokenId() internal view virtual override returns (uint256) {
      return 1;
  }

  function mint() external {
    require(started, "The pilgrimage to this land has not yet started");
    require(totalSupply() < MAX_SUPPLY, "All lost souls have been accounted for");
    // mint
    _safeMint(msg.sender, 1);
  }

  function teamClaim() external onlyOwner {
    require(!claimed, "Team already claimed");
    // claim
    _safeMint(GOPHER1, TEAM_CLAIM_AMOUNT);
    _safeMint(GOPHER2, TEAM_CLAIM_AMOUNT);
    _safeMint(GOPHER3, TEAM_CLAIM_AMOUNT);
    _safeMint(GOPHER4, TEAM_CLAIM_AMOUNT);
    claimed = true;
  }

  function setBaseURI(string memory baseURI_) external onlyOwner {
      baseURI = baseURI_;
  }

  function _baseURI() internal view virtual override returns (string memory) {
      return baseURI;
  }

  function enableMint(bool mintStarted) external onlyOwner {
      started = mintStarted;
  }
}