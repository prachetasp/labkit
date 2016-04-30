# EPX Labs Labkit

The labkit is Clojure tooling within a container. Inspired (and adapted) by https://github.com/markmandel/wrapping-clojure-tooling-in-containers.

This repo will start up a Docker container for Clojure development. It contains:

* CentOS 7
* Oracle Java 8
* Emacs 24.5-1.el7
* Git
* xpra for simple screen management
* zsh
* oh-my-zsh
* Leiningen

To run this container you must execute a few commands from the root of the repo.

```shell
git submodule init --recursive
git submodule update --recursive
./run_docker.sh [NAME OF IMAGE] [NAME OF CONTAINER]
docker exec -it [NAME OF CONTAINER] /usr/bin/zsh
```
