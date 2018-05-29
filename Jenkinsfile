pipeline {
  agent none
  stages {
    stage('build') {
      agent {
        docker {
          image 'maven:3-alpine'
          args '-v /root/.m2:/root/.m2'
        }
      }
      steps {
        sh 'mvn -B -DskipTests clean package'
      }
    }
    stage('test') {
      agent {
        docker {
          image 'maven:3-alpine'
          args '-v /root/.m2:/root/.m2'
        }
      }
      steps {
        sh 'mvn test'
      }
    }
    stage('build-image') {
      agent any
      steps {
        sh 'docker build -t registry.cn-shanghai.aliyuncs.com/dengqingpei/test:v1 .'
        sh 'docker push registry.cn-shanghai.aliyuncs.com/dengqingpei/test:v1'
      }
    }
  }
}
