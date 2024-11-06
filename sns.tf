# SNS Topic
resource "aws_sns_topic" "sns_topic" {
  name = "MyServerMonitor"
}

# SNS Subscription with Email Endpoint
resource "aws_sns_topic_subscription" "sns_email" {
  topic_arn = aws_sns_topic.sns_topic.arn
  protocol  = "email"
  endpoint  = "zlahcene1@myges.fr"
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


resource "aws_cloudwatch_event_target" "sns_target_role_attachment" {
  rule      = aws_cloudwatch_event_rule.ec2_state_change.name
  target_id = "SendToSNS"
  arn       = aws_sns_topic.sns_topic.arn
  //role_arn  = data.aws_iam_role.role_cloudwatch_cloudtrail.arn
  // aws_iam_role.eventbridge_publish_role.arn
}
