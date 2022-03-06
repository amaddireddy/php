pipeline{
    agent any
    environment{
        IMAGE_NAME = 'amaddireddy/newimage:php$BUILD_NUMBER'
        SERVER_IP = 'ec2-user@65.2.142.157'
    }
    stages{
        stage('Build docker image'){ 
            agent any
            steps{
                script{
        sshagent(['Test_server_Key']) {
        withCredentials([usernamePassword(credentialsId: 'docker-hub', passwordVariable: 'PASSWORD', usernameVariable: 'USERNAME')]) {
    echo "Building the docker image"    
    sh "scp -o StrictHostKeyChecking=no -r docker-files/ ${SERVER_IP}:/home/ec2-user"
    sh "ssh -o StrictHostKeyChecking=no ${SERVER_IP} 'bash ~/docker-files/docker-script.sh'"
    sh "ssh ${SERVER_IP} sudo docker build -t ${IMAGE_NAME} /home/ec2-user/docker-files/"
    sh "ssh ${SERVER_IP} sudo docker login -u $USERNAME -p $PASSWORD"
    sh "ssh ${SERVER_IP} sudo docker push ${IMAGE_NAME}"
                 }
            }
        }        
         }
}
    }
}