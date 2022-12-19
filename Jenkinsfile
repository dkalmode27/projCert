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
    stage('Install and configure puppet agent') {
      steps {
        sh 'ansible --version'
      }
    }
    
    stage('Remove old container') {
      agent { 
        label 'Jenkins-slave1' 
      }
      steps {
        sh 'docker rm php-application -f'
      }
    } 
    stage('Docker Build') {
      agent { 
        label 'Jenkins-slave1' 
      }
      steps {
        sh 'docker build -t dkalmode27/phpapp:$BUILD_NUMBER .'
      }
    }
    stage('Docker Login') {
      agent { 
        label 'Jenkins-slave1' 
      }
      steps {
        sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
      }
    }
    stage('Docker Run') {
      agent { 
        label 'Jenkins-slave1' 
      }
      steps {
        sh 'docker run -dt -p 8080:80 --name php-application dkalmode27/phpapp:$BUILD_NUMBER'
      }
    }
  }
  post {
    always {
      sh 'docker logout'
    }
  }
}
 
