resource "aws_iam_policy" "sqs_policy" {
  name        = "sqs-policy"
  description = "Policy to allow access to multiple SQS queues"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "sqs:SendMessage",
          "sqs:ReceiveMessage",
          "sqs:DeleteMessage",
          "sqs:GetQueueAttributes",
          "sqs:GetQueueUrl"
        ]
        Resource = var.sqs_queue_arns
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "sqs_policy_attachment" {
  # role       = var.eks_node_role_name
  role       = aws_iam_role.eks_node_role.name
  policy_arn = aws_iam_policy.sqs_policy.arn
}