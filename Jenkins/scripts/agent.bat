@echo off
setlocal enabledelayedexpansion
set JENKINS_URL=http://localhost:9091
set USERNAME=admin
set PASSWD=admin
set JAVA_NODE=java-agent
set PYTHON_NODE=python-agent
set NODEJS_NODE=nodejs-agent

set LABEL_JAVA=java
set LABEL_PYTHON=python
set LABEL_NODE=nodejs

set BASE_DIR=D:\sfts\agents

for %%D in (java python nodejs) do (
    mkdir "%BASE_DIR%\%%D"
)

echo Downloading Jenkins CLI...
powershell -command "(New-Object Net.WebClient).DownloadFile('%JENKINS_URL%/jnlpJars/jenkins-cli.jar','D:\sfts\jenkins-cli.jar')"

(
echo ^<slave^>
echo   ^<name^>%JAVA_NODE%^</name^>
echo   ^<remoteFS^>%BASE_DIR%\java^</remoteFS^>
echo   ^<numExecutors^>2^</numExecutors^>
echo   ^<label^>%LABEL_JAVA%^</label^>
echo   ^<mode^>EXCLUSIVE^</mode^>
echo   ^<launcher class="hudson.slaves.JNLPLauncher"/^>
echo   ^<retentionStrategy class="hudson.slaves.RetentionStrategy$Always"/^>
echo ^</slave^>
) > java-node.xml
java -jar D:\sfts\jenkins-cli.jar -s %JENKINS_URL% -auth %USERNAME%:%PASSWD% create-node < java-node.xml
echo connecting java-agent to controller...
curl.exe -sO http://localhost:9091/jnlpJars/agent.jar 
start "" cmd /c java -jar agent.jar -url http://localhost:9091/ -secret 7213aeb2cf80e705d99aa8661ecfb801ec4d91a0f0ddb5968449ca7c5e9abd60 -name "java-agent" -webSocket 
(
echo ^<slave^>
echo   ^<name^>%PYTHON_NODE%^</name^>
echo   ^<remoteFS^>%BASE_DIR%\python^</remoteFS^>
echo   ^<numExecutors^>2^</numExecutors^>
echo   ^<label^>%LABEL_PYTHON%^</label^>
echo   ^<mode^>EXCLUSIVE^</mode^>
echo   ^<launcher class="hudson.slaves.JNLPLauncher"/^>
echo   ^<retentionStrategy class="hudson.slaves.RetentionStrategy$Always"/^>
echo ^</slave^>
) > python-node.xml
java -jar D:\sfts\jenkins-cli.jar -s %JENKINS_URL% -auth %USERNAME%:%PASSWD% create-node < python-node.xml
echo connecting to python-agent to controller...
curl.exe -sO http://localhost:9091/jnlpJars/agent.jar 
start "" cmd /c java -jar agent.jar -url http://localhost:9091/ -secret 6a5b634cfdd7f494a97f685f705ff6d9286700d17d42d1cb58bdc7bd79dcd313 -name "python-agent" -webSocket 
(
echo ^<slave^>
echo   ^<name^>%NODEJS_NODE%^</name^>
echo   ^<remoteFS^>%BASE_DIR%\nodejs^</remoteFS^>
echo   ^<numExecutors^>2^</numExecutors^>
echo   ^<label^>%LABEL_NODE%^</label^>
echo   ^<mode^>EXCLUSIVE^</mode^>
echo   ^<launcher class="hudson.slaves.JNLPLauncher"/^>
echo   ^<retentionStrategy class="hudson.slaves.RetentionStrategy$Always"/^>
echo ^</slave^>
) > node-node.xml
java -jar D:\sfts\jenkins-cli.jar -s %JENKINS_URL% -auth %USERNAME%:%PASSWD% create-node < node-node.xml
echo connecting Nodejs-agent to controller....
curl.exe -sO http://localhost:9091/jnlpJars/agent.jar 
start "" cmd /c java -jar agent.jar -url http://localhost:9091/ -secret 83f4d814a0b9477c3b7cbd148e74171d37aa36861e3f63a067c38e20e4ec654e -name "nodejs-agent" -webSocket 

echo Creating Jenkins Agents...
echo Agents are created successfully.....

