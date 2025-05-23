variable "alert_email" {
  description = "Pull of emails for scaling up alarms"
  type = list(string)
  default = []
}

variable "environment" {
  description = "Work environment name e.g dev/production"
  type = string
}
