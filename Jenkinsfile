pipeline {
    agent any
    environment {
        DOCKER_CREDS = credentials('docker-hub-credentials')
        DOCKER_IMAGE = 'praveenkumarilla459/my-python-app'
    }
    stages {
        stage('Build & Push') {
            steps {
                script {
                    dir('Ops-Code-Repo') {
                        sh "docker build -t ${DOCKER_IMAGE}:${BUILD_NUMBER} ."
                        sh "echo $DOCKER_CREDS_PSW | docker login -u $DOCKER_CREDS_USR --password-stdin"
                        sh "docker push ${DOCKER_IMAGE}:${BUILD_NUMBER}"
                    }
                }
            }
        }
        stage('Deploy') {
            steps {
                script {
                    dir('Ops-Code-Repo') {
                        // Deploy the specific build number using Ansible
                        sh "ansible-playbook deploy.yml --extra-vars 'build_id=${BUILD_NUMBER}'"
                    }
                }
            }
        }
    }
}