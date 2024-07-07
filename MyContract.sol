// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract MyContract {
    uint256 public value;
    address public owner;

    event ValueIncreased(uint256 oldValue, uint256 newValue, uint256 finalValue);
    event ValueDecreased(uint256 oldValue, uint256 decrementValue, uint256 finalValue);
    event LogString(string message);

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the contract owner");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function setValue(uint256 newValue) public onlyOwner {
        value = newValue;
    }

    function resetValue() public onlyOwner {
        require(value != 0, "Value is already zero");
        value = 0;
    }

    function increaseValue(uint256 newValue) public onlyOwner {
        uint256 oldValue = value;
        value = value + newValue;
        emit ValueIncreased(oldValue, newValue, value);
    }

    function decreaseValue(uint256 decrementValue) public onlyOwner {
        uint256 oldValue = value;
        require(decrementValue <= value, "Decrement value exceeds current value");
        value = value - decrementValue;
        emit ValueDecreased(oldValue, decrementValue, value);
    }

    function isOwner() public view returns (bool) {
        return msg.sender == owner;
    }

    function getCurrentValue() public view returns (uint256) {
        return value;
    }
}
