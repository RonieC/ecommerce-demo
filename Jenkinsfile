import org.jenkinsci.plugins.workflow.steps.FlowInterruptedException



pipeline {

	agent none

	environment {
	    MyKeyID="myCustomValue1"
	}
	
	stages {
		
		
	
stage("stage master") {
		steps {
    			script {
					stage("inner stage 1") {
						script {
							node {
								println "inner stage 1"
								//def MIN_VERSION=bat returnStdout: true, script: 'git rev-parse --short HEAD'
								//MIN_VERSION=sh(returnStdout: true, script: "git rev-parse --short HEAD").trim()
								//println "La version actual es: ${MIN_VERSION}"
								//writeFile file: 'version.txt', text: '${MIN_VERSION}'
							}

							
						}
					}

					stage("inner stage 2") {
						script {
							node {
								timestamps {
								println "inner stage 2"
								emailext body: '${BUILD_NUMBER} The pipeline was executed successfully. ${PROJECT_NAME}', subject: 'The pipeline was executed successfully', to: 'jlccx@live.com'
								}
								}	
						}
					}
							

						}
					}
				}

	stage('Descargar codigo fuente') {
	    environment {
    	    MyKeyID="myCustomValue2x"
    	}
    	steps {
    		script {
          		node {
						    highlightStage("Descargar codigo fuente")
                checkout scm
        				println "Mi primer stage. MyKeyID value es: ${MyKeyID}"
                bat """
				npm install
				npm test
				"""
				bat 'sonar-scanner.bat -D"sonar.projectKey=ecommerce" -D"sonar.sources=." -D"sonar.host.url=http://localhost:9000" -D"sonar.login=d4aabceec65d97a5205f67f830b000a2d1e0b19a"'
          		}
        	}
    	}
	} 
	
	stage('Input test') {
    	steps {
    		script {
				try {
					timeout(time: 60, unit: "SECONDS"){
						input(message: "Esta seguro de hacer un deploy en produccion ?")
					}
				}
				catch(FlowInterruptedException error){
					def user = error.getCauses()[0].getUser().toString()
					
					// SYSTEM means timeout.
					if('SYSTEM' == user) { 
						println "Ejecucion del pipeline abortado automaticamente por el sistema. ${user}"
						}
					// If user is distinct from SYSTEM, then a jenkins user aborted the pipeline deploy manually.
					else {
						println "Ejecucion del pipeline abortado por el usuario ${user}."
					}
					
				}
				finally {
					node {
						println "Iniciando el deploy a produccion. "
					}
				}
				
        	}
    	}
	}
	
	stage('Fin') {
    	steps {
    		script {
          		node {
        			println "Mi segundo stage esta en ejecucion. KeyID: $MyKeyID" 
          		}
        	}
    	
	}
		}
}

}



def highlightStage(stageName) {
	//ansiColor('xterm') {
		echo "\033[42m  +++++++++++++++++++ ${stageName} Stage +++++++++++++++++++ \033[0m"
	//}
}
