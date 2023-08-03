// contracts/SeventToken.sol
//SPDX-License-Identifier: MIT

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "./ISeventToken.sol";

pragma solidity ^0.8.19;

contract SeventToken is ERC20, Ownable, Pausable{

    using SafeMath for uint256;
    uint256 public constant INITIAL_SUPPLY = 400000000 * 10**18;
    uint256 public MINT_AMOUNT = 100 * 10**18;

    event TokenBurned(address indexed burner, uint256 amount);
    event TokenMinted(address indexed minter, uint256 amount);

    constructor() ERC20("SeventToken", "Svt") {
        _mint(msg.sender, INITIAL_SUPPLY);
    }

    function transfer(address recipient, uint256 amount) public virtual override whenNotPaused returns(bool) {
        require(amount <= balanceOf(msg.sender), "insufficient balance");

        _transfer(msg.sender, recipient, amount);
        return super.transfer(recipient, amount);
    }

    function transferFrom(address sender, address recipient, uint256 amount) public virtual whenNotPaused override returns (bool) {
        require(_msgSender() == sender || amount <= allowance (sender, _msgSender()), "ERC20: transfer amount exceeds allowance");
        _transfer(sender, recipient, amount);

        if (_msgSender() != sender && allowance(sender, _msgSender()) != type(uint256).max) {
            _approve(sender, _msgSender(), allowance(sender, _msgSender())- amount);
        }
        return super.transferFrom(sender, recipient, amount);
    }

    function burn(uint256 amount) public {
        _burn(msg.sender, amount);
        emit TokenBurned(msg.sender, amount);
    }

    function mint(uint256 amount) public onlyOwner{
        _mint(msg.sender, amount);
        emit TokenMinted(msg.sender, amount);
    }

}