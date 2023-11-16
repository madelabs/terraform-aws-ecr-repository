# enable scan outputs -> event rule -> event target -> sns topic -> sns topic policy -> sns topic subscription
# enable scan findings -> event rule -> event target -> sns topic -> sns topic policy -> sns topic subscription

resource "aws_cloudwatch_event_rule" "event_rule" {
  count = var.ecr_enable_enhanced_scanning_alerts ? 1 : 0
  name  = "${var.ecr_repo_name}-scan-finding-events"
  event_pattern = jsonencode({
    "source"      = ["aws.inspector2"],
    "detail-type" = ["Inspector2 Scan"],

    "detail" = {
      "repository-name" = ["${aws_ecr_repository.ecr_repo.arn}"]
    }
  })
}

resource "aws_cloudwatch_event_target" "event_target" {
  count     = var.ecr_enable_enhanced_scanning_alerts ? 1 : 0
  rule      = aws_cloudwatch_event_rule.event_rule[0].name
  target_id = "${var.ecr_repo_name}-scan-finding-events"
  arn       = aws_sns_topic.sns_topic[0].arn
}

resource "aws_sns_topic" "sns_topic" {
  count = var.ecr_enable_enhanced_scanning_alerts ? 1 : 0
  name  = "${var.ecr_repo_name}-scan-finding-events"
}

resource "aws_sns_topic_policy" "topic_policy" {
  count  = var.ecr_enable_enhanced_scanning_alerts ? 1 : 0
  arn    = aws_sns_topic.sns_topic[0].arn
  policy = data.aws_iam_policy_document.topic_policy_document[0].json
}

data "aws_iam_policy_document" "topic_policy_document" {
  count = var.ecr_enable_enhanced_scanning_alerts ? 1 : 0
  statement {
    effect  = "Allow"
    actions = ["SNS:Publish"]

    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }

    resources = [aws_sns_topic.sns_topic[0].arn]
  }
}

resource "aws_sns_topic_subscription" "topic_subscription" {
  count     = var.ecr_enable_enhanced_scanning_alerts ? 1 : 0
  topic_arn = aws_sns_topic.sns_topic[0].arn
  protocol  = var.ecr_scanning_events_sns_topic_subscription_protocol
  endpoint  = var.ecr_scanning_events_sns_topic_subscription_endpoint
}
