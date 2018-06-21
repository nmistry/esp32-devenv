# esp32-devenv

An opinionated docker based development environment for the esp32.

## Build

```
docker build -t esp32-devenv .
```

## Run

```
docker run --name esp32-devenv -it esp32-devenv /bin/bash
```

## Directories

- /src - Mounted location of source files
- /esp - location of esp toolchain