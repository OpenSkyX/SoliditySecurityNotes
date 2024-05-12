// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Distribute {
    address public owner; // gets set somewhere
    address[] investors; // array of investors
    uint[] investorTokens; // the amount of tokens each investor gets


    function invest() public payable {
        investors.push(msg.sender);
        investorTokens.push(msg.value); // 5 times the wei sent
    }

    function distribute() public {
        require(msg.sender == owner); // only owner
        for (uint i = 0; i < investors.length; i++) {
            // here transferToken(to,amount) transfers "amount" of tokens to the address "to"
            payable(investors[i]).transfer(investorTokens[i]);
        }
    }
}
