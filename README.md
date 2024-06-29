# Mint Token Project

## Overview

The `Token` smart contract facilitates the creation and management of a basic ERC20 token on the Ethereum blockchain. It allows users to mint new tokens, burn existing tokens, transfer tokens between addresses, and approve transfers on behalf of token holders. The contract also includes ownership functionality, ensuring that administrative rights over the token are controlled securely.

## Features

1. **ERC20 Token Standard**
   - Implements standard ERC20 token functionalities for transfers and approvals.
2. **Customizable Token**
   - Token name set to "Token" and symbol to "MTK" during deployment.
3. **Initial Token Supply**
   - Mints and assigns an initial supply of tokens to the contract deployer.
4. **Owner Operations**
   - **Minting**: Owner can mint new tokens and allocate them to specified addresses.
   - **Burning**: Any token holder can burn their tokens, reducing the total supply.
   - **Approvals**: Token holders can approve other addresses to spend tokens on their behalf.
   - **Ownership Transfer**: Allows for secure transfer of contract ownership.
5. **Enhanced Transfers**
   - Includes functionalities for direct token transfers between addresses.
   - Implements delegated transfers via approvals.


## Project Structure

- **`Token.sol`**: Solidity smart contract file defining the ERC20 token with minting, burning, and ownership management functionalities.

## Getting Started

### Installing

To use this contract:

1. Clone or download the contract file (`Token.sol`).
2. Ensure you have a Solidity development environment set up.

### Executing Program

## Compiling and Deploying the Token Contract

### Compile the Contract

1. **Open Remix**:
   - Visit [Remix](https://remix.ethereum.org/).

2. **Load the Contract**:
   - Create a new file named `Token.sol` and paste the contract code into it.

3. **Compile the Code**:
   - Click on the "Solidity Compiler" tab in the left-hand sidebar.
   - Ensure the "Compiler" option is set to "0.8.4" (or another compatible version).
   - Click on the "Compile Token.sol" button.

# Create and Mint Token

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Token is ERC20, Ownable {
    constructor(uint256 initialSupply, address initialOwner) ERC20("Token", "MTK") Ownable(initialOwner) {
        _mint(initialOwner, initialSupply);
    }

    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }

    function burn(uint256 amount) external {
        _burn(_msgSender(), amount);
    }

    function approveTransfer(address spender, uint256 amount) external returns (bool) {
        _approve(_msgSender(), spender, amount);
        return true;
    }

    function transfer(address to, uint256 amount) public override returns (bool) {
        _transfer(_msgSender(), to, amount);
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
### Deploy the Contract

1. **Deploy Using Remix**:
   - Click on the "Deploy & Run Transactions" tab in the left-hand sidebar.
   - Select the "Token" contract from the dropdown menu.
   - Set the initial supply and initial owner in the deployment parameters.
   - Click on the "Deploy" button.

### Interact with the Contract

1. **Mint Tokens**:
   - Select the deployed contract instance in the left-hand sidebar.
   - Call the `mint` function by providing the recipient address and the amount to mint.

2. **Burn Tokens**:
   - Call the `burn` function by providing the amount of tokens to burn.

3. **Approve Transfer**:
   - Call the `approveTransfer` function by providing the spender address and the amount to approve.

4. **Transfer Tokens**:
   - Call the `transfer` function by providing the recipient address and the amount to transfer.

5. **Transfer Tokens on Behalf**:
   - Call the `transferFrom` function by providing the sender address, recipient address, and the amount to transfer.

## License
This project is licensed under the MIT License. See the LICENSE file for details.
