terraform {
  required_providers {
    kubiya = {
      source = "kubiya-terraform/kubiya"
    }
  }
}

provider "kubiya" {
  // Your Kubiya API Key will be taken from the
  // environment variable KUBIYA_API_KEY
  // To set the key, please use export KUBIYA_API_KEY="YOUR_API_KEY"
}

resource "kubiya_agent" "agent" {
  // Mandatory Fields
  name         = "Grant Temporary Elevated Permissions" // String
  runner       = "nats"                              // String
  description  = <<EOT
Grant Temporary Elevated Permissions is an agent that manages the provision of temporary elevated permissions, including creating and assigning policies with time-bound access to AWS resources.
EOT
  instructions = <<EOT
You are an intelligent agent designed to help managing the lifecycle of temporary elevated permissions to execute specific AWS operations. You also provide an easy to way to request access in case of failure as well as approve access requests.
In case the user does not have permissions to run the command (command returned such error) - you should suggest them to ask for approval.
** You have access only to the commands you see on this prompt **
EOT
  // Optional fields, String
  model = "azure/gpt-4o" // If not provided, Defaults to "azure/gpt-4"
  // If not provided, Defaults to "ghcr.io/kubiyabot/kubiya-agent:stable"
  image = "kubiya/base-agent:tools-v4"

  // Optional Fields:
  // Arrays
  secrets      = []
  integrations = ["kubiyamichaelg", "slack"]
  users        = []
  groups       = ["Admin", "Users"]
  links        = []
  environment_variables = {
    DEBUG                   = "1"
    KUBIYA_DEBUG            = "1"
    LOG_LEVEL               = "INFO"
    KUBIYA_TOOL_CONFIG_URLS = "https://github.com/michagonzo77/collabzesty"
    TOOLS_MANAGER_URL       = "http://localhost:3001"
    TOOLS_SERVER_URL        = "http://localhost:3001"
    TOOL_MANAGER_LOG_FILE   = "/tmp/tool-manager.log"
    TOOL_SERVER_URL         = "http://localhost:3001"
    SSO_INSTANCE_ARN        = "arn:aws:sso:::instance/ssoins-7223725edfa9d76b"
    SCHEDULE_TASK           = "1"
    APPROVING_USERS         = "kubiyamg@gmail.com"
    APPROVAL_SLACK_CHANNEL  = "#testing"
    DAGGER_CLOUD_TOKEN      = "dag_michael-test_pnViL4yQh426WuAnaDAvhFe2yubGtG3qhc7WmA3HXr8"
  }
}

output "agent" {
  value = kubiya_agent.agent
}