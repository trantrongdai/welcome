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
                sh 'mvn clean install'
            }
        }
        stage('Build docker image') {
            steps {
                script{
                    sh 'docker build -t trantrongdai/welcome .'
                }
            }
        }
        stage('Login to Docker Hub') {         
            steps{
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
            	echo 'Login Completed'                
             }           
        } 
        stage('Push image to hub'){
            steps {
                script{
                    sh 'docker push trantrongdai/welcome'
                }
            }
        }
        stage ('Deploy') {
            steps{
                sshagent(credentials : ['app-ssh']) {
                    sh 'ssh -o StrictHostKeyChecking=no trongdaibk300692@34.142.239.77 uptime'
                    sh 'ssh -v trongdaibk300692@35.198.251.210'
                    sh 'pull.sh'
                }
            }
        }
    }
    post {
        always {
          sh 'docker logout'
        }
  }
}
