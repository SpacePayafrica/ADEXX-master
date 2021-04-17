pragma solidity ^0.6.6;

contract Oracle{
    struct Data{
        uint date;
        uint payload;
    }

    address public admin;
    mapping(address => bool) public reporters;
    mapping(bytes32 => Data) public data;

    constructor()public{
        admin = msg.sender;
    }

    function updateReporter(address reporter,bool isReporter) external{
        require(msg.sender == admin,'only the admin');
        reporters[reporter] = isReporter;
    }

    function updateData(bytes32 key,uint payload) external {
        require(reporters[msg.sender] == true,'only the Reporter');
        data[key] = Data(block.timestamp,payload);
    }

    function getDataOffChain(bytes32 key)
     external
     view
     returns(bool result,uint date,uint payload){
         if(data[key].date == 0){
             return (false,0,0);
         }
         return(true,data[key].date,data[key].payload);
     }

}