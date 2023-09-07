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
         stage ('SonarQube scan') {
                steps {
                    withSonarQubeEnv(installationName:'sonarqube') {
                        sh 'mvn clean package sonar:sonar'
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
                            credentialsId: 'nexus-project',
                            groupId: 'com.example',
                            nexusUrl: '192.168.56.5:8081/',
                            nexusVersion: 'nexus3',
                            protocol: 'http',
                            repository: 'project-release',
                            version: '1.1.0'
                    }
            }
      
    
        }
    }
}  

