pipeline {
    agent any

    environment {
        IMAGE_NAME = "gba6270-final"
        IMAGE_TAG  = "${env.BUILD_NUMBER}"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                sh """
                docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .
                docker tag ${IMAGE_NAME}:${IMAGE_TAG} ${IMAGE_NAME}:latest
                """
            }
        }

        stage('Terraform Init') {
            steps {
                dir('terraform') {
                    sh 'terraform init'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                dir('terraform') {
                    sh "terraform plan -var image_name=${IMAGE_NAME} -var image_tag=${IMAGE_TAG}"
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                dir('terraform') {
                    sh "terraform apply -auto-approve -var image_name=${IMAGE_NAME} -var image_tag=${IMAGE_TAG}"
                }
            }
        }
    }

    post {
        success {
            echo "Deployment complete! Visit your app at http://localhost:5000"
        }
        failure {
            echo "Build failed. Check logs."
        }
    }
}
