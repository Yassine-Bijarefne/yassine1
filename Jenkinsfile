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
        stage('Quality Gate') {
            steps {
                script {
                        def qg = waitForQualityGate()
                        echo "JSON Response: ${qg}"  // Print the JSON response
                    }
                }
        }
    }
     
}
