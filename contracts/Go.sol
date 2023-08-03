// contracts/Go.sol
// SPDX-License-Identifier: MIT

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

pragma solidity ^0.8.19;

contract Go is ERC20, Ownable, Pausable {
    
    using SafeMath for uint256;
    uint256 public constant INITIAL_SUPPLY = 1000000000 * 10**18;
    uint256 public immutable MINT_AMOUNT = 100 * 10**18;

    constructor() ERC20("Go", "GO") {
        _mint(msg.sender, INITIAL_SUPPLY);
    }

}