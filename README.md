# micro-launcher

Microservices launcher for .NET applications based on paket

[![wercker status](https://app.wercker.com/status/56ebdc3eee27ca9a1525ff478f6c7ac8/s/master "wercker status")](https://app.wercker.com/project/bykey/56ebdc3eee27ca9a1525ff478f6c7ac8)

## Getting started

1. Clone repository
2. Copy `paket.dependencies.sample` to `paket.dependencies`
3. Replace sample dependencies with your services in `paket.dependencies` file
4. Execute `run.sh`

## Documentation

micro-launcher is based on [paket] (https://github.com/fsprojects/Paket) - package dependency manager for .NET and mono and its intent is to stay as minimal and plaform agnostic as possible (support *nix and Windows)

### Arguments:
- --exclude or -e <service-name> to exclude service from running (example: ```./run.sh --exclude hello-world-fsharp```)
- --include or -i <service-name> to run specific services (example: ```./run.sh --include hello-world-nodejs```)
- --parallel or -p <threads> to launch services in parallel (example: ```./run.sh --parallel 10```)

### How it works

1. Restores packages
2. Iterates through packages and runs `run.sh`
3. `stop.sh` stops service matching a pattern

paket.dependencies file is ignored so that this repo can be cloned and updated without overriding your local dependencies file

### Making your service micro-launcher ready

Create `run.sh` script in root folder that is resposible for starting service. Here are few examples of starting an application:
```bash
start bin/*.exe # starting .net application from shell
```
```bash
start cmd //c run.bat
echo "Warm up application"
curl -vo nul http://localhost:8080/
# cat run.bat
# SET current_dir=%~dp0
# "C:\Program Files (x86)\IIS Express\iisexpress.exe" /path:"%current_dir:~0,-1%" /port:8080
```
```bash
powershell -ExecutionPolicy ByPass -File deploy.ps1
```
[hello-world] (https://github.com/uldissturms/hello-world) repo will contain various applications to demonstarate ways of starting a micro service

### Tests
Written using bats testing framework, to run them locally execute: ```bats run.bats```
To run tests in CI like enviroment download wercker-cli and execute: ```wercker build``` locally

## License

The [MIT license](LICENSE.txt)

## Maintainer(s)

- [@uldissturms](https://github.com/uldissturms)

## Contribute

Open a pull request
