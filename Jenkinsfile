pipeline {
    agent any
    environment {     
        DOCKERHUB_CREDENTIALS = credentials('dockerhubcredentials')
    } 

    tools {
        // Install the Maven version configured as "M3" and add it to the path.
        maven "maven-install"
    }
    stages{
        stage("Build Maven") {
            steps{
                checkout scmGit(branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/trantrongdai/welcome.git']])
                bat 'mvn clean install'
            }
        }
        stage('Build docker image') {
            steps {
                script{
                    bat 'docker build -t trantrongdai/welcome .'
                }
            }
        }
        stage('Login to Docker Hub') {         
            steps{
                bat 'docker login -u trantrongdai -p Khimnana306'        
            	echo 'Login Completed'                
             }           
        } 
        stage('Push image to hub'){
            steps {
                script{
                    bat 'docker push trantrongdai/welcome'
                }
            }
        }
    }
    post {
        always {
          bat 'docker logout'
        }
  }
}
