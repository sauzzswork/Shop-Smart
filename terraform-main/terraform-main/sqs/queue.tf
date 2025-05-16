resource "aws_sqs_queue" "order_notifications_queue" {
  name = "order-notifications-queue"
}

resource "aws_sqs_queue" "profile_notifications_queue" {
  name = "profile-notifications-queue"
}