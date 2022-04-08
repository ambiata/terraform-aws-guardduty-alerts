resource "aws_cloudwatch_event_rule" "guardduty" {
  count = var.alarm_sns == "" ? 0 : 1
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
  count = var.alarm_sns == "" ? 0 : 1
  rule      = aws_cloudwatch_event_rule.guardduty.name
  target_id = "SendToSNS"
  arn       = aws_sns_topic.default.arn
}



