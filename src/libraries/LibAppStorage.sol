
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library LibAppStorage {
    // stake info storage
    struct Stake {
        uint256 amountStaked;
        uint256 timeStaked;
        uint256 reward;
    }

    // stake storage
    struct StakeStorage {
        address erc20StakeToken;
        address erc20RewardToken;
        uint8 rewardRate = ;
        mapping(address => Stake) stakes;
    }

    struct Token{
		mapping(address => uint256) balances;
        mapping(address => mapping(address => uint256)) allowances;
        uint256 totalSupply;
        string name;
        string symbol;
        uint8 decimal;
        address owner;
	}

}
