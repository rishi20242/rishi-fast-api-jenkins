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
    }
}
