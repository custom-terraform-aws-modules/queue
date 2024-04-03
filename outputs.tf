output "arn" {
  description = "The ARN of the SQS queue."
  value       = try(aws_sqs_queue.main.arn, null)
}

output "url" {
  description = "The URL of the SQS queue."
  value       = try(aws_sqs_queue.main.url, null)
}

output "deadletter_arn" {
  description = "The ARN of the deadletter SQS queue of the main queue."
  value       = try(aws_sqs_queue.deadletter[0].url, null)
}

output "deadletter_url" {
  description = "The URL of the deadletter SQS queue of the main queue."
  value       = try(aws_sqs_queue.deadletter[0].url, null)
}
