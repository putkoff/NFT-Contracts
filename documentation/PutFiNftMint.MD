# PutFiNftMint.sol

## Overview

`PutFiNftMint.sol` is a smart contract developed for the Ethereum blockchain, written in Solidity ^0.8.0. This contract is designed to facilitate the minting of Non-Fungible Tokens (NFTs) under specific conditions and parameters. It leverages the ERC20 standard for handling token-related operations.

## Features

- **NFT Minting**: Supports the minting of NFTs with different tiers (tier_1, tier_2, tier_3).
- **Ownership Management**: Includes functions for transferring ownership and renouncing ownership, following the `Ownable` pattern.
- **Supply and Cost Management**: Allows setting the maximum supplies for NFT tiers and their corresponding costs.
- **Transfer and Withdraw Functions**: Facilitates the transfer of NFTs and withdrawal of funds.
- **Safe ERC20 Interactions**: Utilizes the `SafeERC20` library for safe interactions with ERC20 tokens.
- **Access Control**: Includes functions for updating managers and controlling access to certain contract functions.

## Usage

### Prerequisites

- Solidity ^0.8.0 or higher for compilation.
- An Ethereum wallet with Ether for deploying and interacting with the contract.

### Deployment

1. **Compile the Contract**: Use a Solidity compiler to compile the `PutFiNftMint.sol` contract.
2. **Deploy on Ethereum Network**: Deploy the contract to the Ethereum network using tools like Remix, Truffle, or Hardhat.

### Interacting with the Contract

- **Minting NFTs**: Users can mint NFTs by calling the `mint` function with the appropriate tier ID and payment.
- **Setting NFT Costs and Supplies**: The contract owner can set the cost and maximum supply for each NFT tier.
- **Ownership Management**: The owner can transfer or renounce ownership of the contract.
- **Fund Withdrawal**: The owner can withdraw funds from the contract.

### Functions

- `mint(uint256 _id)`: Mint NFTs of a specific tier.
- `changeCostNfts(uint256[3] memory _costs)`: Change the cost of NFTs.
- `updateManagers(address newVal)`: Update manager addresses.
- `transferOut(address payable _to,uint256 _amount)`: Withdraw Ether from the contract.

## Security Considerations

- The contract uses SafeERC20 library for secure ERC20 token transactions.
- Regular audits and thorough testing are recommended to maintain the security of the contract.
- Access control mechanisms are in place to restrict sensitive functions to authorized users only.

## Customization

- The contract can be customized to handle different NFT tiers, costs, and supplies.
- Additional functionalities can be added as per the project's requirements.

