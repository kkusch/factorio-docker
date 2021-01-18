# Factorio
![Publish Factorio Image by TagVersion](https://github.com/kkusch/factorio-docker/workflows/Publish%20Factorio%20Image%20by%20TagVersion/badge.svg)

A Docker image for the [Factorio](https://www.factorio.com/) dedicated server.

## Versions

See [tags](https://hub.docker.com/r/kkusch91/factorio/tags/) on DockerHub for options. If you don't see a version _after_ 0.16.51 that you are looking for, file an issue and or a pull request.

## Usage

The simplest example runs Factorio with default settings. We also mount a volume so that your saves will be retained:
```
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
```
Info HttpSharedState.cpp:83: Status code: 401
Info AuthServerConnector.cpp:40: Error in communication with auth server: code(401) message({
  "message": "Username and password don't match",
  "status": 401
})
Info AuthServerConnector.cpp:68: Auth server authorization error (Username and password don't match)
Error Util.cpp:57: Unknown error
```
Check supplied Username and Password for mistakes.

## Cutting a new release

For maintainers with write access to Quay, here's how to cut a new release:
```
./make_release.sh <version>
```
This will download the correct archive, build a Docker image, and run it locally. Test against the built image, then CTRL+C out of the server. The script will prompt you through the rest of the release process.

## Example Docker-Compose

```
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
      - ./server/saves:/opt/factorio/saves
      - ./server/mods:/opt/factorio/mods
```
