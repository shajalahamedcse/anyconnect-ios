
pipeline {
  agent any

  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    // stage('Dependecies') {
    //   steps {
    //     sh '/usr/local/bin/pod install'
    //   }
    // }

    stage('Running Tests') {
      steps {
        sh 'whomai'
        sh 'bundle install'
        sh 'echo "Unit Tests"'
        sh 'bundler exec fastlane test'
        
      }
    }

    stage('Documentation') {
      when {
        expression {
          env.BRANCH_NAME == 'develop'
        }
      }
      steps {
        // Generating docs
        sh 'jazzy'
        // Removing current version from web server
        sh 'rm -rf /path/to/doc/ios'
        // Copy new docs to web server
        sh 'cp -a docs/source/. /path/to/doc/ios'
      }
    }
  }

  post {
    always {
      // Processing test results
      junit 'fastlane/test_output/report.junit'
      // Cleanup
      sh 'rm -rf build'
    }

  }
}

