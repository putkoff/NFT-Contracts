# PutfiNFTStake.sol

## Overview

`PutfiNFTStake.sol` is a smart contract on the Ethereum blockchain, designed to handle the staking of Non-Fungible Tokens (NFTs). Written in Solidity ^0.8.0, this contract allows users to stake their NFTs, provided they meet specific criteria.

## Key Features

- **NFT Staking**: Supports the staking of NFTs identified by unique IDs.
- **Ownable Contract**: Incorporates ownership management with functions to transfer and renounce ownership.
- **Stake Tracking**: Maintains records of staked NFTs, including timestamps of when each NFT was staked.
- **Interface Compliance**: Implements the `IERC1155` interface for NFT interactions.
- **Stake Management**: Includes functions for both staking and unstaking NFTs.

## Usage

### Prerequisites

- A basic understanding of Ethereum and NFTs (ERC1155 standard).
- An Ethereum wallet with Ether for transactions and NFTs compatible with the contract for staking.

### Deployment

1. **Compile the Contract**: Use a Solidity compiler (version 0.8.0 or higher) to compile the contract.
2. **Deploy to Ethereum Network**: Deploy the contract to an Ethereum network using tools like Remix, Truffle, or Hardhat.

### Interacting with the Contract

- **Staking NFTs**: Users can stake their NFTs by calling the `stake` function with the NFT's ID and quantity.
- **Unstaking NFTs**: Users can unstake their NFTs using the `unstake` function, specifying the NFT's ID and quantity.
- **Checking Staked NFTs**: Users can check their staked NFTs and staking times via the contract's query functions.

### Functions

- `stake(uint256 _tokenId, uint256 _amount)`: Stake specified amount of NFTs with a given token ID.
- `unstake(uint256 _tokenId, uint8 _amount)`: Unstake a specified amount of NFTs with a given token ID.
- `changeNFTcontract(address contract_address)`: Update the address of the NFT contract (only callable by the owner).

## Security Considerations

- The contract is `Ownable`, allowing only the owner to perform critical functions.
- It's essential to ensure that the NFT contract address is set correctly to prevent issues with staking and unstaking.

## Customization

- The contract can be adapted to work with different types of NFTs (ERC1155) or modified to change staking logic, rewards, or penalties.
