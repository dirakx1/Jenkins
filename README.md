# Jenkins

* Install Jenkins via docker (https://jenkins.io/doc/book/installing/ run via jenkins.sh locally) or also installing on GCP. (https://console.cloud.google.com/marketplace/details/bitnami-launchpad/jenkins)
Estimated costs: $14.20/month

+ Install jenkings plugin "google kubernetes engine"
* Install kubectl inside docker container that has jenkins inside.
```
# Set the Kubernetes version as found in the UCP Dashboard or API

k8sversion=v1.11.5

# Get the kubectl binary.
curl -LO https://storage.googleapis.com/kubernetes-release/release/$k8sversion/bin/linux/amd64/kubectl

# Make the kubectl binary executable.
chmod +x ./kubectl

# Move the kubectl executable to /usr/local/bin.
sudo mv ./kubectl /usr/local/bin/kubectl
OR
mv ./kubectl /usr/local/bin/kubectl
```


# POC (Local installation) ## 

* Install Jenkins via docker (https://jenkins.io/doc/book/installing/ run via jenkins.sh locally) or also installing on GCP. (https://console.cloud.google.com/marketplace/details/bitnami-launchpad/jenkins)
Estimated costs: $14.20/month

+ Install jenkings plugin "google kubernetes engine"
* Install kubectl inside docker container that has jenkins inside.
```
# Set the Kubernetes version as found in the UCP Dashboard or API
k8sversion=v1.11.5

# Get the kubectl binary.
curl -LO https://storage.googleapis.com/kubernetes-release/release/$k8sversion/bin/linux/amd64/kubectl

# Make the kubectl binary executable.
chmod +x ./kubectl

# Move the kubectl executable to /usr/local/bin.
sudo mv ./kubectl /usr/local/bin/kubectl
OR
mv ./kubectl /usr/local/bin/kubectl
```

* Create google credentials as a secret text. 
* install gcloud inside docker. (https://cloud.google.com/sdk/docs/downloads-versioned-archives or https://cloud.google.com/sdk/docs/downloads-interactive) take into account taht jenkins uses an alpine image.

```
docker run -d --name grafana -p 3000:3000 grafana/grafana
docker run -d --name influxdb -p 8086:8086 influxdb
```

* Access the container (if installed locally): 
```
docker run -u root --rm -d -p 8080:8080  -p 50000:50000  -v jenkins-data:/var/jenkins_home  -v /var/run/docker.sock:/var/run/docker.sock  jenkinsci/blueocean
sudo docker exec -it name-of-container /bin/bash (Jenkins version installed : 2.164.2)
```

* Create grafana database run: CREATE DATABASE grafana

 ```docker run --rm --link=influxdb -it influxdb influx -host influxdb``` OR
 ```curl -i -XPOST http://localhost:8086/query --data-urlencode "q=CREATE DATABASE mydb"```

* Configure influxdb: set an user of the database with password 
```curl -G http://localhost:8086/query -u todd:influxdb4ever --data-urlencode "q=SHOW DATABASES"```
or access the DB via docker and configure users following:
 ```
* https://docs.influxdata.com/influxdb/v1.7/administration/authentication_and_authorization/
* https://hub.docker.com/_/influxdb/
```

* Create a datasource of influxdb type on grafana (localhost:3000)(http access via browser)

* Connect github (could be github enterprise) repo with jenkins installed (using blue ocean plugin) 
* Install other needed plugins: junit, influxdb, jacoco, git and pipeline.
* Configure the influxdb target on jenkins overall configuration (use global listener)
* Test a hello world job on shell executor and see if data is being stored by influxdb (using localhost influxdb url)
* Construct the pipelines (backend-frontend) needed to run.(see [pipelines](/pipelines/README.md))


## Hints for jenkins usage
* Durability/Scallability of pipelines
* Parallel usage
* preserveStashes for use if a "restar stage" option is used
* Use groovySandbox, ScriptSecurity plugin foir security
* Use Secrets for passwords etc.
* Keep it simple, try to use more declarative than scripted. 
* Use comand line tools instead of groovy tools for XML and JSON parsing
* Try to use external scripts and tools insted of groovy
* Reduce number of steps in pipeline
* Try to use Configuration as a code plugins. 










