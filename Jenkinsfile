pipeline {
    agent any

    stages {
        stage('Setup Environment') {
            steps {
                sh '''#!/bin/bash
                    python3 -m venv venv
                    ./venv/bin/python -m pip install --upgrade pip
                    ./venv/bin/python -m pip install -r requirements.txt
                '''
            }
        }

        stage('Test') {
            steps {
                // By using ./venv/bin/python we remove reliance on complex variable expansion
                sh './venv/bin/python -m pytest'
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
                    // Create a directory to store the image file
                    sh 'mkdir -p docker-images'
                    
                    // Save the image to a .tar file inside the folder
                    sh 'docker save -o docker-images/api_image.tar jenkins_api_build'
                    
                    // Optional: Archive the tar file so it's available in the Jenkins UI
                    archiveArtifacts artifacts: 'docker-images/api_image.tar', allowEmptyArchive: false
                }
            }
        }
    }
}
