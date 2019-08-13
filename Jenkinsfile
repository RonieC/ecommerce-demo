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
			  dir("myFolder") {
				  checkout scm
				  bat """
					npm install
				    """
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
                      timestamps  {
                          unstash "${stashName}"
				dir("myFolder") {
        			 bat """
					sonar-scanner.bat
				    """	
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
				unstash "${stashName}"
				dir("myFolder") {
        			 bat """
					npm start
				    """	
				}
          		}
        	}
    	}
	}    
}

}
