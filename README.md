# gh-runner-docker
Gihthub action runner in docker.

**Note**: This is for ARM64 only for now. X64 runners are provided by GH anyway. ARM64 builds are done using qemu and thus are very slow. My OrangePi5+ is a beast in comparison. The build for [wg-ui-plus](https://github.com/vijaygill/wg-ui-plus) used to take more than 20 minutes in GH's own runner (using qemu) and my OrangePi5+ does that in less than 3 minutes!

## Build image first
```bash
./build-docker-image.sh


```

## Create network
```bash
docker network create dockernet

```

## Run a runner (or as many as you want)
```bash
GH_TOKEN=YOUR_TOKEN_HERE RUNNER_NAME=name_of_your_runner GH_REPO=your/repo ./run-container.sh

```

* **YOUR_TOKEN_HERE**: The token is obtained in settings page of your repo where you can add new self-hosted runner.
* **name_of_your_runner**: any suitable name you want for your runner
* **your/repo**: as the name suggests, your repo for which you want to setup self-hosted runner.

* The container name will be **gh-runner-name_of_your_runner**.
