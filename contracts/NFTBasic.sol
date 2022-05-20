// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import '@openzeppelin/contracts/token/ERC721/ERC721.sol';
import '@openzeppelin/contracts/utils/Counters.sol';
import "@openzeppelin/contracts/access/Ownable.sol";
//import "https://github.com/dievardump/EIP2981-implementation/blob/main/contracts/ERC2981ContractWideRoyalties.sol";

contract NFTBasic is ERC721, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    using Strings for uint256;

    string public defaultURI = "https://ipfs.io/ipfs/CID-Address/";
    
    string public BASE_EXTENSION = ".json";

    constructor() ERC721('NFTBasic', 'NFTB') {

    }

    function _baseURI() internal view override returns (string memory) {
        return defaultURI;
    }

    function setDefaultURI(string memory _defaultURI) onlyOwner public {
        defaultURI = _defaultURI;
    }

    function faucet() external {

        uint256 tokenId = _tokenIds.current();
        _tokenIds.increment();

        _safeMint(msg.sender, tokenId);
    }

    function tokenURI(uint256 tokenId) public view override(ERC721) returns (string memory) {
        require(_exists(tokenId), "ERC721Metadata: URI query error. Token nonexistent");

        string memory currentBaseURI = _baseURI();
        return string(abi.encodePacked(currentBaseURI, tokenId.toString(), BASE_EXTENSION));
    }

}