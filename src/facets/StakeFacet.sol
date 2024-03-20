// SPDX-License-Identifier: MIT
pragma solidity ^*;
import {LibAppStorage} from "../libraries/LibAppStorage.sol";
import {IERC20} from "../interfaces/IERC20.sol";

contract StakeFacet{

    LibAppStorage.Stake internal stake;
    LibAppStorage.StakeStorage internal stakeStorage;


    constructor(address stakeToken, address rewardToken, uint8 apy){
        stakeStorage.erc20StakeToken = stakeToken;
        stakeStorage.erc20RewardToken = rewardToken;
        stakeStorage.rewardRate = apy;
    }

    function stake(uint _amount) external {
        require(msg.sender != address(0), "address zero detected");
        require(amount > 0, "amount must be greater than zero");
        require(IERC20(stakeStorage.erc20StakeToken).balanceOf(msg.sender) >= _amount, "insufficient amount");

        IERC20(stakeStorage.erc20StakeToken).transferFrom(msg.sender, address(this), _amount);

        stake storage st = stakeStorage.stakes[msg.sender];
        st.amountStaked = st.amountStaked +  _amount;
        st.timeStaked = block.timestamp;
        st.reward = calculateReward(_amount);
    }


    function calculateReward(uint _amount) private pure returns(uint){
        uint e = block.timestamp - _amount;
        // 120/1e18;
        // (365 * 24 * 60 * 60 ./100)

        // uint reward =_amounbr*e/(365*24*6*) *duration/1e18;
    }

    function unStake() external {
        
    }
}