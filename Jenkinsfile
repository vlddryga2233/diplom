pipeline {
    agent any
    parameters {
        choice(name: 'Terraform', choices: ['apply', 'destroy'], description: '')
        choice(name: 'Ansible', choices: ['apply', 'skip'], description: '')
    }
    

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: "git@github.com:Nortsx/jenkinsansiblebook.git", credentialsId: 'github_key' // здесь добавляем credentialsId и указываем наш ID.
            }
        }
        stage('Deploy Terraform') {
            when {
                // Only say hello if a "greeting" is requested
                expression { params.Terraform == 'apply' }
            }
            steps {
                sh 'terrafomr init'
            }
            steps {
                sh 'terrafomr apply --auto-approve'
            }
        }
        stage('Destroy Terraform') {
            when {
                // Only say hello if a "greeting" is requested
                expression { params.Terraform == 'destroy' }
            }
            steps {
                sh 'terrafomr init'
            }
            steps {
                sh 'terrafomr destroy --auto-approve'
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
                sh 'ansible-playbook ./ansible/main.yml'
            }
        }
    }
}