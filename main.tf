################################
# SQS Queue                    #
################################

resource "aws_sqs_queue" "deadletter" {
  count = var.max_receive_count > 0 ? 1 : 0
  name  = "${var.identifier}-deadletter"

  tags = var.tags
}

resource "aws_sqs_queue" "main" {
  name                       = var.identifier
  message_retention_seconds  = var.message_retention_seconds
  visibility_timeout_seconds = var.visibility_timeout_seconds

  redrive_policy = var.max_receive_count > 0 ? jsonencode({
    deadLetterTargetArn = aws_sqs_queue.deadletter[0].arn
    maxReceiveCount     = var.max_receive_count
  }) : null

  tags = var.tags
}

resource "aws_sqs_queue_redrive_allow_policy" "main" {
  count     = var.max_receive_count > 0 ? 1 : 0
  queue_url = aws_sqs_queue.deadletter[0].id

  redrive_allow_policy = jsonencode({
    redrivePermission = "byQueue",
    sourceQueueArns   = [aws_sqs_queue.main.arn]
  })
}
