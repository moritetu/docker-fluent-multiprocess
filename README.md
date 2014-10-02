# docker-fluent-multiprocess #

Docker image that will install td-agent from rpm and start a td-agent service with the fluent-plugin-multiprocess.

In this docker image two fluentd processes will start, each process uses 24224 and 24225 port.

It will always run on the latest package. If you want to change this default setting, please change commands to install packages inside Dockerfile.

## Build container and start it

```
$ docker build -t fluent-multiprocess .
$ docker run -i -t -p 24224:24224 -p 24225:24225 fluent-multiprocess
```

## Test

Test from your local machine.

```
$ VBoxManage controlvm "boot2docker-vm" natpf1 "fluentd1,tcp,127.0.0.1,24224,,24224"
$ VBoxManage controlvm "boot2docker-vm" natpf1 "fluentd2,tcp,127.0.0.1,24225,,24225"
```

Send to port 24224 with tag "debug".
```
$ echo '{"key":"24224"}'|  fluent-cat -p 24224 debug
```

Send to port 24225 with tag "debug".
```
$ echo '{"key":"24225"}'|  fluent-cat -p 24225 debug
```








