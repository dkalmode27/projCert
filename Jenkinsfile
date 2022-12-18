pipeline {
  agent {
    label 'Jenkins-slave1'
    }
  environment {
    DOCKERHUB_CREDENTIALS = credentials('dockerhub-login')
  }
  stages {
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
        sh 'docker run -dt -p 8080:8080 dkalmode27/phpapp:$BUILD_NUMBER'
      }
    }
  }
  post {
    always {
      sh 'docker logout'
    }
  }
}
 
  
