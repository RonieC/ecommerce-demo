pipeline {

	agent none

	environment {
	    MyKeyID="myCustomValue1"
	}
	
	stages {
	
	stage('Init') {
    	steps {
    		script {
          		node {
                      timestamps  {
                          println "Descargar codigo fuente"
                          checkout scm
                          bat """
                                npm install
                            """
                      }
        			
          		}
        	}
    	}
	}
	
	stage('Deploy') {
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
