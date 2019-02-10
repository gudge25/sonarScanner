pipeline {
  agent any
  stages {
    stage('Build') {
      steps {
        sh 'docker build --rm -t sonarscanner .'
        pwd(tmp: true)
      }
    }
  }
}