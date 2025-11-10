pipeline {
    agent any

    options {
        timeout(time: 30, unit: 'MINUTES')
    }

    triggers {
        pollSCM('* * * * *') // Example: poll every minute
    }

    stages {
        stage('git') {
            steps {
                checkout([$class: 'GitSCM',
                          branches: [[name: '*/feature-ep-005-task-004']],
                          userRemoteConfigs: [[url: 'https://github.com/vhazarathnaidu/git-branching-stratey.git']]])
            }
        }

        stage('Build') {
            steps {
                dir 'mvn clean package'
				archiveArtifacts artifacts: '**/git-branching-stratey*.jar'
				junit testResults: '**/TEST-*.xml'
            }
        }
    }
}
