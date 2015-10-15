# micro-launcher

Microservices launcher for .NET applications based on paket

## Getting started

1. Clone repository
2. Copy `paket.dependencies.sample` to `paket.dependencies`
3. Replace sample dependencies with your services in `paket.dependencies` file
4. Execute `run.sh`

## Documentation

micro-launcher is based on [paket] (https://github.com/fsprojects/Paket) - package dependency manager for .NET and mono and its intent is to stay as minimal and plaform agnostic as possible (support *nix and Windows)

Arguments:
1. --exclude <service-name> to exclude service from running (example: ```./run.sh --exclude hello-world```)

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

## License

The [MIT license](LICENSE.txt)

## Maintainer(s)

- [@uldissturms](https://github.com/uldissturms)

## Contribute

Open a pull request
