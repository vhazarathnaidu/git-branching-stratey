import jenkins.model.*
import hudson.security.*
import jenkins.security.s2m.AdminWhitelistRule

def instance = Jenkins.getInstance()

def username = "jenkins"
def password = "jenkins"

// Get security realm
def hudsonRealm = instance.getSecurityRealm()

// Check if user already exists
def user = hudson.model.User.getById(username, false)

// Create user
hudsonRealm.createAccount(username, password)
println "User created: ${username}"

// Setup authorization strategy (Full control once logged in OR matrix-based)
def strategy = new GlobalMatrixAuthorizationStrategy()

// Grant all permissions to admin user
strategy.add(Jenkins.ADMINISTER, username)

instance.setAuthorizationStrategy(strategy)

// Save Jenkins config
instance.save()

    