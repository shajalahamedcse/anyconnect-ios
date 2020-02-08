
pipeline {
  agent any

  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Running Tests') {
      steps {
        sh 'fastlane test'
      }
    }

    stage('Build') {
      steps {
        sh 'fastlane gym'
        
      }
    }
  }


}

