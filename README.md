
# Introduction 

Dockerfile to build a nifi container image

## Version

Current version: 0.0.1-SNAPSHOT - built from apache nifi commit 4d998c12c95a6e5ce3d66c0d861e75e33b5cf013

# Quick Start

### Warning 

This will open listening ports - ensure that your host OS has protections in place such that the port is only open to machines you know about, e.g. with a firewall like iptables (I recommend that you configure your firewall to only allow localhost access to ports 8080 and 8081 for test purposes))

You can launch the image using the docker command line

```bash
docker run -d --name=nifi \
-p 8080:8080 -p 8081:8081 \
-v /tmp/output:/output \
tkurc/nifi
```

You can view the startup progress using docker logs command

```bash
docker logs -f nifi
```

The application is started when you see a line similar to the one below:

```
2014-11-24 00:42:03,540 INFO [main] org.apache.nifi.web.server.JettyServer NiFi has started. The UI is available at the following URLs:
```

Point your browser to `http://localhost:8080/nifi`

The port 8081 is exposed, not for the application but for sampling the use of processors that will listen on ports (such as ListenHTTP). 
Likewise the `-v /tmp/output:/output' mounts the /tmp/output directory in the host to the data volume /output in the container, to 
sample the use of processors which can write to the local filesystem (PutFile). 
