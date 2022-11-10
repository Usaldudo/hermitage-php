# Hermitage

from <https://github.com/LiveTyping/hermitage-skeleton>

podman build

```shell
podman-compose build
```

run as yaml pod

```shell
podman play kube hermitage.yaml
```

ready image on Dockerhub

```shell
podman pull docker.io/nanemo/hermitage-php:1.0.0
podman pull docker.io/nanemo/hermitage-nginx:1.0.0
```

## Python test

### Instruction

Change secret, method, filename.

run

```shell
./signature.py
```

output

```bash
1668081733
http://localhost:8080
b'POST|http://localhost:8080|1668081733'
1668081733 3fffa705ea7510c09ab85783912cb25725f0f755dbdb59e66d6ad2401460f095
{'filename': 'JWl/10/29/636ce845976d2/76d9.jpg'}
```
