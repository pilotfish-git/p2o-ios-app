# p2o-ios-app

The Pilotfish P2O server uses a web socket connection to be able to notify clients realtime on 'button presses'.
To setup the web socket connection, this project uses the [socket.io-client-swift](https://github.com/socketio/socket.io-client-swift) library.

The Pilotfish websocket endpoint runs at `http://p2o.pilotfish-demo-portal.eu:3001`. You can prepare your connection with:

```swift
let socket = SocketIOClient(socketURL: NSURL(string:"http://p2o.pilotfish-demo-portal.eu:3001")!)
```

and then connect with:

```swift
socket.connect()
```

The Pilotfish websocket API is pretty simple. When having connected you will be able to listen
for the following responses:

```swift
socket.on("connection-response") {data in
    self.socket.emit("register", "test")
}
```

After you connect to the server with `socket.connect()`, the server will respond with `connection response`.
The data from the response contains a `status` property, that can be `success` or `failed`. if the `data.status`
property is `success`, you need to emit a `register` message, with the button id as payload (in this case `test`).

```swift
socket.on("register-response", {data in
    counterLabel.text = "0"
}
```

After emitting the `register` message, the server will respond with `register-response` with in its data:
*   `status` (string): will be either `success` or `failed`
*   `button` (object, optional): if a button object is send, it means there is already a button registered on the server
with this id. The button object will contain the following properties:
    *   `id` (string)
    *   `count` (int) The amount of clicks that happened when client was offline.
    *   `history` (array) An array of max 20 ISO dates that represent last clicks of this button.

```swift
socket.on("button-press") {id in
    self.counter = self.counter + 1
    self.counterLabel.text = String(self.counter)
}
```

When a button is pressed when connected, the server will emit `button-press` with the `id` of the button as payload.