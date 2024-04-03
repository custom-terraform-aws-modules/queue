provider "aws" {
  region = "eu-central-1"
  default_tags {
    tags = {
      Environment = "Test"
    }
  }
}

run "invalid_identifier" {
  command = plan

  variables {
    identifier = "ab"
  }

  expect_failures = [var.identifier]
}

run "valid_identifier" {
  command = plan

  variables {
    identifier = "abc"
  }
}

run "with_deadletter" {
  command = plan

  variables {
    identifier        = "abc"
    max_receive_count = 4
  }

  assert {
    condition     = length(aws_sqs_queue.deadletter) == 1
    error_message = "Deadletter queue was not created"
  }

  assert {
    condition     = length(aws_sqs_queue_redrive_allow_policy.main) == 1
    error_message = "Redrive allow policy was not created"
  }
}

run "without_deadletter" {
  command = plan

  variables {
    identifier        = "abc"
    max_receive_count = 0
  }

  assert {
    condition     = length(aws_sqs_queue.deadletter) == 0
    error_message = "Deadletter queue was created unexpectedly"
  }

  assert {
    condition     = length(aws_sqs_queue_redrive_allow_policy.main) == 0
    error_message = "Redrive allow policy was created unexpectedly"
  }
}
