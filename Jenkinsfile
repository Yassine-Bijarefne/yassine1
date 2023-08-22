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
                    def qualityGate = waitForQualityGate()
                    echo "Quality Gate Status: ${qualityGate.status}"
                    
                    if (qualityGate.status == 'OK') {
                        echo "Quality Gate passed. Continuing with the pipeline."
                    } else {
                        error "Quality Gate failed. Aborting the pipeline."
                    }
                }
            }
    }     
}}
