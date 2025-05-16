output "order_notifications_queue_arn"{
    description = "The ARN of the order notifications queue"
    value = aws_sqs_queue.order_notifications_queue.arn
}

output "profile_notifications_queue_arn"{
    description = "The ARN of the profile notifications queue"
    value = aws_sqs_queue.profile_notifications_queue.arn
}