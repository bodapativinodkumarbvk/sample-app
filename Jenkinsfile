pipeline {
  agent any
  stages {
    stage ("stage1"){
      steps {
        echo "Hello world!"
        sh 'ls -l'
      }
    }
    stage ('stage2'){
      steps {
        echo "check if get checkout is executed again"
      }
    }
  }
}
