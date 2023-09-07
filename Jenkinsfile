pipeline{
    
    agent any 
     environment {
        PATH = "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/usr/bin/docker"
        CUSTOM_VAR = "some_value"}
    
    stages {

        
        stage('Git Checkout'){
            
            steps{
                
                script{
                    
                    git branch: 'main', url: 'https://github.com/Yassine-Bijarefne/yassine1.git'
                    //hello
                }
            }
        }
        stage('Maven package') {
            steps {
                script {
                    def mvnHome = tool name: 'maven', type: 'maven'
                    sh "${mvnHome}/bin/mvn package"
                }
            }
        }

        stage('Maven build') {
            steps {
                script {
                    def mvnHome = tool name: 'maven', type: 'maven'
                    sh "${mvnHome}/bin/mvn clean install"
                }
            }
        }
   
        stage('Integration testing'){

            steps{
                
                script{
                    def mvnHome = tool name: 'maven', type: 'maven'
                    sh "${mvnHome}/bin/mvn verify -DskipUnitTests"
                }
            }
        }

        stage('SonarQube scan') {
            steps {
                script {
                    def mvnHome = tool name: 'maven', type: 'maven'

                    withSonarQubeEnv(credentialsId: 'sonar-ID', installationName: 'sonar') {
                        sh "${mvnHome}/bin/mvn clean package sonar:sonar"
                    }
                }
            }
        }
        stage('Upload jar file to nexus'){
            steps{
                    script{
                        nexusArtifactUploader artifacts: 
                        [
                            [
                                artifactId: 'springboot', classifier: '', file: 'target/springboot-1.0.0.jar', type: 'jar'
                            ]
                            ],
                            credentialsId: 'nexus-ID',
                            groupId: 'com.example',
                            nexusUrl: '192.168.56.5:8081/',
                            nexusVersion: 'nexus3',
                            protocol: 'http',
                            repository: 'project-release',
                            version: '1.1.0'
                    }
            }     
        }
       stage('Docker Image Build') {
        steps {
            script {
                // Define the name of the Docker tool installation in Jenkins
                def dockerToolName = 'docker'

                // Install and configure the Docker tool (if not already installed)
                def dockerInstallation = tool name: dockerToolName, type: 'Tool Type'

                // Check if Docker installation was successful
                if (dockerInstallation) {
                    // Use the Docker installation to build and tag the image
                    sh "${dockerInstallation}/bin/docker image build -t $JOB_NAME:v1.$BUILD_ID ."
                    sh "${dockerInstallation}/bin/docker image tag $JOB_NAME:v1.$BUILD_ID YassineBija/$JOB_NAME:v1.$BUILD_ID"
                    sh "${dockerInstallation}/bin/docker image tag $JOB_NAME:v1.$BUILD_ID YassineBija/$JOB_NAME:latest"
                } else {
                    error "Docker installation failed."
                }
            }
        }
    }


    }
}  

