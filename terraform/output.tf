output "role_arn" {
  description = "Role ARN for AWS Data Protection Controller"
  value       = aws_iam_role.controller.arn
}
