// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {BasicNFT} from "../src/BasicNFT.sol";
import {DeployBasicNFT} from "../script/DeployBasicNFT.s.sol";
import {MintBasicNFT} from "../script/Interactions.s.sol";

contract BasicNFTTest is Test {
    BasicNFT public basicNFT;
    DeployBasicNFT public deployer;
    address public USER = makeAddr("user");
    string public constant PUG =
        "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";

    function setUp() public {
        deployer = new DeployBasicNFT();
        basicNFT = deployer.run();
    }

    function testNameIsCorrect() public view {
        string memory expectedName = "DOGIE";
        string memory actualName = basicNFT.name();
        assert(keccak256(abi.encodePacked(actualName)) == keccak256(abi.encodePacked(expectedName))); // hasg is a function that returns a fixed sized unique sstring that identifies that object
    }

    function testCanMintAndHaveABalance() public {
        vm.prank(USER);
        basicNFT.mintNft(PUG);
        assert(basicNFT.balanceOf(USER) == 1);
        assert(keccak256(abi.encodePacked(PUG)) == keccak256(abi.encodePacked(basicNFT.tokenURI(0)))); // bytes32
        assert(basicNFT.getTokenCounter() == 1);
    }

    function testMintWithScript() public {
        uint256 startingTokenCount = basicNFT.getTokenCounter();
        MintBasicNFT mintBasicNft = new MintBasicNFT();
        mintBasicNft.mintNftOnContract(address(basicNFT));
        assert(basicNFT.getTokenCounter() == startingTokenCount + 1);
    }
}
