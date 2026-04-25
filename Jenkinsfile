pipeline {
    agent any

    // 👇 Auto trigger when code is pushed to GitHub
    triggers {
        githubPush()
    }

    environment {
        BRANCH = "feature-apr-ep-01-task-002"
    }

    stages {

        stage('Clean Workspace') {
            steps {
                echo "Cleaning workspace..."
                deleteDir()
            }
        }

        stage('Checkout Code') {
            steps {
                echo "Cloning Spring PetClinic from GitHub..."
                git branch: "${BRANCH}",
                    url: 'https://github.com/vhazarathnaidu/git-branching-stratey.git'
            }
        }

        stage('Build') {
            steps {
                echo "Building application using Maven Wrapper..."
                sh '''
                chmod +x mvnw
                ./mvnw clean install -DskipTests
                '''
            }
        }

        stage('Run') {
            steps {
                echo "Starting application..."
                sh '''
                pkill -f 'java -jar' || true
                nohup java -jar target/*.jar > app.log 2>&1 &
                '''
            }
        }
    }

    post {
        success {
            echo "======================================"
            echo "✅ SUCCESS: Build & Deployment Completed!"
            echo "Application running on port 8080"
            echo "======================================"
        }
        failure {
            echo "======================================"
            echo "❌ ERROR: Build Failed!"
            echo "Check console logs for details"
            echo "======================================"
        }
        always {
            echo "Pipeline execution finished."
        }
    }
}