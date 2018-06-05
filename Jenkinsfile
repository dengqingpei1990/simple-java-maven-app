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
        withDockerRegistry(credentialsId: 'docker-registry', url: 'https://registry.cn-shanghai.aliyuncs.com') {
          script {
            def customImage = docker.build("registry.cn-shanghai.aliyuncs.com/dengqingpei/test:v5")
            customImage.push()
          }
        }
      }
    }
    stage('deploy') {
      agent any
      steps {
        //kubernetesDeploy configs: 'k8s/*.yaml', dockerCredentials: [[credentialsId: 'docker-registry', url: 'https://registry.cn-shanghai.aliyuncs.com']], kubeConfig: [path: ''], kubeconfigId: 'kubeconfig', secretName: 'aliyun', ssh: [sshCredentialsId: '*', sshServer: ''], textCredentials: [certificateAuthorityData: '', clientCertificateData: '', clientKeyData: '', serverUrl: 'https://']
        withKubeConfig(caCertificate: '', credentialsId: '84cb9f5d-046c-431b-82a1-56fdc9a64e4b', serverUrl: 'https://192.168.1.200:6443') {
          sh 'kubectl version'
        }
      }
    }
  }
}
