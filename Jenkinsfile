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
        stage('Static code analysis'){
            steps{
                waitForQualityGate abortPipeline: false, credentialsId: 'sonar-api'
                sh'mvn clean package sonar:sonar'
            }
        }
        stages {
            stage ('Initialize & SonarQube Scan') {
                steps {
                def scannerHome = tool 'sonarScanner';
                withSonarQubeEnv('My SonarQube Server') {

                bat """
                    ${scannerHome}/bin/sonar-runner.bat
                    pip install -r requirements.txt
                    """
                    }
          }
                 
        }
        
} 
