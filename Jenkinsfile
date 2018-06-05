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
        withKubeConfig(caCertificate: 'LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUN5RENDQWJDZ0F3SUJBZ0lCQURBTkJna3Foa2lHOXcwQkFRc0ZBREFWTVJNd0VRWURWUVFERXdwcmRXSmwKY201bGRHVnpNQjRYRFRFNE1EVXhPREV4TkRFeU1sb1hEVEk0TURVeE5URXhOREV5TWxvd0ZURVRNQkVHQTFVRQpBeE1LYTNWaVpYSnVaWFJsY3pDQ0FTSXdEUVlKS29aSWh2Y05BUUVCQlFBRGdnRVBBRENDQVFvQ2dnRUJBTWMrClN4b3NtMjM2bm94dlMxOHNDajcybnk5ZnlGRG9YUGFtaE5JSFBBRGk4V0NUSys5WTl0SlE1aTlQRmprclBJbDkKRy9lZ1ZsTVBrbFk3OENPUy9uOHZweUVGMExVSEFuUi9tUlpNWGVpeTdnRzJXZUt5Q2RHWUIxYUN1L0hLTTN4Ywp0eDZHRGtXSXNERVcrak1rclVXU2JTT3lKNUl4N2ovVUY1K2Z4eVNvMjcvTFJGV0RPeEtyL1dNNER5ZzZlSmxECkVBeDZwYTJzNHhjeUIyd2lwSGdNYzU3SzRJa3FxNmtvYWhCZ3A5aDZiellZR01KVWhaeEl6TTlRazNKcHdSNWsKMzZrNlZmQTNRbXNHb0FBUmxDSUZhMWNaVUd5UllDSktpSExZZDdKb1RCWGlkRy9BU25PNksyQlNOdGdqYnhleQp6M3BDZ2YyTDFxUWo3dXh3UDJzQ0F3RUFBYU1qTUNFd0RnWURWUjBQQVFIL0JBUURBZ0trTUE4R0ExVWRFd0VCCi93UUZNQU1CQWY4d0RRWUpLb1pJaHZjTkFRRUxCUUFEZ2dFQkFEdkE5VVA4emJ0NE5hWCs1V1pGQ0w4WUdtT3YKTDV3N3hYWU1PNUU3cVJwTHozSit0b3c0Rmo0ZnhMOWEwWVc1VDBGRkFKWDVGeWZZTXBjTUVVTHZqaEJvTXVKLwpVcWFVanhTWklrWEx6bjdmZkYyWG9MYkkxWVR2OFZkalJVc1hrdW53dFNCNWJxdDNBbFMvK2p4K3NLL3FuSitmCnBoQ251QnZISEhvRDRCbjh1WFlPc2JXRXJZNlNMV09PZWpyeUlmRTlueVZRcUdLZ2hCb252TGhEMXg0ZDNFSE8KUVRJTGtmRXJ5ZVU2WVRyTzFuUGh5eEN5V1lUNmcvRVY3NjZpYmdlejM1UmFTS2w0Y0tiNVJiU1VlK2Y5alZVOQpPSGZyajNRYVlTSUFseEMzbXZRaTdobVpydXN4czhQaE9NMGkrV2Jvc0RwSndjQm0xZjJZU011b3c3VT0KLS0tLS1FTkQgQ0VSVElGSUNBVEUtLS0tLQo=', credentialsId: '84cb9f5d-046c-431b-82a1-56fdc9a64e4b', serverUrl: 'https://192.168.1.200:6443') {
          sh 'kubectl version'
        }
      }
    }
  }
}
