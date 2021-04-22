import { useState } from "react";
import { usePoller } from "eth-hooks";
const Web3Utils = require('web3-utils');
const CoinGecko = require ('coingecko-api');

export default function useExchangePriceOffChain(targetNetwork,writeContracts,pollTime) {
  const [price, setPrice] = useState(0);
  const coinGeckoClient = new CoinGecko();

  const pollPrice = () => {
    async function getPrice() {
      if(targetNetwork.price){
        //setPrice(targetNetwork.price)
      }else{
        const response = await coinGeckoClient.coins.fetch('binancecoin',{});
        let currentPrice = parseFloat(response.data.market_data.current_price.usd);
        currentPrice = parseInt(currentPrice * 100);
        console.log("Web3Uitils",Web3Utils);

        if (typeof writeContracts === 'undefined'){
          const invalid = 'true';
          } else {    
            try {
              let approveTx;
             
              const shaValue = Web3Utils.soliditySha3('BNB/USD');
              console.log("SHA Value",shaValue);
              //approveTx = await writeContracts.Oracle.updateData(shaValue,currentPrice);
              console.log("TX VALUE ",approveTx);    

            } catch (error) {
              console.log(error);
            }                
          }

        console.log("Price Recieved ",currentPrice)

      }
    }
    getPrice();
  };
  usePoller(pollPrice, pollTime || 10777);

  return price;
}
