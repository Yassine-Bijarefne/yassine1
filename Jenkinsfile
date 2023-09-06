pipeline{
    
    agent any 
    
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
                sh'mvn test'
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
        stage('Check Environment Variables') {
            steps {
                sh 'env'
            }
        }


    
    }
     
}
