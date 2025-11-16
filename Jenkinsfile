pipeline{
  agent any
  triggers {
   pollSCM('H/2 * * * *')
  }
  stages{
   stage('git'){
      steps{
      git url:'https://github.com/vhazarathnaidu/git-branching-stratey.git',branch:'feature-ep-004-task-002'
	  }
   }
   stage('build java'){
    steps{
	 dir(java){
	  bat 'javac Hello.java'
	  bat 'java Hello'
	 }
	 }
	 stage('build python'){
	    steps{
		dir(python){
		bat 'Hello.py'
		}
		}
	}
	stage('build node'){
	    steps{
		dir(node){
		bat 'Hello.js'
		}
		}
	 }
	
  }
}
}
