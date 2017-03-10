node {
  stage("Checkout") {
      checkout scm
  }
  stage("Validate") {
    withEnv(["PATH+TERRAFORM=${tool 'terraform'}"]) {
      dir('terraform') {
        sh 'terraform validate -no-color'
      }
    }
  }
}