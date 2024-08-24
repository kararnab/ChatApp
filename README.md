## 1. Introduction

This is a chat server implementation, optimized with the help of CodeLLAMA and ChatGPT

## 2. Setup

### Create Self signed SSL Certificate

```bash
openssl req -x509 -newkey rsa:4096 -nodes -keyout ejabberd.key -out ejabberd.pem -days 365 -subj "/C=US/ST=State/L=Locality/O=Organization/CN=localhost"
```

### Access Ejabberd

You can access them using-

- WebSocket(ws): `ws://localhost:5280/websocket`
- XMPP: `localhost:5222`
- You can access the Ejabberd web admin interface via http://localhost:5280/admin using the default credentials (which can be changed in the Ejabberd configuration).

## 3. Folder Structure

```
project-root/
│
├── k8s/
│ ├── ejabberd-statefulset.yaml         # StatefulSet for Ejabberd
│ ├── nodejs-deployment.yaml            # Deployment for Node.js server
│ ├── postgres-statefulset.yaml         # StatefulSet for PostgreSQL
│ ├── persistent-volumes.yaml           # Persistent Volumes and Claims
│
├── ejabberd/
│ ├── Dockerfile                        # Dockerfile for Ejabberd
│ └── ejabberd.yml                      # Configuration file for Ejabberd
│
├── nodejs/
│ ├── Dockerfile                        # Dockerfile for Node.js server
│ └── server.js                         # Node.js server code
│
└── postgres/
    └── init.sql                        # SQL script to initialize PostgreSQL database
```

### Folder Contents Explained:

k8s/ Directory:

ejabberd-statefulset.yaml: Defines the StatefulSet for the Ejabberd server, ensuring persistent storage and stable network identity.
nodejs-deployment.yaml: Defines the Deployment for the Node.js server that communicates with the Ejabberd XMPP server.
postgres-statefulset.yaml: Defines the StatefulSet for PostgreSQL, ensuring persistent storage and stable network identity.
persistent-volumes.yaml: Contains PersistentVolumeClaim (PVC) definitions for PostgreSQL and Ejabberd, ensuring data persistence.
ejabberd/ Directory:

Dockerfile: The Dockerfile for building the custom Ejabberd Docker image.
ejabberd.yml: Configuration file for Ejabberd, customized to connect to the PostgreSQL database and handle XMPP-related configurations.
nodejs/ Directory:

Dockerfile: The Dockerfile for building the Node.js server Docker image.
server.js: The Node.js application code that interacts with the Ejabberd server for 1:1 chat functionality.
postgres/ Directory:

init.sql: SQL script for initializing the PostgreSQL database with the required database and user for Ejabberd.

## Deployment Order:

1. Build Docker Images

2. Persistent Volumes:

Start by applying the persistent-volumes.yaml to set up persistent storage.
PostgreSQL StatefulSet:

3. Deploy the postgres-statefulset.yaml to bring up the PostgreSQL database.
   Ejabberd StatefulSet:

Deploy the ejabberd-statefulset.yaml to bring up the Ejabberd server.
Node.js Deployment:

4. Finally, deploy the nodejs-deployment.yaml to launch the Node.js server that will communicate with Ejabberd.
