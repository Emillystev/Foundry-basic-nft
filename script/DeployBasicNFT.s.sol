// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {BasicNFT} from "../src/BasicNFT.sol";

contract DeployBasicNFT is Script {
    function run() external returns (BasicNFT) {
        uint256 INITIAL_SUPPLY = 100 ether;
        vm.startBroadcast();
        BasicNFT basicNFT = new BasicNFT(INITIAL_SUPPLY);
        vm.stopBroadcast();
        return basicNFT;
    }
}
