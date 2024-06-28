# Mint Token Project

## Overview

This repository contains a Solidity smart contract for creating an ERC20 token named "Token" (symbol: "MTK"). 
The contract includes capabilities for minting new tokens, burning existing tokens, managing ownership, and facilitating token transfers according to the ERC20 standard.

## Features

- **Token Contract**: Implements ERC20 functionality with name "Token" and symbol "MTK".
- **Minting**: Contract owner can mint new tokens and allocate them to specified addresses.
- **Burning**: Allows any token holder to burn their tokens, reducing the total supply.
- **Ownership Management**: Utilizes OpenZeppelin's Ownable contract for secure ownership transfer and access control.
- **Token Transfers**: Implements ERC20 functions (transfer, transferFrom, approve) for seamless token transfers between addresses.

## Project Structure

- **`Token.sol`**: Solidity smart contract file defining the ERC20 token with minting, burning, and ownership management functionalities.

## Getting Started

### Prerequisites

- **Node.js**: Ensure Node.js is installed on your machine.
- **MetaMask**: Install MetaMask browser extension for Ethereum network interaction.

### Setup

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/your-username/token-smart-contract.git
   cd token-smart-contract
