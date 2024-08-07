[![CI](https://github.com/lpenz/grafanatheus/workflows/CI/badge.svg)](https://github.com/lpenz/grafanatheus/actions)
[![docker](https://img.shields.io/docker/v/lpenz/grafanatheus?label=release&logo=docker&sort=semver)](https://hub.docker.com/repository/docker/lpenz/grafanatheus)

# grafanatheus

Create a single read-only docker image with grafana, prometheus and
some exporters in the spirit of [fleet.linuxserver.io].

Part of the idea is to have a single container that is able to monitor
and graph the local machine with mihnimal setup, and to be able to
explore and test parameters before a wider deployment.


[fleet.linuxserver.io]: https://fleet.linuxserver.io/
