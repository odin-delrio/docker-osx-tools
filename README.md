# Docker OSX tools

Tired of manual insert/update of the /etc/hosts file, I created a simple script to automate that task ;)

## Usage (sudo needed to manipulate the /etc/hosts file):
```bash
sudo ./put-dm-hosts
```

## Generated host names
With the name of each docker machine a host is created with the machine name as SLD and *.dm* as TLD.
Default docker machine host:
> http://default.dm

### References
- https://gist.github.com/nddrylliog/1368532
- https://docs.docker.com/machine/reference/ls/
- http://cavaliercoder.com/blog/update-etc-hosts-for-docker-machine.html
