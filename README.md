WHATSAPP CLONE CHAT APP
========================

[![License](https://img.shields.io/badge/license-Apache%20License%202.0-blue.svg?style=flat)](http://www.apache.org/licenses/LICENSE-2.0)

Welcome! This is a chat application that can be used for local usage in a small network. It creates a local server and people connected to the network can do a group or private chat. It is in its initial phases of development now.
The chat part will be implemented using [sockets.io](https://socket.io).


# Instructions to run
Clone the project
```
git clone https://github.com/kararnab/ChatApp.git
```

### Useful Commands
These are the few useful commands
1. `./gradlew app:detekt` -> Static code analysis
2. `./gradlew app:lint` -> Lint check
3. `./gradlew app:dependencies` -> Getting the app dependency tree

### DataBase - SQLite
* Sqlite being the de-facto and deJure standard of Android apps is being used here.

### Server
Although the server is not yet ready, I plan to write it in Node Js/GoLang

### UI
* Go to browser and type `localhost:8080` in place of url.
* Register user by giving basic details.
* Login from the same screen.  
  `Note: Handle should be unique for every user.`

# Why I started this
Although there are apps like WhatsApp and Telegram, I feel, there's no proper open source app that can be installed in any area like a library, coffee shop etc. And that would be end to end encrypted.

# Few Screen Shots
#### Main Screen
![chat screen](https://github.com/kararnab/ChatApp/blob/master/screenshots/chat_history.png "Chat Page")
#### Call history
![call screen](https://github.com/kararnab/ChatApp/blob/master/screenshots/call_history.png "Call Page")


# Upcoming
Have a lot of things to do -
* Writing the socket logics
* Read and implement [Keystore](https://techenum.com/android-keystore-store-sensitive-data-in-android/)
* Option for saving chats in case you need it.

# Suggestions
If you have any suggestions please do mail me at `arnabrocking@gmail.com` with subject as `whatsappclone-suggestions`
