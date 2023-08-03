// contract/ISeventToken.sol
//SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

interface ISeventToken {
    function transfer(address recipient, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
    function mint(uint256 amount) external;
    function burn(uint256 amount) external;
}