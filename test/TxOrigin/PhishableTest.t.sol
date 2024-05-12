//SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";

import {Phishable} from "../../src/TxOrigin/Phishable.sol";
import {AttackPhishable} from "../../src/TxOrigin/AttackPhishable.sol";

contract ReentrancyAttackTest is Test {
    Phishable public phishable;
    AttackPhishable public attack;
    address public owner = address(0x9);
    address public attacker = address(0xA);

    function setUp() public {
        deal(owner, 2 ether);
        vm.startPrank(owner);
        phishable = new Phishable(owner);
        vm.stopPrank();
        attack = new AttackPhishable(address(phishable), attacker);
    }

    function testAttack() public {
        assert(phishable.owner() == owner);
        // 往被攻击合约中转入1 个以太坊
        payable(address(phishable)).transfer(1 ether);
        // 钓鱼合约调用被攻击合约的withdrawAll方法
        vm.startPrank(owner, owner);
        (bool success, ) = payable(address(attack)).call{value: 0.001 ether}(
            ""
        );
        require(success);
        vm.stopPrank();
        console.log("phishable balance: ", address(phishable).balance);
    }
}
