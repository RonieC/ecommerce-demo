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
                          unstash "myFolder"
				dir("myFolder") {
        			 bat """
				 	dir
					sonar-scanner.bat -Dproject.settings=./sonar-project.properties
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
				unstash "myFolder"
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
