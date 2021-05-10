#!/bin/bash

# COINS
BTC="https://www.tradingview.com/chart/?symbol=COINBASE%3ABTCEUR"
ETH="https://www.tradingview.com/chart/?symbol=COINBASE%3AETHEUR"
DOGE="https://www.tradingview.com/chart/?symbol=BITTREX%3ADOGEUSD"
ADA="https://www.tradingview.com/chart/?symbol=COINBASE%3AADAEUR"
COINS=()
COINS[0]=$BTC
COINS[1]=$ETH
COINS[2]=$ADA
COINS[3]=$DOGE

#echo ${COINS[0]}
#echo ${COINS[1]}
#echo ${COINS[2]}
#echo ${COINS[3]}

if [[ $# -eq 0 ]];then
	# open new chrome window
	google-chrome --new-window $BTC
fi
