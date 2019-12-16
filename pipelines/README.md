# Pipelines

Different examples of pipelines in Jenkins

## Pipelines with groovy. 


Simple example program 
```
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
