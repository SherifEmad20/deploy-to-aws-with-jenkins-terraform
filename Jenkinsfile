// ${BUILD_ID}
pipeline {
    agent any

    environment {
        USER_CREDENTIALS = credentials('docker_account')
        DOCKER_IMAGE = "sherifemad21/school-backend:v-1"
        DOCKER_USERNAME = "${USER_CREDENTIALS_USR}"
        DOCKER_PASSWORD = "${USER_CREDENTIALS_PSW}"

        AWS_CREDENTIALS = credentials('aws_credentials')
        ACCESS_KEY = "${AWS_CREDENTIALS_USR}"
        SECRET_KEY = "${AWS_CREDENTIALS_PSW}"

    }

    stages {
        // stage('Maven test') {
        //     agent {
        //         docker { 
        //             image 'openjdk:latest'
        //         }
        //     }

        //     steps {
        //         dir("./app") {
        //             sh "chmod +x mvnw"
        //             sh "./mvnw test"
        //         }
        //     }
        // }
        
        // stage('Maven build') {dev
        //     agent {
        //         docker {
        //             image 'openjdk:latest'
        //         }
        //     }

        //     steps {
        //         dir("./app") {
        //             sh "chmod +x mvnw"
        //             sh "./mvnw clean"
        //             sh "./mvnw install"
        //         }
        //     }
        // }
        
        stage('Docker Credentials') {
            steps {
                sh 'docker logout'
                sh "echo ${DOCKER_USERNAME}"
                sh "echo ${DOCKER_PASSWORD}"
                sh "docker login -u ${DOCKER_USERNAME} -p ${DOCKER_PASSWORD}"
            }
        }

        // stage('Docker Build') {
        //     steps {
        //         dir("./app") {
        //             sh "docker build -t ${DOCKER_IMAGE} ."
        //         }
        //     }
        // }

        // stage('Docker Push') {
        //     steps {
        //         sh "docker push ${DOCKER_IMAGE}"
        //         sh "docker rmi -f ${DOCKER_IMAGE}"
        //     }
        // }

        stage('Edit files') {
            steps {
                dir("./terraform") {
                    sh """
                      sed -e "s|DockerImageToPull|${DOCKER_IMAGE}|g" -e "s|Username|${DOCKER_USERNAME}|g" -e "s|Password|${DOCKER_PASSWORD}|g" dockerScript-template.sh > dockerScript.sh                    
                    """

                    sh """
                      sed -e "s|ACCESS_KEY_TO_REPLACE|${ACCESS_KEY}|g" -e "s|SECRET_KEY_TO_REPLACE|${SECRET_KEY}|g" terraform-template.txt > terraform.tfvars   

                    """
                }
            }
        }

        stage("Deploy to AWS IAC") {
            when {
                branch 'master'
            }

            steps {
                dir("./terraform") {
                    sh 'terraform init'
                    sh "terraform plan"
                    sh 'terraform destroy --auto-approve'
                    sh 'terraform apply --auto-approve'
                }
            }

            post {
                success {
                    echo "Successfully deployed to AWS"
                }

                failure {
                    dir("./terraform") {
                    sh 'terraform destroy --auto-approve'
                    }
                }
                
            }
        }
       
        stage("Smoke test on deployment") {
            when {
                branch 'master'
            }

            steps {
                dir("./terraform") {
                    sh 'chmod +x smokeTest.sh'
                    sh "./smokeTest.sh"
                }
            }

            post {
                success {
                    echo "Smoke test successful"
                }

                failure {
                    echo "Public IP not available yet. Please wait and try again later."
                }
                
            }
        }


    }
}
