pipeline {
  agent {
    label 'Jenkins-slave1'
    }
  environment {
    DOCKERHUB_CREDENTIALS = credentials('dockerhub-login')
  }
  stages {
    
    stage('Remove old container') {
      steps {
        sh 'docker rm php-application -f'
      }
    } 
    stage('Docker Build') {
      steps {
        sh 'docker build -t dkalmode27/phpapp:$BUILD_NUMBER .'
      }
    }
    stage('Docker Login') {
      steps {
        sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
      }
    }
    stage('Docker Run') {
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
 
