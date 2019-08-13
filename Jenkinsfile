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
				    """	
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
                      timestamps  {
                          unstash "myFolder"
				dir("myFolder") {
        			 bat """
				 	dir
					
					 docker login
					 docker build -t myfirstdocker:tagname .
					 docker tag myfirstdocker:tagname xxroniexx/myfirstdocker:tagname
					 docker push xxroniexx/myfirstdocker:tagname
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
