pipeline {
  agent any
  stages {
    stage('Build') {
      steps {
        sh 'docker build --rm -t sonarScanner .'
        pwd(tmp: true)
      }
    }
  }
}