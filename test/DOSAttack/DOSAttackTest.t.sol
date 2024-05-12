
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";

import {Distribute} from "../../src/DOSAttack/Distribute.sol";
import {DOSAttacker} from "../../src/DOSAttack/DOSAttacker.sol";

contract DOSAttackTest is Test{
    Distribute public distribute;
    DOSAttacker public attacker;

    function setUp() public {
        distribute = new Distribute();
        attacker = new DOSAttacker(address(distribute));

    }

    function testDOSAttack() public {
        
        address alex = address(0x1);
        address bob = address(0x2);
        deal(alex, 1 ether);
        deal(bob, 1 ether);
        // 普通用户1投资
        vm.startPrank(alex);
        distribute.invest{value: 0.01 ether}();
        vm.stopPrank();
        //攻击者投资
        attacker.invest{value: 0.1 ether}();

        // 普通用户2投资
        vm.startPrank(alex);
        distribute.invest{value: 0.01 ether}();
        vm.stopPrank();

        //平台分配投资
        distribute.distribute();
    }

}