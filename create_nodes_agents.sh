step-1 - installing jenkin CLI
--------------------------------------
curl -sO http://44.255.75.223:8080/jnlpJars/jenkins-cli.jar

step-2 -Creating one node
--------------------------------------

<slave>
  <name>javanode</name>
  <remoteFS>/home/jenkins</remoteFS>
  <numExecutors>4</numExecutors>
  <mode>NORMAL</mode>
  <launcher class="hudson.slaves.JNLPLauncher"/>
  <label>java-agent</label>
</slave>

step-3 execute cli command
-------------------------------
java -jar jenkins-cli.jar -s http://44.255.75.223:8080/ -auth admin:119e1971086bf93f9d1b79a43c1577bb26 create-node NewAgent < node.xml

API Token
119e1971086bf93f9d1b79a43c1577bb26


Creating Agent
-----------------------------

curl -sO http://44.255.75.223:8080/jnlpJars/agent.jar
java -jar agent.jar -url http://44.255.75.223:8080/ -secret 28c94ca66aea94fd738a97caf956e8467f2fcbc0814106546d223ef9121cf37e -name NewAgent -webSocket 

Creating Multiple agents script
-------------------------------------------

#!/bin/bash

JENKINS_HOME="http://50.112.224.97:8080"
USER_NAME="admin"
API_TOKEN="119e1971086bf93f9d1b79a43c1577bb26"

for i in {1..3}
do
  sed "s/agent-1/agent-$i/g" node.xml > temp-node.xml

  java -jar jenkins-cli.jar -s $JENKINS_URL \
    -auth $USER:$API_TOKEN \
    create-node agent-$i < temp-node.xml

  echo "Created agent-$i"
done

Run Agents
---------------------------
java -jar agent.jar \
  -url http://50.112.224.97:8080 \
  -name NewAgent \
  -secret 28c94ca66aea94fd738a97caf956e8467f2fcbc0814106546d223ef9121cf37e \
  -workDir /home/jenkins/git-branching-stratey \
  -webSocket
  
