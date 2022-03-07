pipeline{
    agent any
    environment{
        IMAGE_NAME = 'amaddireddy/newimage:php$BUILD_NUMBER'
        DEV_SERVER_IP = 'ec2-user@35.154.53.187'
        TEST_SERVER_IP = 'ec2-user@65.1.135.149'
    }
    stages{
        stage('BUILD DOCKER IMAGE ON DEV SERVER'){ 
            steps{
                script{
        sshagent(['Test_server_Key']) {
        withCredentials([usernamePassword(credentialsId: 'docker-hub', passwordVariable: 'PASSWORD', usernameVariable: 'USERNAME')]) {
    echo "BUILDING THE DOCKER IMAGE"    
    sh "scp -o StrictHostKeyChecking=no -r docker-files/ ${DEV_SERVER_IP}:/home/ec2-user"
    sh "ssh -o StrictHostKeyChecking=no ${DEV_SERVER_IP} 'bash ~/docker-files/docker-script.sh'"
    sh "ssh ${DEV_SERVER_IP} sudo docker build -t ${IMAGE_NAME} /home/ec2-user/docker-files/"
    sh "ssh ${DEV_SERVER_IP} sudo docker login -u $USERNAME -p $PASSWORD"
    sh "ssh ${DEV_SERVER_IP} sudo docker push ${IMAGE_NAME}"
                 }
            }
        }        
         }
}
    stage('RUN PHP APP ON TEST_SERVER'){
    steps{
        script{
    sshagent(['Test_server_Key']) {
    withCredentials([usernamePassword(credentialsId: 'docker-hub', passwordVariable: 'PASSWORD', usernameVariable: 'USERNAME')]) {
    echo "Building the docker image"
    sh "scp -o StrictHostKeyChecking=no -r docker-files/ ${TEST_SERVER_IP}:/home/ec2-user"
    sh "ssh -o StrictHostKeyChecking=no ${TEST_SERVER_IP} 'bash ~/docker-files/docker-script.sh'"
    sh "ssh ${TEST_SERVER_IP} sudo docker login -u $USERNAME -p $PASSWORD"
    sh "ssh ${TEST_SERVER_IP} bash /home/ec2-user/docker-files/docker-compose-script.sh ${IMAGE_NAME}"            
            }
        }
    }
    }
}
    }
}