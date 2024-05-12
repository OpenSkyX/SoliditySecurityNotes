// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";

import {EtherStore} from "../../src/ReentrancyAttack/EtherStore.sol";
import {Attack} from "../../src/ReentrancyAttack/Attack.sol";

contract ReentrancyAttackTest is Test {
    EtherStore public etherStore;
    Attack public attack;
    uint256 public initialBalance = 1 ether;
    uint256 public attackLimit = 10;

    address public attacker = address(123);

    function setUp() public {
        etherStore = new EtherStore();
        attack = new Attack(address(etherStore));
    }

    function test_Attack() public {
        deal(attacker, 100 ether);
        vm.startPrank(attacker);
        //用户存款
        etherStore.depositFunds{value: 5 ether}();
        console.log("after deposit:",address(etherStore).balance);
        // 攻击合约
        attack.attackDeposit{value: 1 ether}();
        console.log("after attack:",address(etherStore).balance);
        vm.stopPrank();
    }
}
