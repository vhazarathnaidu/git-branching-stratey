pipeline {
    agent { label 'MAVEN' }

    options {
        timeout(time: 30, unit: 'MINUTES')
    }

    triggers {
        pollSCM('* * * * *') // Example: poll every minute
    }

    stages {
        stage('git') {
            steps {
                stage('Checkout') {
                         git branch: 'feature-ep-005-task-004',
                    url: 'https://github.com/vhazarathnaidu/git-branching-stratey.git'
				}
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean package'
				archiveArtifacts artifacts: '**/git-branching-stratey*.jar'
				junit testResults: '**/TEST-*.xml'
            }
        }
    }
}
