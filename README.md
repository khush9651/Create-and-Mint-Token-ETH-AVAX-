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
2. **Install Dependencies**:
   No frontend dependencies required.

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.9.2/contracts/token/ERC20/ERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.9.2/contracts/access/Ownable.sol";

contract Token is ERC20, Ownable {
    constructor() ERC20("Token", "MTK") {
        _mint(msg.sender, 1000000 * 10 ** decimals());
        transferOwnership(msg.sender);
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function burn(address account, uint256 amount) public {
        _burn(account, amount);
    }

    function transferOwnership(address newOwner) public override onlyOwner {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        emit OwnershipTransferred(owner(), newOwner);
        _transferOwnership(newOwner);
    }

    function approveTransfer(address spender, uint256 amount) public returns (bool) {
        _approve(msg.sender, spender, amount);
        return true;
    }

    function transferFrom(address from, address to, uint256 amount) public override returns (bool) {
        require(_msgSender() == owner() || allowance(from, _msgSender()) >= amount, "ERC20: transfer amount exceeds allowance");
        _transfer(from, to, amount);
        if (_msgSender() != owner()) {
            _approve(from, _msgSender(), allowance(from, _msgSender()) - amount);
        }
        return true;
    }
}
```

## Deployment

### Deploy the Smart Contract

Use Remix, Hardhat, or Truffle to compile and deploy `Token.sol` on your desired Ethereum network (e.g., Rinkeby, Ropsten).

## Interact with the Contract

After deployment, interact with the contract functions:

- **Mint tokens**: Use the `mint` function to create and allocate tokens to specified addresses.
- **Burn tokens**: Utilize the `burn` function to reduce the total token supply by burning tokens from an account.
- **Transfer ownership**: Execute the `transferOwnership` function to transfer ownership of the contract to a new address.
- **Approve and transfer tokens**: Use ERC20 standard functions like `approve` and `transferFrom` to approve token transfers and transfer tokens between addresses.

## Example Usage

```solidity
// Deploy the contract and interact with it via transactions
// Example transactions to mint tokens, burn tokens, transfer ownership, etc.
```

## License
This project is licensed under the MIT License. See the LICENSE file for details.
