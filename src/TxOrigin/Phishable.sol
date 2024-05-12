//SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Phishable {
    address public owner;
    
    constructor (address _owner) {
        owner = _owner; 
    }
    event WithdrawAll(address _recipient);
    
    receive () external payable {} // collect ether

    function withdrawAll(address _recipient) public {
        emit WithdrawAll(tx.origin);
        require(tx.origin == owner, "Not owner");
        payable(_recipient).transfer(address(this).balance); 
    }
}