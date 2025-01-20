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
    AWS_CREDENTIALS = credentials('AWSCredential')
    //GIT_CREDENTIALS = credentials('gitCredential')
    REGION = 'ap-northeast-2'
  }

  stages {
    // GitHub에서 Jenkins로 소스코드 복제
    stage('Git Clone') {
      steps {
        echo 'Git Clone'
        git url: 'https://github.com/nakwonbea/spring-petclinic.git',
          branch: 'main'
        }
      }
      //Maver 빌드 작업
      stage('Maver Build') {
      steps {
        echo 'Maver Build'
        sh 'mvn -Dmaven.test.failure.ignore=true clean package'
      }
      }
      //docker 이미지 생성
      stage('Docker Image build') {
        steps {
          echo 'Docker Image build'
        dir("${env.WORKSPACE}") {
          sh """
          docker build -t wonnack/spring-petclinic:$BUILD_NUMBER .
          docker tag wonnack/spring-petclinic:$BUILD_NUMBER wonnack/spring-petclinic:latest
          """
        }
        }
      }

      // DockerHub Login 이미지 푸쉬
      stage('Docker Login') {
        steps {
          sh """
          echo SOOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS USR --password-stdin
          docker push wonnack/spring-petclinic:latest
          """
        }
      }
      // Docker Image 삭제
      stage('Remove Docker Image') {
        steps {
          sh """
          docker rmi wonnack/spring-petclinic:$BUILD_NUMBER
          docker rmi wonnack/spring-petclinic: latest
          """
        }
      }



    
    }
  }








