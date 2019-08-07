```bash
docker run \
    -p 6800:6800 \
    -e UID=1000 \
    -e GID=1000 \
    -e SECRET="123456" \
    -e GEN_TRACKERS="true" \
    -v /var/docker/aria2/:/app/ \
    -v /var/docker/aria2/downloads:/app/downloads \
    -v /var/docker/aria2/conf:/app/conf \
    -v /var/docker/aria2/session:/app/session \
    edgesider/aria2
```
