#!/bin/bash
set -euo pipefail

# -----------------------------
# Config
# -----------------------------
JENKINS_URL="http://172.31.74.61:8080"
USERNAME="admin"
API_TOKEN="11f339f8e3882cef639ffcf07e9ce9fffd"

JAVA_NODE="java-agent"
LABEL="java"
PYTHON_NODE="python-agent"
LABEL="python"
NODEJS_NODE="nodejs-agent"
LABEL="nodejs
MODE="EXCLUSIVE"
BASE_DIR="/home/saikireeti/Jenkins/agents"
CLI_JAR="$BASE_DIR/jenkins-cli.jar"
AGENT_JAR="$BASE_DIR/agent.jar"

# -----------------------------
# Create directories
# -----------------------------
mkdir -p "$BASE_DIR"
chown -R $USER:$USER "$BASE_DIR"
cd "$BASE_DIR"

# -----------------------------
# Download Jenkins CLI and agent.jar
# -----------------------------
[ -f "$CLI_JAR" ] || curl -fsSL -o "$CLI_JAR" "$JENKINS_URL/jnlpJars/jenkins-cli.jar"
[ -f "$AGENT_JAR" ] || curl -fsSL -o "$AGENT_JAR" "$JENKINS_URL/jnlpJars/agent.jar"

# -----------------------------
# Create node XML
# -----------------------------
cat > node.xml <<EOF
<slave>
  <name>${JAVA_NODE}</name>
  <remoteFS>${BASE_DIR}</remoteFS>
  <numExecutors>2</numExecutors>
  <label>${LABEL}</label>
  <mode>${MODE}</mode>
  <launcher class="hudson.slaves.JNLPLauncher"/>
  <retentionStrategy class="hudson.slaves.RetentionStrategy\$Always"/>
</slave>
EOF

java -jar "$CLI_JAR" -s "$JENKINS_URL" -auth "$USERNAME:$API_TOKEN" get-node "$JAVA_NODE" >/dev/null 2>&1 || \
java -jar "$CLI_JAR" -s "$JENKINS_URL" -auth "$USERNAME:$API_TOKEN" create-node "$JAVA_NODE" < node.xml

SECRET=$(java -jar "$CLI_JAR" -s "$JENKINS_URL" -auth "$USERNAME:$API_TOKEN" groovy = <<EOF
import jenkins.model.*
def node = Jenkins.instance.getNode("$JAVA_NODE")
println node?.computer?.jnlpMac
EOF
)
echo "Fetched JNLP secret: $SECRET"
curl -sO http://localhost:8080/jnlpJars/agent.jar
gnome-terminal -- bash -c java -jar agent.jar -url http://localhost:8080/ -secret "$SECRET" -name "java-agent" -webSocket
 
echo "creating python node .."
cat > node.xml <<EOF
<slave>
  <name>${PYTHON_NODE}</name>
  <remoteFS>${BASE_DIR}</remoteFS>
  <numExecutors>2</numExecutors>
  <label>${LABEL}</label>
  <mode>${MODE}</mode>
  <launcher class="hudson.slaves.JNLPLauncher"/>
  <retentionStrategy class="hudson.slaves.RetentionStrategy\$Always"/>
</slave>
EOF
SECRET=$(java -jar "$CLI_JAR" -s "$JENKINS_URL" -auth "$USERNAME:$API_TOKEN" groovy = <<EOF
import jenkins.model.*
def node = Jenkins.instance.getNode("$PYTHON_NODE")
println node?.computer?.jnlpMac
EOF
)

java -jar "$CLI_JAR" -s "$JENKINS_URL" -auth "$USERNAME:$API_TOKEN" get-node "$PYTHON_NODE" >/dev/null 2>&1 || \
java -jar "$CLI_JAR" -s "$JENKINS_URL" -auth "$USERNAME:$API_TOKEN" create-node "$PYTHON_NODE" < node.xml
echo "Fetched JNLP secret: $SECRET"
curl -sO http://localhost:8080/jnlpJars/agent.jar
gnome-terminal -- bash -c java -jar agent.jar -url http://localhost:8080/ -secret "$SECRET" -name "python-agent" -webSocket


echo "creating nodejs node"
cat > node.xml <<EOF
<slave>
  <name>${NODEJS_NODE}</name>
   <remoteFS>${BASE_DIR}</remoteFS>
  <numExecutors>2</numExecutors>
  <label>${LABEL}</label>
  <mode>${MODE}</mode>
  <launcher class="hudson.slaves.JNLPLauncher"/>
  <retentionStrategy class="hudson.slaves.RetentionStrategy\$Always"/>
</slave>
EOF
java -jar "$CLI_JAR" -s "$JENKINS_URL" -auth "$USERNAME:$API_TOKEN" get-node "$NODEJS_NODE">/dev/null 2>&1 || \
java -jar "$CLI_JAR" -s "$JENKINS_URL" -auth "$USERNAME:$API_TOKEN" create-node "$NODEJS_NODE" < node.xml
# -----------------------------
# Fetch agent secret
SECRET=$(java -jar "$CLI_JAR" -s "$JENKINS_URL" -auth "$USERNAME:$API_TOKEN" groovy = <<EOF
import jenkins.model.*
def node = Jenkins.instance.getNode("$NODEJS_NODE")
println node?.computer?.jnlpMac
EOF
)

echo "Fetched JNLP secret: $SECRET"
curl -sO http://localhost:8080/jnlpJars/agent.jar
gnome-terminal -- bash -c java -jar agent.jar -url http://localhost:8080/ -secret "$SECRET" -name "nodejs-agent" -webSocket
     