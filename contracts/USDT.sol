// contracts/SimpleToken.sol
// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

/**
 * @title SimpleToken
 * @dev Very simple ERC20 Token example, where all tokens are pre-assigned to the creator.
 * Note they can later distribute these tokens as they wish using `transfer` and other
 * `ERC20` functions.
 * Based on https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v2.5.1/contracts/examples/SimpleToken.sol
 */
contract USDT is ERC20 {
  /**
   * @dev Constructor that gives msg.sender all of existing tokens.
   */
  constructor(uint256 initialSupply) public ERC20("USDT", "USDT") {
    _mint(msg.sender, initialSupply);
  }
}
