# simple script to run containerized jekins with other tools (grafana, influxdb) 

docker run -d --name grafana1 -p 3000:3000 grafana/grafana
docker run -d --name influxdb1 -p 8086:8086 influxdb
docker run -u root --rm -d -p 8080:8080  -p 50000:50000  -v jenkins-data:/var/jenkins_home  -v /var/run/docker.sock:/var/run/docker.sock  jenkinsci/blueocean
