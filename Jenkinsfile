pipeline {

	agent none
	
	//agent {
        	//docker { image 'node:7-alpine' }
    	//}

	environment {
	    MyKeyID="myCustomValue1"
	}
	
	stages {
	
	stage('Init') {
	//agent {
                //docker { image 'node:7-alpine' }
            //}
    	steps {
    		script {
          		node {
				docker.withRegistry('https://registry.hub.docker.com/',"DockerHubCredential2") {
					docker.image('98640321id/primer-docker:mi-etiqueta5test').inside("-u root:root") {
					      timestamps  {
						  println "Descargar codigo fuente"
							  dir("myFolder") {
						
							  checkout scm
							  sh """
							  	#npm --version
								npm install
								"""
							     }
							 }
				  		}
				   		 stash name: "myFolder", include: "myFolder/**"
					}
        			
          		}
        	}
    	}
	}
		
		
	stage('Analisis de codigo con Sonar') {
		steps {
			script {
				node {
					docker.withRegistry('https://registry.hub.docker.com/',"DockerHubCredential2") {
						docker.image('98640321id/primer-docker:mi-etiqueta5test').inside("-u root:root") {
						      timestamps  {
							  unstash "myFolder"
								dir("anotherFolder") {
								 sh """
								 	echo "Analisis de codigo con Sonar"
									pwd
								    """	
								}
						      }
						}
					}

				}
			}
		}
	}
		
	stage('Contenedor Docker') {
		steps {
			script {
				node {
					docker.withRegistry('https://registry.hub.docker.com/',"DockerHubCredential2") {
						docker.image('98640321id/primer-docker:mi-etiqueta5test').inside("-u root:root") {
						      timestamps  {
							  unstash "myFolder"
								dir("myFolder") {
								 sh """
									 #docker login
									 #docker build -t primer-docker2:my-etiqueta .
									 #docker tag primer-docker2:my-etiqueta 98640321id/primer-docker:my-etiqueta
									 #docker push primer-docker:my-etiqueta
								    """	
								}
						      }
						}
					}

				}
			}
		}
	}
	
	stage('Deploy') {
    	steps {
    		script {
          		node {
				docker.withRegistry('https://registry.hub.docker.com/',"DockerHubCredential2") {
					docker.image('98640321id/primer-docker:mi-etiqueta5test').inside("-u root:root") {
						unstash "${stashName}"
						dir("myFolder") {
						 sh """
							npm start
						    """	
						}
					}
				}
          		}
        	}
    	}
	}    
}

}
