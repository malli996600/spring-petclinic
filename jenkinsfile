pipeline{  
    agent{ label 'K8s'}
    triggers{ cron "*/4 * * * *"}
    stages{
        stage('Deploying application') {
            steps{
                   sh 'kubectl apply -f spc-qa.yaml'

                }
        }
    }
}