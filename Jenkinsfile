pipeline {
  agent any
  // JAVA와 Maven Tool 등록
  tools {
    jdk 'jdk17'
    maven 'M3'
  }

  // Docker Hub 접속 정보
  environment {
    DOCKERHUB_CREDENTIALS = credentials('dockerCredentials')
  }

  stages {
    // GitHub에서 Jenkins로 소스코드 복제
    stage('Git Clone') {
      steps {
        git url: 'https://github.com/nakwonbea/spring-petclinic.git', branch: 'main'
      }
    }
    stage('Maven Build') {
      steps {
        sh 'mvn -Dmaven.test.failure.ignore=true clean package'
      }
    }
    stage('Docker Image') {
      steps {
        dir("${env.WORKSPACE}") {
          sh """
          docker build -t nakwonbea/spring-petclinic:$BUILD_NUMBER .
          docker tag nakwonbea/spring-petclinic:$BUILD_NUMBER nakwonbea/spring-petclinic:latest
          """
        }
      }
    }

    stage ('Docker Image Push') {
      steps {
        sh """
        echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin
        docker push nakwonbea/spring-petclinic:latest
        """
      }
    }

    stage ('Remove Docker Image') {
      steps {
        sh """
        docker rmi nakwonbea/spring-petclinic:$BUILD_NUMBER 
        docker rmi nakwonbea/spring-petclinic:latest
        """
      }
    }

    stage ('Docker Container') {
      steps {
        sshPublisher(publishers: [sshPublisherDesc(configName: 'target', 
        transfers: [sshTransfer(cleanRemote: false, excludes: '', 
        execCommand: '''
        docker rm -f $(docker ps -aq)
        docker rmi $(docker images -q)
        docker run -d -p 80:8080 --name spring-petclinic nakwonbea/spring-petclinic:latest
        ''', 
        execTimeout: 120000, 
        flatten: false, 
        makeEmptyDirs: false, 
        noDefaultExcludes: false, 
        patternSeparator: '[, ]+', 
        remoteDirectory: '', 
        remoteDirectorySDF: false, 
        removePrefix: '', 
        sourceFiles: '')], 
        usePromotionTimestamp: false, 
        useWorkspaceInPromotion: false, 
        verbose: false)])
      }
    }

    
  }  
}








