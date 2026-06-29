pipeline {
    agent any

    stages {
        stage('Test Application') {
            agent {
                docker { 
                    image 'python:3.10-slim' 
                }
            }
            steps {
                sh '''
                    pip install --upgrade pip
                    pip install -r requirements.txt
                    pytest
                '''
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t jenkins_api_build .'
            }
        }

        stage('Archive Docker Image') {
            steps {
                script {
                    sh 'mkdir -p docker-images'
                    sh 'docker save -o docker-images/api_image.tar jenkins_api_build'
                    archiveArtifacts artifacts: 'docker-images/api_image.tar', allowEmptyArchive: false
                }
            }
        }
    }
}
