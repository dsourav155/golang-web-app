
pipeline {
  agent {
    kubernetes {
        yamlFile 'podtemplate/jenkinstemplate.yaml'
        idleMinutes 10
    }
  }
  stages {
        stage('Build Artifact') {
            steps {
                container('alacrity') {
                    sh 'gcloud auth configure-docker us-central1-docker.pkg.dev'
                    sh 'go build -o main .'
                    sh 'docker build -t us-central1-docker.pkg.dev/devops-353009/devops-docker/golang-web-app:v2 .'
                    sh 'docker push us-central1-docker.pkg.dev/devops-353009/devops-docker/golang-web-app:v2'
                }
            }
        }
    }
}