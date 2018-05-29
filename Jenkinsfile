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
        docker.withRegistry('https://registry.cn-shanghai.aliyuncs.com', 'docker-registry') {  
          docker.build('registry.cn-shanghai.aliyuncs.com/dengqingpei/test:v2').push()  
        }  
      }
    }
  }
}
