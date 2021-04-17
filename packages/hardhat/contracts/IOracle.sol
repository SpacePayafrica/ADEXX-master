pragma solidity ^0.6.6;

interface IOracle{
    function getDataOffChain(bytes32 key)
    external
    view
    returns(bool result,uint date,uint payload);
}