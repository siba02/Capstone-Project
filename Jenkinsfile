pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build') {
            steps {
                echo "Building Java Project"
                bat 'javac *.java'
            }
        }

        stage('Run') {
            steps {
                echo "Running Java Program"
                bat 'java Main'
            }
        }
    }

    post {
        success {
            echo "Build Successful"
        }
        failure {
            echo "Build Failed"
        }
    }
}