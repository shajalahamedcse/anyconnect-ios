
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
        sh 'whoami'
        sh 'echo "Unit Tests"'
        sh 'gem install xcpretty'
        sh 'sudo -S <<< "sha01688" fastlane test'
        sh '/usr/local/bin/fastlane test'
        //sh 'bundler exec fastlane test'
        
      }
    }

    stage('Build') {
      steps {
        sh 'whoami'
        sh 'echo "Unit Tests"'
        sh '/usr/local/bin/fastlane test'
        //sh 'bundler exec fastlane test'
        
      }
    }
  }


}

