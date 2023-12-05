# PutNodeNFT.sol

## Overview

`PutNodeNFT.sol` is a smart contract built on Ethereum, using Solidity version 0.8.13. It implements an ERC1155 token standard for managing and transferring Non-Fungible Tokens (NFTs). This contract is designed to support multiple types of NFTs, each identified by a unique ID.

## Key Features

- **ERC1155 Standard**: Supports the ERC1155 multi-token standard, enabling the management of multiple NFT types within a single contract.
- **SafeMath Library**: Includes functions to safely perform arithmetic operations and protect against common vulnerabilities like overflow and underflow.
- **NFT Variants**: Supports different NFT types like RedGiant, WhiteDwarf, and SuperNova, each with unique IDs and properties.
- **Minting and Burning**: Functions for minting new NFTs and burning existing ones.
- **URI Management**: Supports setting and updating URIs for different NFT types, linking to their metadata.

## Usage

### Prerequisites

- Familiarity with Solidity and ERC1155 token standard.
- An Ethereum wallet with enough Ether for deployment and transactions.

### Deployment

1. **Compile the Contract**: Use a Solidity compiler (version 0.8.13 or later) to compile the contract.
2. **Deploy to the Ethereum Network**: Deploy the contract to the Ethereum network (mainnet or testnet) using tools like Remix, Truffle, or Hardhat.

### Interacting with the Contract

- **Minting NFTs**: The contract owner or authorized managers can mint new NFTs.
- **Burning NFTs**: Holders of NFTs can burn their tokens.
- **Transferring NFTs**: Standard ERC1155 functions are available for transferring NFTs between addresses.
- **URI Management**: The contract owner can update the URI for each NFT type.

### Functions

- `mint`, `mintBatch`: Mint new NFTs.
- `burn`, `burnBatch`: Burn existing NFTs.
- `setURI`, `PsetURI`: Set or update URIs for NFT metadata.

## Security Considerations

- The contract uses OpenZeppelin's SafeMath library for arithmetic operations to prevent overflow and underflow errors.
- Regular audits and thorough testing are recommended to maintain contract security.
- Only the contract owner or authorized managers can mint new NFTs, offering a level of control over the NFT supply.

## Customization

- The contract can be customized to add more NFT types or modify existing ones.
- URI links can be updated to point to new metadata as needed.


