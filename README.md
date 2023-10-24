## Remote debug go pod without using a debug build image

### Load image to kind cluster (optional: to test the sample in this repo using kind)
```
kind load docker-image my-test-app:latest  --name kind
kind load docker-image delve-debug:latest  --name kind
```

### Attach delve process to go process

Launch `delve` as an ephemeral container to the `pod` and in the same PID namespace of the target container. Here `1` is the `pid` of the process started by go binary.

```
k debug --profile=general --target=my-test-app --image=amila15/delve-debug:v1.0.0 my-test-app -- dlv --listen=127.0.0.1:2345 --headless=true --accept-multiclient --api-version=2 attach 1
```

### Debug launcher in vs code

```
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "debug",
            "type": "go",
            "request": "attach",
            "mode": "remote",
            "debugAdapter": "dlv-dap",
            "substitutePath": [
                {
                    "from": "${workspaceFolder}",
                    "to": "/build"
                }
            
            ],
            "port": 2345,
            "host": "127.0.0.1",
        }
    ]
}
```
