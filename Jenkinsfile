def AGENT_LABEL_MASTER = "Built-In-Node"
def AGENT_LABEL_SLAVE = "Jenkins-slave1"

pipeline {
  agent {
    label "${AGENT_LABEL_MASTER}"
    }
  
  environment {
    DOCKERHUB_CREDENTIALS = credentials('dockerhub-login')
  }
  
  stages {
    
    stage('Install and configure puppet agent on test server') {
      steps {
        ansiblePlaybook colorized: true, credentialsId: 'ansible-auth', disableHostKeyChecking: true, playbook: 'Config-puppet-agent.yml'
      }
    }
    
    stage('Install docker on test server') {
      steps {
        ansiblePlaybook colorized: true, credentialsId: 'ansible-auth', disableHostKeyChecking: true, playbook: 'install-docker.yml'
      }
    }
    
    stage('Build new docker image with PHP website changes') {
      agent { 
        label 'Jenkins-slave1' 
      }
      steps {
        sh 'docker build -t dkalmode27/phpapp:$BUILD_NUMBER .'
      }
    }
    
    stage('Login to docker hub to pull base PHP image') {
      agent { 
        label 'Jenkins-slave1' 
      }
      steps {
        sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
      }
    }
    
    stage('Stop previous version application container') {
      agent { 
        label 'Jenkins-slave1' 
      }
      steps {
        sh 'docker stop php-application'
      }
    } 
    
    stage('Run new docker container using updated application image') {
      agent { 
        label 'Jenkins-slave1' 
      }
      steps {
        sh 'docker run -dt -p 8080:80 --name php-application dkalmode27/phpapp:$BUILD_NUMBER'
      }
    }
  }
  
  post {
    
    FAILURE {
     sh 'docker rm php-application -f'
      }
    
    always {
      sh 'docker logout'
    }
  }
}
 
