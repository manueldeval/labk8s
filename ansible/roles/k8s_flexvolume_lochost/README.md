Usage:

```
apiVersion: v1
kind: Pod
metadata:
  name: nginx-dummy
  namespace: default
spec:
  containers:
  - name: nginx-dummy
    image: nginx
    volumeMounts:
    - name: dummy
      mountPath: /data
    ports:
    - containerPort: 80
  volumes:
  - name: dummy
    flexVolume:
      driver: "lab/lochost"
      options:
        volumeID: "nginx-volume"
```

