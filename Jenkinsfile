pipeline {
   agent {
       docker {
           image 'ruby'
       }
            
   }

   stages {
      stage('Build') {
         steps {
            echo 'Compilando e/ou baixando dependencias'
            sh 'bundle install'
         }
      }
      stage('Test') {
          steps {
              echo 'Executando testes'
              sh 'rspec -fd'
          }
      }
      stage('UAT') {
          steps {
              echo 'Testes de aceitacao'
          }
      }
      stage('Prod') {
          steps {
              echo 'App pronto para producao'
          }
      }
   }
}
