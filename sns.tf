# SNS Topic
resource "aws_sns_topic" "sns_topic" {
  name = "MyServerMonitor"
}

# SNS Subscription with Email Endpoint
resource "aws_sns_topic_subscription" "sns_email" {
  topic_arn = aws_sns_topic.sns_topic.arn
  protocol  = "email"
  endpoint  = var.mail
}

# CloudWatch Event Rule to monitor EC2 instance state changes
resource "aws_cloudwatch_event_rule" "ec2_state_change" {
  name        = "MyEC2StateChangeEvent"
  description = "Trigger SNS notification on EC2 instance state change"
  event_pattern = jsonencode({
    "source"       : ["aws.ec2"],
    "detail-type"  : ["EC2 Instance State-change Notification"],
    "detail"       : {
      "instance-id" : [aws_instance.MyEC2ServerAYY.id]
    }
  })
}

# CloudWatch Event Target pointing to SNS Topic
resource "aws_cloudwatch_event_target" "sns_target" {
  rule      = aws_cloudwatch_event_rule.ec2_state_change.name
  target_id = "SendToSNS"
  arn       = aws_sns_topic.sns_topic.arn
}

resource "aws_sns_topic_policy" "sns_topic_policy" {
  arn    = aws_sns_topic.sns_topic.arn
  policy = jsonencode({
    Version = "2008-10-17",
    Id      = "__default_policy_ID",
    Statement = [
      {
        Sid       = "__default_statement_ID",
        Effect    = "Allow",
        Principal = { "AWS" : "*" },
        Action    = [
          "SNS:GetTopicAttributes",
          "SNS:SetTopicAttributes",
          "SNS:AddPermission",
          "SNS:RemovePermission",
          "SNS:DeleteTopic",
          "SNS:Subscribe",
          "SNS:ListSubscriptionsByTopic",
          "SNS:Publish"
        ],
        Resource  = aws_sns_topic.sns_topic.arn,
        Condition = {
          StringEquals = {
            "AWS:SourceOwner" = data.aws_caller_identity.current.account_id
          }
        }
      },
      {
        Sid       = "AllowEventBridgeToPublish",
        Effect    = "Allow",
        Principal = { Service = "events.amazonaws.com" },
        Action    = "sns:Publish",
        Resource  = aws_sns_topic.sns_topic.arn
      }
    ]
  })
}
