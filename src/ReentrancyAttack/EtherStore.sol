//SPDX-License-Identifier: MIT
pragma solidity  ^0.8.13;

contract EtherStore{

    mapping(address => uint256) public balances;

    bool reEntrancyAttack = false;

    function depositFunds() public payable{
        balances[msg.sender] += msg.value;
    }

    modifier noReEntrancy(){
        require(!reEntrancyAttack, "ReEntrancy Attack Detected");
        reEntrancyAttack = true;
        _;
        reEntrancyAttack = false;
    }


    function withdrawFunds() public noReEntrancy{
        uint256 _weiToWithdraw = balances[msg.sender];
        balances[msg.sender] = 0;
        payable(msg.sender).transfer(_weiToWithdraw);
    }

}