pipeline {
    agent { label 'jdk_maven'}
    tools {
        maven 'maven_3.8.5'
    }
    stages {
        stage('scm') {
            steps {
                git url: 'https://github.com/malli996600/spring-petclinic.git', branch: 'declarative'
            }
        }
        stage ('Artifactory configuration') {
            steps {
                rtMavenDeployer (
                    id: "MAVEN_DEPLOYER",
                    serverId: 'jfrog',
                    releaseRepo: 'maven-malli-release',
                    snapshotRepo: 'maven-malli-snapshot'
                )
            }
        }
        stage ('Exec Maven') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'jfrog', usernameVariable: 'admin', passwordVariable: 'Malli@1997')]) {
                    rtMavenRun (
                        tool: 'maven_3.8.5',
                        pom: 'pom.xml',
                        goals: 'clean package',
                        deployerId: "MAVEN_DEPLOYER"
                    )
                    stash includes: '**/*.jar', name: 'spcjar'
                }
            }
        }
        stage('Quality Check'){
             steps {
                withSonarQubeEnv(installationName: 'sonar', envOnly: true, credentialsId: 'sonar taken') {
                    sh "mvn clean package sonar:sonar"
                    echo "${env.SONAR_HOST_URL}"
                    }
                }
            }
        stage ('Publish build info') {
            steps {
                rtPublishBuildInfo (
                    serverId: 'jfrog'
                )
            }
        }
        stage ('copy to other node') {
            agent { label 'malli9'}
            steps {
                unstash 'spcjar'
            }
        }
    }
}