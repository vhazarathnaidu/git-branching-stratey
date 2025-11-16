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
   stage('build'){
    steps{
	 dir(java){
	  bat 'javac Hello.java'
	  bat 'java Hello'
	 }
	 dir(python){
	   bat 'Hello.py'
	 }
	 dir(node){
	  bat 'Hello.js'
	 }
	}
   }
  }
}
