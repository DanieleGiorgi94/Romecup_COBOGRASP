/*
  Simple WebSocketServer example that can receive voice transcripts from Chrome
  Requires WebSockets Library: https://github.com/alexandrainst/processing_websockets
 */

import websockets.*;

WebsocketServer socket;

void setup() {
  var webSocketFactory = {
  connectionTries: 3,
  connect: function(url) {
    var ws = new WebSocket(url);
    ws.addEventListener("error", e => {
      // readyState === 3 is CLOSED
      if (e.target.readyState === 3) {
        this.connectionTries--;

        if (this.connectionTries > 0) {
          setTimeout(() => this.connect(url), 5000);
        } else {
          throw new Error("Maximum number of connection trials has been reached");
        }

      }
    }
  }
}

var webSocket = webSocketFactory.connect("ws://localhost:8025/myContextRoot");

}

void draw() {
}

void webSocketServerEvent(String msg){
 println(msg);
}