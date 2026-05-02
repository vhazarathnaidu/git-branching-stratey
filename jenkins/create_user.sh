ADMIN_USER="admin"

# Read initial admin password
ADMIN_PASS=$(cat /var/lib/jenkins/secrets/initialAdminPassword)

java -jar "jenkins-cli.jar" -s "http://localhost:8080" -auth $ADMIN_USER:$ADMIN_PASS groovy = < create_jenkins_user.groovy