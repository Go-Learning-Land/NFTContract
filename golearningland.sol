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
import "@openzeppelin/contracts/utils/Strings.sol"; 

contract GoLearningLand is ERC721A, Ownable {
  using Strings for uint256;
  // "Private" Variables
  address private constant GOPHER1 = 0xf1281D9969b7Cf41063898c8e3BA3eF34589fEaa;
  address private constant GOPHER2 = 0xf1281D9969b7Cf41063898c8e3BA3eF34589fEaa;
  address private constant GOPHER3 = 0xf1281D9969b7Cf41063898c8e3BA3eF34589fEaa;
  address private constant GOPHER4 = 0xf1281D9969b7Cf41063898c8e3BA3eF34589fEaa;
  string private baseURI= "https://address.execute-api.eu-west-1.amazonaws.com/prod/metadata/";
  string private uriSuffix = ".json"; // can be .json also change test files

  // Public Variables
  bool public started = true;
  bool public claimed = false;
  uint256 public constant MAX_SUPPLY = 3333;
  //uint256 public constant MAX_MINT = 1;
  uint256 public constant TEAM_CLAIM_AMOUNT = 111;

  

  constructor() ERC721A("Go Learning Land", "GLL") {
      
  }

  // Start tokenid at 1 instead of 0
  function _startTokenId() internal view virtual override returns (uint256) {
      return 1;
  }

  function mint() external {
    require(started, "GLL mint is not available yet");
    require(totalSupply() < MAX_SUPPLY, "All Gophers has been minted");
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

   function tokenURI(uint256 _tokenId)
        public
        view
        virtual
        override
        returns (string memory)
    {
        require(
            _exists(_tokenId),
            "ERC721Metadata: URI query for nonexistent token"
        );

        string memory currentBaseURI = _baseURI();
        return
            bytes(currentBaseURI).length > 0
                ? string(
                    abi.encodePacked(
                        currentBaseURI,
                        _tokenId.toString(),
                        uriSuffix
                    )
                )
                : "";
    }
        function setUriSuffix(string memory _uriSuffix) public onlyOwner {
        uriSuffix = _uriSuffix;
    }
}