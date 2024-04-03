variable "identifier" {
  description = "Unique identifier to differentiate global resources."
  type        = string
  validation {
    condition     = length(var.identifier) > 2
    error_message = "Identifier must be at least 3 characters"
  }
}

variable "message_retention_seconds" {
  description = "The number of seconds Amazon SQS retains a message. Integer representing seconds, from 60 (1 minute) to 1209600 (14 days)."
  type        = number
  default     = 345600
}

variable "visibility_timeout_seconds" {
  description = "The visibility timeout for messages in the queue. An integer from 0 to 43200 (12 hours)."
  type        = number
  default     = 300
}

variable "max_receive_count" {
  description = "Specifies how many times the same message can be received before moved into the deadletter queue. Value '0' does not create a deadletter for the queue and the queue will retry infinitely."
  type        = number
  default     = 0
}

variable "tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
  default     = {}
}
