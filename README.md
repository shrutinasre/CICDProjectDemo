BASIC PIPELINE CODE SAMPLE

pipeline{
    agent {label "worker1"}
    
    stages{
        stage("code"){
            steps{
                echo "This is cloning stage of the code from git repo"
                git url: "https://github.com/shrutinasre/CICDProjectDemo.git", branch: "master"
                echo "Code cloning successfull"
            }
        }
        stage("Build"){
            steps{
                echo "This is building the code using docker"
                sh "whoami"
                sh "docker build -t cicddemo-app:latest ."
            }
        }
        stage("Test"){
            steps{
                echo "This is testing stage"
            }
        }
        stage("Push to DockerHub"){
            steps{
                echo "This is pushing the image to Docker Hub"
                withCredentials([usernamePassword(
                    'credentialsId': "dockerHubCred",
                     passwordVariable:"dockerHubPass",
                     usernameVariable:"dockerHubUser")]){
                sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPass}"
                sh "docker image tag cicddemo-app:latest ${env.dockerHubUser}/cicddemo-app:latest"
                sh "docker push ${env.dockerHubUser}/cicddemo-app:latest"
                }
            }
        }
        stage("Deploy"){
            steps{
                echo "Happy Deploying on ec2 instance"
                sh "docker compose up -d"
            }
        }
    }
}
