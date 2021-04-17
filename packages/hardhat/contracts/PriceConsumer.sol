pragma solidity ^0.6.6;
import './IOracle.sol';

//Get Off Chain Data And Update On Chain Data
contract PriceConsumer{
    IOracle public oracle;

    constructor (address _oracle)public{
        oracle = IOracle(_oracle);
    }

    function getPrice() external returns(uint){
        bytes32 key = keccak256(abi.encodePacked('BNB/USD'));

        (bool result,uint timestamp,uint data) = oracle.getDataOffChain(key);
        require(result == true,'Could Not Get The Price From  Coin Gecko');
        require(timestamp >= block.timestamp - 2 minutes,'Invalid Price Too Old');
        //Update Africa Token Price
        return data;

    }
}

