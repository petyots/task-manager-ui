# task-manager-ui

## Build Setup

```bash
# copy .env
cp .env.example .env

# Build image
$ docker build -t task-manager-ui . 

# Start app container in detached mode
docker run -dp  3000:3000 task-manager-ui-

# Will be available at https://localhost:3000
```
[Task Manager UI](https://localhost:3000) (http://localhost:3000)
