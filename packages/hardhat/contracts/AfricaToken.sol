pragma solidity ^0.6.6;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import './IOracle.sol';

contract AfricaToken is ERC20 {
  IOracle public oracle;
  uint256 public tokenPrice;
  constructor(address _oracle) ERC20("AFRICA Token","AFT") public {
      _mint(msg.sender,1000*10**18);
      oracle = IOracle(_oracle);
  }

  function setPrice() external{
        bytes32 key = keccak256(abi.encodePacked('BNB/USD'));

        (bool result,uint timestamp,uint data) = oracle.getDataOffChain(key);
        require(result == true,'Could Not Get The Price From Coin Gecko');
        require(timestamp >= block.timestamp - 2 minutes,'Invalid Price Too Old');
        //Update Africa Token Price
        uint256 priceUpdate = data*10**18;
        tokenPrice = priceUpdate;
    }
}
