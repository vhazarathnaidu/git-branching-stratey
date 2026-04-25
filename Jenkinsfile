pipeline {
    agent any

    // 👇 Poll SCM instead of webhook
    triggers {
        pollSCM('H/5 * * * *')   // check every 5 minutes
    }

    options {
        quietPeriod(60)               // wait 60 sec before build
        disableConcurrentBuilds()     // no parallel builds
        buildDiscarder(logRotator(numToKeepStr: '5'))
    }

    stages {

        stage('Clean Workspace') {
            steps {
                deleteDir()
            }
        }

        stage('Checkout Code') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/spring-projects/spring-petclinic.git'
            }
        }

        stage('Build') {
            steps {
                script {
                    try {
                        sh '''
                        chmod +x mvnw
                        ./mvnw clean install -DskipTests
                        '''
                    } catch (err) {
                        echo "❌ ERROR LINE:"
                        echo err.getMessage()
                        error("Build failed")   // stop pipeline
                    }
                }
            }
        }

        stage('Run') {
            steps {
                sh '''
                pkill -f 'java -jar' || true
                nohup java -jar target/*.jar > app.log 2>&1 &
                '''
            }
        }
    }

    post {
        success {
            echo "✅ SUCCESS: Build Completed & App Running"
        }
        failure {
            echo "❌ FAILED: Check above error line only"
        }
    }
}