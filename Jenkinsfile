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
        stage('Build Docker Image') {
            steps {
                script {
                    // Define Docker image name and tag
                    def imageNameWithTag = "myapp:v1.0"

                    // Build the Docker image and capture the result
                    def dockerImage = docker.build(imageNameWithTag, "-f path/to/Dockerfile .")

                    // Capture the image ID and tag
                    def imageId = dockerImage.id
                    def imageTag = dockerImage.getTag()

                    echo "Image ID: ${imageId}"
                    echo "Image Tag: ${imageTag}"
                }
            }
        }
       

    
    }
     
}
