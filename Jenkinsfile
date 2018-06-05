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
      environmen {
        
      }
      steps {
        //kubernetesDeploy configs: 'k8s/*.yaml', dockerCredentials: [[credentialsId: 'docker-registry', url: 'https://registry.cn-shanghai.aliyuncs.com']], kubeConfig: [path: ''], kubeconfigId: 'kubeconfig', secretName: 'aliyun', ssh: [sshCredentialsId: '*', sshServer: ''], textCredentials: [certificateAuthorityData: '', clientCertificateData: '', clientKeyData: '', serverUrl: 'https://']
        withKubeConfig(caCertificate: '''-----BEGIN CERTIFICATE-----
MIICyDCCAbCgAwIBAgIBADANBgkqhkiG9w0BAQsFADAVMRMwEQYDVQQDEwprdWJl
cm5ldGVzMB4XDTE4MDUxODExNDEyMloXDTI4MDUxNTExNDEyMlowFTETMBEGA1UE
AxMKa3ViZXJuZXRlczCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMc+
Sxosm236noxvS18sCj72ny9fyFDoXPamhNIHPADi8WCTK+9Y9tJQ5i9PFjkrPIl9
G/egVlMPklY78COS/n8vpyEF0LUHAnR/mRZMXeiy7gG2WeKyCdGYB1aCu/HKM3xc
tx6GDkWIsDEW+jMkrUWSbSOyJ5Ix7j/UF5+fxySo27/LRFWDOxKr/WM4Dyg6eJlD
EAx6pa2s4xcyB2wipHgMc57K4Ikqq6koahBgp9h6bzYYGMJUhZxIzM9Qk3JpwR5k
36k6VfA3QmsGoAARlCIFa1cZUGyRYCJKiHLYd7JoTBXidG/ASnO6K2BSNtgjbxey
z3pCgf2L1qQj7uxwP2sCAwEAAaMjMCEwDgYDVR0PAQH/BAQDAgKkMA8GA1UdEwEB
/wQFMAMBAf8wDQYJKoZIhvcNAQELBQADggEBADvA9UP8zbt4NaX+5WZFCL8YGmOv
L5w7xXYMO5E7qRpLz3J+tow4Fj4fxL9a0YW5T0FFAJX5FyfYMpcMEULvjhBoMuJ/
UqaUjxSZIkXLzn7ffF2XoLbI1YTv8VdjRUsXkunwtSB5bqt3AlS/+jx+sK/qnJ+f
phCnuBvHHHoD4Bn8uXYOsbWErY6SLWOOejryIfE9nyVQqGKghBonvLhD1x4d3EHO
QTILkfEryeU6YTrO1nPhyxCyWYT6g/EV766ibgez35RaSKl4cKb5RbSUe+f9jVU9
OHfrj3QaYSIAlxC3mvQi7hmZrusxs8PhOM0i+WbosDpJwcBm1f2YSMuow7U=
-----END CERTIFICATE-----''', credentialsId: '', serverUrl: '192.168.1.200') {
    sh 'kubectl version'
}

      }
    }
  }
}
