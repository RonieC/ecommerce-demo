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
