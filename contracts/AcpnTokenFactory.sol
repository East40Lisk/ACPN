// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract AcpnToken is ERC20, Ownable {
    constructor(string memory name, string memory symbol, address creator) ERC20(name, symbol) Ownable(creator) {}

    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }
}

contract AcpnTokenFactory is Ownable {
    struct CreatorReward {
        address creator;
        uint256 share;  // Basis points (e.g., 1000 = 10%)
    }

    mapping(address => CreatorReward[]) public tokenRewards;  // Token addr → ranked creators
    event RevenueDeposited(address token, uint256 amount);
    event RewardsDistributed(address token, uint256 total);

    constructor() Ownable(msg.sender) {}

    function createToken(string calldata name, string calldata symbol) external returns (address) {
        AcpnToken token = new AcpnToken(name, symbol, msg.sender);
        emit TokenCreated(address(token), name, msg.sender);
        return address(token);
    }

    // Platform sets top creators (off-chain oracle or governance)
    function setTopCreators(address token, CreatorReward[] calldata rewards) external onlyOwner {
        delete tokenRewards[token];
        uint256 totalShare = 0;
        for (uint256 i = 0; i < rewards.length; i++) {
            tokenRewards[token].push(rewards[i]);
            totalShare += rewards[i].share;
        }
        require(totalShare == 10000, "Shares must sum to 100%");  // 10000 bp = 100%
    }

    // Ad revenue deposit → auto-mint to creators
    receive() external payable {
        address tokenAddr = msg.sender;  // Assume called from platform token proxy
        require(tokenRewards[tokenAddr].length > 0, "No rewards set");

        uint256 totalReward = msg.value;
        for (uint256 i = 0; i < tokenRewards[tokenAddr].length; i++) {
            CreatorReward memory reward = tokenRewards[tokenAddr][i];
            uint256 amount = (totalReward * reward.share) / 10000;
            AcpnToken(tokenAddr).mint(reward.creator, amount);
        }

        emit RewardsDistributed(tokenAddr, totalReward);
    }
}