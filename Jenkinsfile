pipeline{
  agent any
  triggers {
   cron('* * * * *')
  }
  stages{
   stage('git'){
      steps{
      git url:'https://github.com/vhazarathnaidu/git-branching-stratey.git',branch:'feature-ep-004-task-002'
	  }
   }
   stage('Build java'){
    steps{
	 dir(java){
	  bat 'javac Hello.java'
	  bat 'java Hello'
	 }
	 }
	 }
	 stage('Build python'){
	    steps{
		dir(python){
		bat 'Hello.py'
		}
		}
	}
	stage('Build node'){
	    steps{
		dir(node){
		bat 'Hello.js'
		}
		}
	 }
	
  }
}

