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
        stage('UNIT testing'){
            
            steps{
                
                script{
                    
                    sh 'mvn test'
                }
            }
        }
       stage('Integration testing'){
            
            steps{
                
                script{
                    
                    sh 'mvn verify -DskipUnitTests'
                }
            }
        }
        stage('Maven build'){
              steps{
                sh 'mvn clean install'
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
        stage('Build Docker Image') {    
             steps {
                script {
                    // Define the Docker build step here
                    sh'docker --version'
                }
            }
        }

    
    }
}  

