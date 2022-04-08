resource "aws_cloudwatch_event_rule" "guardduty" {
  name        = "guardduty-events"
  description = "GuardDutyEvent"
#   is_enabled  = var.guardduty_enabled
#   tags        = var.tags

  event_pattern = <<PATTERN
{
  "source": [
    "aws.guardduty"
  ],
  "detail-type": [
    "GuardDuty Finding"
  ]
}
PATTERN
}

resource "aws_cloudwatch_event_target" "guardduty" {
  rule      = aws_cloudwatch_event_rule.guardduty.name
  target_id = "SendToSNS"
  arn       = var.notification_arn
}