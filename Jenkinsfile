pipeline {
    agent any
    parameters {
        choice(name: 'Terraform', choices: ['apply', 'destroy'], description: '')
        choice(name: 'Ansible', choices: ['apply', 'skip'], description: '')
    }
    

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: "git@github.com:vlddryga2233/diplom.git", credentialsId: 'github_key' 
            }
        }
        stage('Deploy Terraform') {
            when {
                // Only say hello if a "greeting" is requested
                expression { params.Terraform == 'apply' }
            }
            steps {
                dir("${env.WORKSPACE}/terraform") {
                    sh "pwd"
                    sh 'terraform init'
                    sh 'terraform apply --auto-approve'
                }
            }
        }
        stage('Destroy Terraform') {
            when {
                // Only say hello if a "greeting" is requested
                expression { params.Terraform == 'destroy' }
            }
            steps {
                dir("${env.WORKSPACE}/terraform") {
                    sh "pwd"
                    sh 'terraform init'
                    sh 'terraform apply --auto-approve'
                }
            }
        }
        stage('Wait 60 sec') {
            steps {
                sh 'sleep 1m'
            }
        }
        stage('Deploy Ansible') {
            when {
                // Only say hello if a "greeting" is requested
                expression { params.Ansible == 'apply' }
            }
            steps {
                dir("${env.WORKSPACE}/ansible")
                sh 'ansible-playbook main.yml'
            }
        }
    }
}
