



// SPDX-License-Identifier: MIT
pragma solidity ^*;
import {LibAppStorage} from "../libraries/LibAppStorage.sol";
import {IERC20} from "../interfaces/IERC20.sol";


contract RewardToken is IERC20{
    
    LibAppStorage.Token internal rewardToken;

    constructor(string memory name, string memory symbol, uint decimal){
        rewardToken.name = name;
        rewardToken.symbol = symbol;
        rewardToken.owner = msg.sender;
        rewardToken.decimal = decimal;
        mint(msg.sender, (1000 * 10 ** decimal));
    }

    function mint(address _to, uint256 _value) external {
        rewardToken.balances[_to] += _value;
    }

    function totalSupply() external view returns (uint256){
        return rewardToken.totalSupply;
    }

    function balanceOf(address account) external view returns (uint256){
        return rewardToken.balances[user];
    }

    function allowance(address owner, address spender) external view returns (uint256){
        return rewardToken.allowances[owner][spender];
    }

    function transfer(address to, uint256 value) external returns (bool){
        _checker(msg.sender, to, value);
        require(rewardToken.balances[msg.sender] >= value, "insufficient balance");
        _transfer(msg.sender, to, value);
        return true;
    }

    function approve(address spender, uint256 value) external returns (bool){
        _checker(msg.sender, spender, value);
        require(rewardToken.balances[msg.sender] >= value, "insufficient balance");
        rewardToken.allowances[msg.sender][spender] = value;
    }

    function _transfer(address from, address to, uint amount) internal {
        require(rewardToken.balances[from] >= value, "insufficient balance");
        rewardToken.balances[from] -= value;
        rewardToken.balances[_to] += value;
    }

    function transferFrom(address from, address to, uint256 value) external returns (bool){
        _checker(from, to, value);
        require(rewardToken.allowances[from][to] >= value, "need to match approved amount from user");
        _transfer(from, to, value);
        return true;
    }

    function _checker(address from , address to, uint value) private {
        require(value > 0, "amount must be greater than zero");
        require(from != address(0), "address zero detected");
        require(to != address(0), "address zero");
    }
}