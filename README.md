# AWS SCP and Tag Policy Deployment

This project sets up AWS Service Control Policies (SCPs) and Tag Policies using Terraform. The policies enforce tagging standards (`TeamName` and `ManagedBy`) and restrict the creation of certain AWS resources if those tags are missing.

## Overview

- Enforces required tagging on key AWS services (e.g., EC2, Lambda, S3, RDS).
- Uses SCPs to deny resource creation without the required tags.
- Includes optional Tag Policy for enforcing tag key presence across accounts.
- Designed for use with AWS Organizations and AWS SSO via GitHub Actions.
- Built with modular Terraform code for reusable deployment.

## Requirements

- Terraform CLI installed (recommended version: 1.6.6+)
- AWS account with Organizations enabled
- Management account permissions to create and attach policies
  - SCP's don't apply to management account, must have other accounts in organization to apply policies to
- GitHub Actions configured with AWS OIDC role for deployment


## Usage

- Clone the repository
- Update the SCP and Tag Policy JSON files as needed
- Set `root_target_id` and `member_target_id` in `spcs.tf` to the correct Org Root or OU ID, and member account ID

### Running Locally

- Run `terraform init`
- Run `terraform plan`
- Run `terraform apply`

### Running via GitHub Actions

- Ensure the IAM role trust policy matches your GitHub repo and branch
- Commit changes to the `main` branch or manually trigger the workflow
- GitHub Actions will authenticate using AWS OIDC and apply Terraform

