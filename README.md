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

## Pipelines with groovy. 


Simple example program 

#!/usr/bin/env groovy

import com.cloudbees.groovy.cps.NonCPS
import groovy.transform.Field

// Initial string definitions

@Field final String ACTION_INIT = 'init' // terraform init
@Field final String ACTION_TEST = 'test' // terraform test
@Field final String ACTION_PLAN = 'plan' // terraform plan
@Field final String ACTION_APPLY = 'apply' // terraform apply
@Field final String ACTION_DESTROY = 'destroy' // terraform destroy
@Field final String ACTION_STACK_INFO = 'stackinfo' // stackdriver info
@Field final String ACTION_STACK_BACK = 'stackback' // stackdrover backup policies
@Field final String ACTION_STACK_RESTORE = 'stackrestore' // stackdrover restore policies

@Field final String TERRAFORM_IMAGE = 'yyyyyy' // location of docker image
@Field final String TERRAFORM_IMAGE_PYTHON = 'xxxxx' // location of docker image
@Field final String TERRAFORM_CREDENTIALS_ID = 'xxxx'
@Field final String TERRAFORM_WORKING_DIR = '/app'
@Field final String TERRAFORM_CREDENTIALS_PATH = "${TERRAFORM_WORKING_DIR}/examplecredential.json"


echo("Init.............")


@NonCPS

def Set() {

    echo("Extracting changes.............")
    Set stackdriversinfo = []
    def changeLogSets = currentBuild.changeSets


    for (int i = 0; i < changeLogSets.size(); i++) {
        def entries = changeLogSets[i].items

        for (int j = 0; j < entries.length; j++) {

            def entry = entries[j]
            def files = new ArrayList(entry.affectedFiles)
            for (int k = 0; k < files.size(); k++) {

                def file = files[k]
                def path = file.path

                if (path.endsWith("info.sh")) {
                    echo("Detected changed file [${path}]")
                    stackdriversinfo.add(path)
                    //println(stackdriversinfo)


                }

            }

        }


    }

    return stackdriversinfo
}

// call Set function here. 
```

