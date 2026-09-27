resource "aws_organizations_policy" "scp" {
  name        = var.policy_name
  description = "Deny creating resources without required tags"
  type        = "SERVICE_CONTROL_POLICY"

  content = file(var.policy_path)
}

resource "aws_organizations_policy_attachment" "attachment" {
  policy_id = aws_organizations_policy.scp.id
  target_id = var.root_target_id
}

resource "aws_organizations_policy_attachment" "member_attachment" {
  policy_id = aws_organizations_policy.scp.id
  target_id = var.member_target_id
}

resource "aws_organizations_policy" "tag_policy" {
  name        = "EnforceTagValues"
  description = "Org Tag Policy for TeamName and ManagedBy"
  type        = "TAG_POLICY"
  content     = file(var.tag_policy_path) 
}

resource "aws_organizations_policy_attachment" "tag_policy_attachment" {
  policy_id = aws_organizations_policy.tag_policy.id
  target_id = var.root_target_id
}

resource "aws_organizations_policy_attachment" "member_tag_policy_attachment" {
  policy_id = aws_organizations_policy.tag_policy.id
  target_id = var.member_target_id
}