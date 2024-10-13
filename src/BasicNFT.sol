// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

// forge install OpenZeppelin/openzeppelin-contracts --no-commit

import {ERC721} from "../lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";

contract BasicNFT is ERC721 {
    error BasicNft__TokenUriNotFound();

    uint256 private s_tokenCounter;
    mapping(uint256 => string) private s_tokenIdToUri;

    constructor(uint256) ERC721("DOGIE", "DOG") {
        // entire collection of DOGIE nfts, therefore each nft in this collection is going to have its own unique tokenId
        s_tokenCounter = 0;
    }

    function mintNft(string memory tokenUri) public {
        s_tokenIdToUri[s_tokenCounter] = tokenUri;
        _safeMint(msg.sender, s_tokenCounter); // _safeMint function makes their balance + 1
        s_tokenCounter++;
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        // whenever you wanna look at what an nft looks like, it's the function, we are calling to
        if (ownerOf(tokenId) == address(0)) {
            revert BasicNft__TokenUriNotFound();
        }
        return s_tokenIdToUri[tokenId]; // it must return ipfs link of tokenUri
    }

    function getTokenCounter() external view returns (uint256) {
        return s_tokenCounter;
    }
}
