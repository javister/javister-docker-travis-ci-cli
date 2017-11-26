# Docker образ с клиентом Travis CI

[ ![Download](https://api.bintray.com/packages/javister/docker/javister%3Ajavister-docker-travis-ci-cli/images/download.svg) ](https://bintray.com/javister/docker/javister%3Ajavister-docker-travis-ci-cli/_latestVersion)

## Введение

Данный образ предназначен для работы с сервисом [Travis CI](https://travis-ci.org/). Его можно использовать в 
тех случаях, когда нет желания или возможности для установки этой утилиты на рабочую систему. 

## Использование

Для того, чтобы запустить утилиту `travis`, можно восспользоваться
следующей командой:

```bash
docker run \
    -ti \
    --rm \
    -v "$(pwd)":"$(pwd)" \
    -v "$HOME":"$HOME" \
    -e HOME="$HOME" \
    -e PUID=$(id -u) \
    -e PGID=$(id -g) \
    -e http_proxy="${http_proxy}" \
    -e no_proxy="${no_proxy}" \
    --workdir="$(pwd)" \
    javister-docker-docker.bintray.io/javister/javister-docker-travis-ci-cli:1.0 <command>
```
Если имеется регулярная необходимость в использовании данной утилиты, то можно задать алиас в
`~/.bashrc`:

```bash
travis_func() {
    docker run \
        -ti \
        --rm \
        -v "$(pwd)":"$(pwd)" \
        -v "$HOME":"$HOME" \
        -e HOME="$HOME" \
        -e PUID=$(id -u) \
        -e PGID=$(id -g) \
        -e http_proxy="${http_proxy}" \
        -e no_proxy="${no_proxy}" \
        -e LOG_LEVEL="WARNING" \
        --workdir="$(pwd)" \
        javister-docker-docker.bintray.io/javister/javister-docker-travis-ci-cli:1.0 \
        $@
}
alias travis=travis_func
``` 
