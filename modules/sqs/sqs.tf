resource "aws_sqs_queue" "this" {
  name = var.sqs_name
}

resource "aws_sqs_queue" "dead_letter" {
  name = var.sqs_dead_letter_name
}