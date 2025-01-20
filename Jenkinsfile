pipeline {
  agent any
  // JAVA와 Maven Tool 등록
  tools {
    jdk 'JDK17'
    maven 'M3'
  }

  // Docker Hub 접속 정보
  environment {
    DOCKERHUB_CREDENTIALS = credentials('dockerCredentials')
    AWS_CREDENTIALS = credentials('AWSCredentials')
    GIT_CREDENTIALS = credentials('gitCredentials')
    REGION = 'ap-northeast-2'
  }

  stages {
    // GitHub에서 Jenkins로 소스코드 복제
    stage('Git Clone') {
      steps {
        stage('Git Clone'){
        git url: 'https://github.com/nakwonbea/spring-petclinic.git',
          branch: 'main', credentialIdL: 'HIT_CREDETIALS'
        }
      }
    }
  }








