pipeline {
  agent any // Your EC2 Jenkins agent label

  environment {
    TF_VAR_region = 'us-east-1' // Optional: can also pass other variables
  }

  options {
    timestamps()
  }

  stages {

    stage('Checkout Code') {
      steps {
        echo "Cloning repository..."
        checkout scm
      }
    }

    stage('Terraform Init') {
      steps {
        echo "Initializing Terraform..."
        sh 'terraform init'
      }
    }

    stage('Terraform Validate') {
      steps {
        echo "Validating Terraform configuration..."
        sh 'terraform validate'
      }
    }

    stage('Terraform Plan') {
      steps {
        echo "Planning Terraform changes..."
        sh 'terraform plan -out=tfplan'
      }
    }

    stage('Approve Apply') {
      steps {
        input message: 'Apply Terraform changes?'
      }
    }

    stage('Terraform Apply') {
      steps {
        echo "Applying Terraform changes..."
        sh 'terraform apply -auto-approve tfplan'
      }
    }

    stage('Terraform Output') {
      steps {
        echo "Displaying Terraform output..."
        sh 'terraform output'
      }
    }
  }

  post {
    always {
      echo "Pipeline complete."
    }
    failure {
      echo "Pipeline failed."
    }
  }
}
