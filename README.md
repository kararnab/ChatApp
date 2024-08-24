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

1. Build Docker Images and Load them to minikube like
```bash
docker context use default
docker build -t [TAG] .
minikube image load chatapp:latest
minikube image load ejabberd:latest
```

2. Create Config Map (Optional)
```bash
kubectl create configmap postgres-initdb-configmap --from-file=init-user-db.sh
```

3. Deploy Persistent Volumes and Claims:
```bash
kubectl apply -f k8s/persistent-volumes.yaml
```

4. Deploy PostgreSQL StatefulSet:
```bash
kubectl apply -f k8s/postgres-statefulset.yaml
```

5. Deploy Ejabberd StatefulSet:
```bash
kubectl apply -f k8s/ejabberd-statefulset.yaml
```

6. Node.js Deployment:

Finally, deploy the nodejs-deployment.yaml to launch the Node.js server that will communicate with Ejabberd.

7. Useful Minikube commands
    - minikube ip
    - minikube dashboard
    - minikube service [ServiceName] --url
    - kubectl get pods

