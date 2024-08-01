# gh-runner-docker
Gihthub action runner in docker

## build image first
Execute 
```bash
./build-docker-image.sh
```
## run a runner
Execute
```bash
GH_TOKEN=YOUR_TOKEN_HERE RUNNER_NAME=name_of_your_runner GH_REPO=your/repo ./run-container.sh
```
* **YOUR_TOKEN_HERE**: The token is obtained in settings page of your repo where you can add new self-hosted runner.
* **name_of_your_runner**: any suitable name you want for your runner
* **your/repo**: as the name suggests, your repo for which you want to setup self-hosted runner.
