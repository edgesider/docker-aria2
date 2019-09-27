## Description

Run a simple aria2 in docker.

## Available Environment Variables

- `U_ID`
Aria2's uid
- `G_ID`
Aria2's gid
- `SECRET`
RPC secret
- `GEN_TRACKER`
If true, it will auto generate tracker from [ngosang/trackerslist](https://github.com/ngosang/trackerslist).

## Example

```bash
docker run \
    -p 6800:6800 \
    -e U_ID=1000 \
    -e G_ID=1000 \
    -e SECRET="123456" \
    -e GEN_TRACKER="true" \
    -v {path to data directory}:/app/ \
    edgesider/aria2
```

```bash
docker run \
    -p 6800:6800 \
    -e U_ID=1000 \
    -e G_ID=1000 \
    -e SECRET="123456" \
    -e GEN_TRACKER="true" \
    -v {path to download directory}:/app/downloads \
    -v {path to config directory}:/app/conf \
    -v {path to session directory}:/app/session \
    edgesider/aria2
```
