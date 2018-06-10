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

### DataBase - SQLite
* Sqlite being the defacto and deJure standard of Android apps is being used here.

### Server
Although the server is not yet ready, I plan to write it in node
* You need to have node and npm installed in your machine.
* open up your teminal or command prompt go to the directory `chat`
* Do install all dependencies using  
   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`npm install`  
   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`npm install -g nodemon`  
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`npm start`  
Your server will be setup and ready for use.

### UI
* Go to browser and type `localhost:8080` in place of url.
* Register user by giving basic details.
* Login from the same screen.  
`Note: Handle should be unique for every user.`

# Why I started this
I had seen a lot of times during local areas like coffee shops that people find it difficult to interact with each other may be due to hesitation. Most of the local chats that we find will be again public and the interactions become public. So I was thinking of creating an application where people can talk in public as well as private.

# Few Screen Shots
#### Main Screen
![chat screen](https://github.com/kararnab/ChatApp/blob/master/screenshots/chat_history.png "Chat Page")  
#### Call history
![call screen](https://github.com/kararnab/ChatApp/blob/master/screenshots/call_history.png "Call Page")  


# Upcoming
I have lot of things to do. 
* Rewrite the whole code in kotlin.
* Writing the socket logics
* Bug fixes.
* More feauters to come, like blocking a user from chatting etc.  
* Option for saving chats in case you need it.

# Suggestions
If you have any suggestions please do mail me at `arnabrocking@gmail.com` with subject as `whatsappclone-suggestions`

License
-------
Like the rest of Gradle, the _Gradle Kotlin DSL_ is released under version 2.0 of the [Apache License](LICENSE.md).

# Credits
I was inspired by the challenges faced by my friends. I wanted to find out a soluton. So, credit goes to them.