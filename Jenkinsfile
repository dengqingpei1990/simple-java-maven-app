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
        // sh 'docker login -u 18580500107 -p dqp0914122 registry.cn-shanghai.aliyuncs.com'
        // sh 'docker push registry.cn-shanghai.aliyuncs.com/dengqingpei/test:v1
        withDockerRegistry(credentialsId: 'docker-registry', url: 'https://registry.cn-shanghai.aliyuncs.com') {
          script {
            def customImage = docker.build("registry.cn-shanghai.aliyuncs.com/dengqingpei/test:v1")
            customImage.push()
          }
        }
      }
    }
    stage('deploy') {
      agent any
      steps {
        kubernetesDeploy configs: 'k8s/*.yaml', dockerCredentials: [[credentialsId: 'docker-registry', url: 'https://registry.cn-shanghai.aliyuncs.com']], kubeConfig: [path: ''], kubeconfigId: 'kubeconfig', secretName: 'aliyun', ssh: [sshCredentialsId: '*', sshServer: ''], textCredentials: [certificateAuthorityData: '', clientCertificateData: '', clientKeyData: '', serverUrl: 'https://']

      }
    }
  }
}
