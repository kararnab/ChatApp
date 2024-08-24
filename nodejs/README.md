# Chat Node

## About

This is the backend of the chat server, created in NodeJs

## Docker Setups and Commands

1. Build the docker image

```bash
docker build -t [TAG] .
```

2. Run the docker build

```bash
docker run --env-file .env -p [ExternalPort -> 3000]:[InternalPort -> 3000] [TAG]
```

3. Once the container is running, you can access the application by navigating to http://localhost:3000 in your browser.
