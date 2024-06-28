/* Token Smart Contract Walk-through

Overview
The `Token` contract is an ERC20 token implementation with additional functionalities for minting, burning, ownership management,
and secure token transfers.*/

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.9.2/contracts/token/ERC20/ERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.9.2/contracts/access/Ownable.sol";

contract Token is ERC20, Ownable {
    constructor() ERC20("MyToken", "MTK") {
        _mint(msg.sender, 1000000 * 10 ** decimals());  // Mint 1,000,000 tokens to the contract deployer
        transferOwnership(msg.sender);  // Transfer ownership to the deployer
    }

    /// @dev Mint new tokens and allocate them to the specified address
    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    /// @dev Burn tokens from a specified account
    function burn(address account, uint256 amount) public {
        _burn(account, amount);
    }

    /// @dev Transfer ownership of the contract to a new address
    function transferOwnership(address newOwner) public override onlyOwner {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        emit OwnershipTransferred(owner(), newOwner);
        _transferOwnership(newOwner);
    }

    /// @dev Approve a spender to transfer tokens on behalf of the owner
    function approveTransfer(address spender, uint256 amount) public returns (bool) {
        _approve(msg.sender, spender, amount);
        return true;
    }

    /// @dev Transfer tokens from one address to another
    function transferFrom(address from, address to, uint256 amount) public override returns (bool) {
        require(_msgSender() == owner() || allowance(from, _msgSender()) >= amount, "ERC20: transfer amount exceeds allowance");
        _transfer(from, to, amount);
        if (_msgSender() != owner()) {
            _approve(from, _msgSender(), allowance(from, _msgSender()) - amount);
        }
        return true;
    }
}

/*
Key Features
1. Constructor
The constructor initializes the token with the name "MyToken" and symbol "MTK". 
It mints 1,000,000 tokens to the deployer's address and transfers ownership to the deployer.
2. Minting
The `mint` function allows the contract owner to mint new tokens and allocate them to a specified address.
3. Burning
The `burn` function allows any account to burn their tokens, reducing the total supply.
4. Ownership Management
The contract implements Ownable from OpenZeppelin, enabling secure transfer of ownership. Only the contract owner can 
execute certain functions such as minting, burning, and transferring ownership.
5. Token Transfers

Implements ERC20 standard functions:
1. `transfer`: Transfer tokens from one address to another.
2. `transferFrom`: Transfer tokens on behalf of another address, subject to approval.
3. `approve`: Approve a spender to transfer tokens on behalf of the owner.

Deployment and Interaction
1. Deployment: Deploy this contract using tools like Remix or Hardhat.
2. Interaction: After deployment, interact with the contract:
  a) Mint tokens using the `mint` function.
  b) Burn tokens using the `burn` function.
  c) Transfer ownership using the `transferOwnership` function.
  d) Approve token transfers using the `approveTransfer` function.
  e) Transfer tokens between addresses using `transfer` and `transferFrom`.

Use tools and frameworks compatible with Solidity development to deploy and interact with this contract. */
