const express = require('express')
const WebSocket = require('ws')
const http = require('http');

const app = express()
var port = process.env.PORT || 3000;

const server = http.createServer(app);

app.get('/', (req, res) => res.send('Hey! Your Chat App is running fine.'))

const wss = new WebSocket.Server({server, path: "/chat"});
wss.on("connection", (ws) =>{
    try{
        const ejabberdWs = new WebSocket('ws://localhost:5280/websocket');

        ejabberdWs.on('error', (err) => {
            console.log('Error occurred while connecting to ejabberdWs:', err);
        });

        ejabberdWs.on('open', () => {
            console.log('Connected to ejabberdWs');
        });

        ws.on("message", (data)=>{
            if (ejabberdWs.readyState === WebSocket.OPEN) {
                ejabberdWs.send(data);
            } else {
                console.log('EjabberdWebServer is not available. Message not sent.');
                // You can also send a message back to the client WebSocket here
                // if you want to notify them that the message was not sent.
                // ws.send("ejabberdWs is not available. Message not sent.");
            }
        });

        ejabberdWs.on('message', function(msg) {
            console.log("ejabberdWs handled message");
            ws.send(msg)
        });
    } catch(e) {
        console.log('Error occurred:', e);
    }
});

server.listen(port, function(err) {
    if (err) {
        throw err;
    }
    console.log(`Our app is running on http://localhost:${port}!`);
});