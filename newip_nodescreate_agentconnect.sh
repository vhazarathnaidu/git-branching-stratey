#!/bin/bash
set -e

# -------------------------------
# STEP 1: GET PUBLIC IP
# -------------------------------
NEW_IP=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)

if [ -z "$NEW_IP" ]; then
  NEW_IP=$(curl -s http://checkip.amazonaws.com)
fi

if [ -z "$NEW_IP" ]; then
  echo "Failed to fetch Public IP"
  exit 1
fi

JENKINS_URL=http://${PUBLIC_IP}:8080

USER=$JENKINS_USER
TOKEN=$API_TOKEN

echo "Using Jenkins URL: $JENKINS_URL"

# -------------------------------
# STEP 2: DOWNLOAD CLI + AGENT
# -------------------------------
wget -q $JENKINS_URL/jnlpJars/jenkins-cli.jar
wget -q $JENKINS_URL/jnlpJars/agent.jar

# -------------------------------
# STEP 3: UPDATE JENKINS URL
# -------------------------------
JENKINS_CONFIG="/var/lib/jenkins/jenkins.model.JenkinsLocationConfiguration.xml"

sudo sed -i "s|<jenkinsUrl>.*</jenkinsUrl>|<jenkinsUrl>$JENKINS_URL/</jenkinsUrl>|g" $JENKINS_CONFIG
sudo chown jenkins:jenkins $JENKINS_CONFIG

#sudo systemctl restart jenkins
#echo "Jenkins restarted"

sleep 5

# -------------------------------
# STEP 4: CREATE + CONNECT NODES
# -------------------------------
read -p "How many nodes you want? " COUNT

for ((i=1;i<=COUNT;i++))
do
  read -p "Enter node name $i: " NAME

cat > node.xml <<EOF
<slave>
  <name>$NAME</name>
  <remoteFS>/home/ubuntu/$NAME</remoteFS>
  <numExecutors>1</numExecutors>
  <mode>NORMAL</mode>
  <retentionStrategy class="hudson.slaves.RetentionStrategy\$Always"/>
  <launcher class="hudson.slaves.JNLPLauncher"/>
  <label>java</label>
</slave>
EOF

  # CREATE NODE
  java -jar jenkins-cli.jar \
    -s $JENKINS_URL \
    -auth $USER:$TOKEN \
    -webSocket \
    create-node $NAME < node.xml

  echo "Node created: $NAME"

  # GET SECRET
  SECRET=$(curl -s -u $USER:$TOKEN \
  "$JENKINS_URL/computer/$NAME/slave-agent.jnlp" \
  | grep -oP '(?<=<argument>).*?(?=</argument>)' | head -n 1)

  if [ -z "$SECRET" ]; then
    echo "Secret not found for $NAME"
    continue
  fi

  # CONNECT AGENT
  mkdir -p /home/ubuntu/$NAME

  nohup java -jar agent.jar \
    -url $JENKINS_URL \
    -secret $SECRET \
    -name $NAME \
    -webSocket \
    -workDir /home/ubuntu/$NAME > $NAME.log 2>&1 &

  echo "Agent connected: $NAME"

done

echo "✅ ALL DONE"