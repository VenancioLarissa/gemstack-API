pipeline {
   agent {
       docker {
           image 'ruby'
           args '--network skynet'
        //    rede onde se tem acesso ao ambiente
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
              sh 'rspec --format RspecJunitFormatter --out rspec.xml'    
          }
          post {
              always {
                  junit 'rspec.xml'
              }
          }
      }
      stage('UAT') {
          steps {
              echo 'Testes de aceitacao'
              input message: 'Podemos ir para producao'
          }
      }
      stage('Prod') {
          steps {
              echo 'App pronto para producao'
          }
      }
   }
}
