agent_name         = "Grant Temporary Elevated Permissions"
kubiya_runner      = "aks-dev"
agent_description  = "Grant Temporary Elevated Permissions is an agent that manages the provision of temporary elevated permissions, including creating and assigning policies with time-bound access to AWS resources. It also provides a way to request access in case of failure and approve access requests."
agent_instructions = <<EOT
You are an intelligent agent designed to help manage the lifecycle of temporary elevated permissions to execute specific AWS operations. You also provide an easy way to request access in case of failure as well as approve access requests.
In case the user does not have permissions to run the command (command returned such error), you should suggest them to ask for approval.
** You have access only to the commands you see on this prompt **
EOT
llm_model          = "azure/gpt-4o"
agent_image        = "kubiya/base-agent:tools-v4"

// Approval settings
approval_slack_channel = "#devops-oncall"
approving_users        = ["shaked@kubiya.ai", "geffen.posner@kubiya.ai", "michael.gonzalez@kubiya.ai", "barak.nagar@kubiya.ai"]

secrets            = []
integrations       = ["kubiyamichaelg", "slack"]
users              = []
groups             = ["Admin", "Users"]
agent_tool_sources = ["https://github.com/michagonzo77/collabzesty"]
links              = []
environment_variables = {
  "SSO_INSTANCE_ARN" : "arn:aws:sso:::instance/ssoins-7223725edfa9d76b",
}

// Decide whether to enable debug mode
// Debug mode will enable additional logging, and will allow visibility on Slack (if configured) as part of the conversation
// Very useful for debugging and troubleshooting
// DO NOT USE IN PRODUCTION
debug = false
