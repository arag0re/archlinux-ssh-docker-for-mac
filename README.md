# arch-linux-ssh docker container for macOS

creates an arch-linux Docker container that u can run on a mac

## build docker image from Dockerfile -> you have to be in the directory with the Dockerfile 
```
docker build -t archlinux:sshd .
```

## run docker image privileged with systemd from macOS
```
docker run -d -p 2222:22 --privileged -v /sys/fs/cgroup:/sys/fs/cgroup:ro archlinux:sshd
```

## start sshd & libvirtd service in container 
```
docker exec -it 'contaiber_name' /bin/bash
systemctl enable sshd.service
systemctl start sshd.service
systemctl enable libvirtd.service
systemctl start libvirtd.service
```

## How to connect per ssh 
```
ssh localhost -p 2222 -l root 
```
example output: 
```
[~]> ssh localhost -p 2222 -l root 

The authenticity of host '[localhost]:2222 ([::1]:2222)' can't be established.
ECDSA key fingerprint is 82:47:98:3a:2c:e2:d7:6f:9d:22:ba:ab:a9:0f:c8:d2.
Are you sure you want to continue connecting (yes/no)? yes

Warning: Permanently added '[localhost]:2222' (ECDSA) to the list of known hosts.

root@localhost's password: 
```
