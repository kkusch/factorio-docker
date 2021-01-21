# Factorio
![Publish Factorio Image by TagVersion](https://github.com/kkusch/factorio-docker/workflows/Publish%20Factorio%20Image%20by%20TagVersion/badge.svg)

A Docker image for the [Factorio](https://www.factorio.com/) dedicated server.
- [Factorio Multiplayer](https://wiki.factorio.com/Multiplayer)

## Versions

See [tags](https://hub.docker.com/r/kkusch91/factorio/tags/) on DockerHub for options. If you don't see a version _after_ 1.1.12 that you are looking for, file an issue and or a pull request.

## Usage

The simplest example runs Factorio with default settings. We also mount a volume so that saves will be retained:

```bash
docker run -d \
  -v $PWD/server/saves:/opt/factorio/saves \
  -v $PWD/server/mods:/opt/factorio/mods \
  -v "$PWD/server/server-settings.example.json":"/opt/factorio/server-settings.json" \
  -p 34197:34197/udp \
  --name factorio_server \
  kkusch91/factorio:latest
```
## Troubleshooting

### Authorization Error

If your container exits with the following error:
```bash
Info HttpSharedState.cpp:83: Status code: 401
Info AuthServerConnector.cpp:40: Error in communication with auth server: code(401) message({
  "message": "Username and password don't match",
  "status": 401
})
Info AuthServerConnector.cpp:68: Auth server authorization error (Username and password don't match)
Error Util.cpp:57: Unknown error
```
Check supplied Username and Password or Token for mistakes.


## Local build

If you want to build your contailer locally use ``./build.sh <FACTORIO_VERSION>``

## Example Docker-Compose

```yaml
version: "3.3"
services:
  factorio:
    image: kkusch91/factorio:latest
    deploy:
      replicas: 1
    ports:
      - "34197:34197/udp"
    volumes:
      - ./server/server-settings.example.json:/opt/factorio/server-settings.json
      - ./server/server-adminlist.example.json:/opt/factorio/server-adminlist.json
      - ./server/saves:/opt/factorio/saves
      - ./server/mods:/opt/factorio/mods
```
