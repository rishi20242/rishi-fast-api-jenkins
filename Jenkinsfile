pipeline {
    agent any

    environment {
        // Define common variables
        VENV_PATH = "${WORKSPACE}/venv"
        PYTHON = "${VENV_PATH}/bin/python"
    }

    stages {
        stage('Setup Environment') {
            steps {
                sh "ls"
                sh '''
                    python3 -m venv venv
                    ${PYTHON} -m pip install --upgrade pip
                    ${PYTHON} -m pip install -r requirements.txt
                '''
            }
        }

        stage('Test') {
            steps {
                // Run tests using the venv python
                sh '${PYTHON} -m pytest'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build the docker image
                    docker.build("jenkins_api_build")
                }
            }
        }
    }

    post {
        always {
            // Clean up: stop the uvicorn process if it's still running
            // or perform other cleanup tasks
            sh 'pkill -f "uvicorn main:app" || true'
        }
    }
}
