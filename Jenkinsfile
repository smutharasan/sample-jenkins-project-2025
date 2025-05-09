pipeline {

  environment {
    // Uncomment the below lines if not using an IAM instance profile
    AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
    AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    
    TF_VAR_region = 'us-east-1'
  }

  agent any

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

    stage('Verify Terraform Installation') {
      steps {
        echo "Checking Terraform version..."
        sh 'terraform -version'
      }
    }

    stage('Terraform Format Check') {
      steps {
        echo "Running terraform fmt..."
        sh 'terraform fmt -check -recursive'
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
        echo "Validating Terraform files..."
        sh 'terraform validate'
      }
    }

    stage('Terraform Plan') {
      steps {
        echo "Generating execution plan..."
        sh 'terraform plan -out=tfplan'
      }
    }

    stage('Approve Apply') {
      steps {
        input message: 'Do you want to apply these Terraform changes?'
      }
    }

    stage('Terraform Apply') {
      steps {
        echo "Applying infrastructure changes..."
        sh 'terraform apply -auto-approve tfplan'
      }
    }

    stage('Terraform Output') {
      steps {
        echo "Displaying Terraform outputs..."
        sh 'terraform output'
      }
    }
  }

  post {
    success {
      echo "✅ Terraform pipeline completed successfully."
    }
    failure {
      echo "❌ Pipeline failed. Check logs for details."
    }
    always {
      echo "🧹 Pipeline finished. Cleaning up if necessary."
    }
  }
}
