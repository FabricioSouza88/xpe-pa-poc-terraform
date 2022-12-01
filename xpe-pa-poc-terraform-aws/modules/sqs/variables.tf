variable "sqs_queue_name" {
  description = "SQS queue name"
  type        = string
  sensitive   = true
  default = "default_queue"
}