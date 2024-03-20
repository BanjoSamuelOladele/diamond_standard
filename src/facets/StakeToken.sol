

// SPDX-License-Identifier: MIT
pragma solidity ^*;
import {LibAppStorage} from "../libraries/LibAppStorage.sol";
import {IERC20} from "../interfaces/IERC20.sol";


contract StakeToken is IERC20{
    
    LibAppStorage.StakeToken internal stakeToken;

    constructor(string memory name, string memory symbol, uint decimal){
        stakeToken.name = name;
        stakeToken.symbol = symbol;
        stakeToken.owner = msg.sender;
        stakeToken.decimal = decimal;
        mint(msg.sender, (1000 * 10 ** decimal));
    }

    function mint(address _to, uint256 _value) external {
        stakeToken.balances[_to] += _value;
    }

    function totalSupply() external view returns (uint256){
        return stakeToken.totalSupply;
    }

    function balanceOf(address account) external view returns (uint256){
        return stakeToken.balances[user];
    }

    function allowance(address owner, address spender) external view returns (uint256){
        return stakeToken.allowances[owner][spender];
    }

    function transfer(address to, uint256 value) external returns (bool){
        _checker(msg.sender, to, value);
        require(stakeToken.balances[msg.sender] >= value, "insufficient balance");
        _transfer(msg.sender, to, value);
        return true;
    }

    function approve(address spender, uint256 value) external returns (bool){
        _checker(msg.sender, spender, value);
        require(stakeToken.balances[msg.sender] >= value, "insufficient balance");
        stakeToken.allowances[msg.sender][spender] = value;
    }

    function _transfer(address from, address to, uint amount) internal {
        require(stakeToken.balances[from] >= value, "insufficient balance");
        stakeToken.balances[from] -= value;
        stakeToken.balances[_to] += value;
    }

    function transferFrom(address from, address to, uint256 value) external returns (bool){
        _checker(from, to, value);
        require(stakeToken.allowances[from][to] >= value, "need to match approved amount from user");
        _transfer(from, to, value);
        return true;
    }

    function _checker(address from , address to, uint value) private {
        require(value > 0, "amount must be greater than zero");
        require(from != address(0), "address zero detected");
        require(to != address(0), "address zero");
    }
}