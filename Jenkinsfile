pipeline{
  agent any
  triggers {
   cron('* * * * *')
  }
  stages{
   stage('git'){
      steps{
      git url:'https://github.com/vhazarathnaidu/git-branching-stratey.git',branch:'main'
	  }
   }
   stage('build') {
            steps {
                dir('java') {
                    bat 'javac Hello.java'
                    bat 'java Hello'
                }
                dir('python') {
                    bat 'python Hello.py'
                }
				dir('node'){
				bat 'node Hello.js'
				}
	 }
	
  }


