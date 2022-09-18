//SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

/* 
In object-oriented programming an interface is a description of
all functions that an object must have in order for it to operate.

The purpose of an interface is to enforce a defined set properties
and to execute specific function in another object.

The interface contains function signatures without the function 
definition implementation (implementation details are less important).

You can use an interface in your contract to call functions in another
 contract.
*/

interface IWhitelist {
    function whitelistedAddresses(address) external view returns (bool);
}