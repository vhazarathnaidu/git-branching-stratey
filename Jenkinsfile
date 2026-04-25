pipeline {
    agent any

    stages {
        stage('Clone') {
            steps {
                git 'https://github.com/vhazarathnaidu/spring-petclinic.git'
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean install'
            }
        }

        stage('Run') {
            steps {
                sh 'nohup java -jar target/*.jar &'
            }
        }
    }
}