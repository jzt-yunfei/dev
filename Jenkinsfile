pipeline {
  agent {
    node {
      label 'jenkins_node'
    }

  }
  stages {
    stage('error') {
      steps {
        git(credentialsId: '	ab916899-95a0-4e2b-996d-5d570980f7cb', url: 'git@code.aliyun.com:douyaProject/douya-server.git', branch: 'master', poll: true)
      }
    }

  }
}