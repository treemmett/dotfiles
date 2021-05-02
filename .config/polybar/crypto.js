#!/usr/bin/env node
const WS = require('ws');
const fs = require('fs');

const subscriptions = [
  {
    product: 'ETH-USDC',
    display: 'ﲹ',
    price: '0.00',
  },
  {
    product: 'BTC-USDC',
    display: 'ﴑ',
    price: '0.00',
  },
];

let ws;

function open() {
  ws = new WS('wss://ws-feed.pro.coinbase.com');

  ws.on('message', (data) => {
    const body = JSON.parse(data.toString());

    // find subscription
    const subscription = subscriptions.find(
      (s) => s.product === body.product_id
    );
    if (!subscription) return;

    const price = parseFloat(body.price).toFixed(2);
    subscription.price = price;

    const output = subscriptions
      .map((s) => `${s.display} ${s.price}`)
      .join('  ');
    console.log(output);
  });

  ws.on('open', () => {
    ws.send(
      JSON.stringify({
        type: 'subscribe',
        product_ids: ['ETH-USDC', 'BTC-USDC'],
        channels: ['ticker'],
      })
    );
  });

  ws.on('error', (err) => {
    console.log(subscriptions.map((a) => a.display).join(' ') + ' ');
    fs.appendFile(('./crypto.log', '----------\n' + err + '\n\n\n'));
  });
}

open();

process.on('SIGINT', () => {
  console.log('\nClosing crypto');
  ws.close();
  process.exit();
});
