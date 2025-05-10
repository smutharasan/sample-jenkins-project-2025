pipeline {
  agent any

  environment {
    TF_VAR_region = 'us-east-1'
  }

  parameters {
    booleanParam(name: 'APPLY', defaultValue: false, description: 'Check to apply infrastructure')
    booleanParam(name: 'DESTROY', defaultValue: false, description: 'Check to destroy infrastructure')
  }

  options {
    timestamps()
  }

  stages {

    stage('Checkout') {
      steps {
        echo 'Cloning repo...'
        checkout scm
      }
    }

    stage('Terraform Init') {
      steps {
        echo 'Initializing Terraform...'
        sh 'terraform init'
      }
    }

    stage('Terraform Validate') {
      steps {
        echo 'Validating Terraform...'
        sh 'terraform validate'
      }
    }

    stage('Terraform Plan') {
      steps {
        echo 'Generating Terraform plan...'
        sh 'terraform plan -out=tfplan'
      }
    }

    stage('Terraform Apply') {
      when {
        expression { return params.APPLY == true }
      }
      steps {
        input message: 'Proceed to apply Terraform changes?'
        sh 'terraform apply -auto-approve tfplan'
      }
    }

    stage('Terraform Destroy') {
      when {
        expression { return params.DESTROY == true }
      }
      steps {
        input message: 'Are you sure you want to destroy the infrastructure?'
        sh 'terraform destroy -auto-approve'
      }
    }

    stage('Terraform Output') {
      when {
        expression { return params.APPLY == true }
      }
      steps {
        echo 'Terraform Outputs:'
        sh 'terraform output'
      }
    }
  }

  post {
    always {
      echo 'Pipeline complete.'
    }
    failure {
      echo 'Pipeline failed.'
    }
  }
}
