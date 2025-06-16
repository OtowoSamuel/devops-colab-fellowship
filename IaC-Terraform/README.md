# Terraform EC2 and S3 Infrastructure

This Terraform configuration provisions an EC2 instance and an S3 bucket on AWS with the following components:

## Resources Created

### EC2 Instance
- **Amazon Linux 2** EC2 instance
- **Apache HTTP Server** automatically installed and configured
- **Security Group** with SSH (22), HTTP (80), and HTTPS (443) access
- **Public IP** for internet access
- **Key Pair** authentication for SSH access

### S3 Bucket
- **S3 Bucket** with unique naming
- **Versioning** enabled
- **Server-side encryption** with AES256
- **Public access blocked** for security

### Networking
- **VPC** with custom CIDR block (10.0.0.0/16)
- **Internet Gateway** for internet access
- **Public Subnet** for EC2 instance
- **Route Table** with proper routing

## Prerequisites

1. **AWS CLI** configured with appropriate credentials
2. **Terraform** installed (version >= 1.0)
3. **AWS Key Pair** created in the target region

## Setup Instructions

1. **Clone or download** this configuration
2. **Create AWS Key Pair** in AWS Console (EC2 → Key Pairs)
3. **Copy the example variables file**:
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   ```
4. **Edit terraform.tfvars** with your values:
   - Set your `key_pair_name` (created in step 2)
   - Adjust `aws_region` if needed
   - Customize `project_name` and other variables

## Deployment Commands

```bash
# Initialize Terraform
terraform init

# Plan the deployment (review changes)
terraform plan

# Apply the configuration
terraform apply

# View outputs
terraform output

# Destroy resources when done
terraform destroy
```

## Accessing Your Resources

### EC2 Instance
After deployment, you can:
- **SSH into the instance**: Use the command shown in the `ssh_connection_command` output
- **Access the web server**: Visit the URL shown in the `web_url` output
- **View in AWS Console**: Check EC2 dashboard for your instance

### S3 Bucket
- **Bucket name**: Available in the `s3_bucket_name` output
- **AWS Console**: View in S3 service dashboard
- **AWS CLI**: Use `aws s3 ls s3://your-bucket-name`

## Variables

| Variable | Description | Default | Required |
|----------|-------------|---------|----------|
| `aws_region` | AWS region for resources | `us-east-1` | No |
| `project_name` | Project name for resource naming | `terraform-demo` | No |
| `environment` | Environment name | `dev` | No |
| `instance_type` | EC2 instance type | `t2.micro` | No |
| `key_pair_name` | AWS key pair name | `""` | **Yes** |

## Outputs

- `ec2_instance_id`: EC2 instance ID
- `ec2_public_ip`: Public IP address
- `ec2_public_dns`: Public DNS name
- `s3_bucket_name`: S3 bucket name
- `s3_bucket_arn`: S3 bucket ARN
- `vpc_id`: VPC ID
- `ssh_connection_command`: SSH command to connect
- `web_url`: Web server URL

## Security Considerations

- **Key Pair**: Ensure your private key file has proper permissions (chmod 400)
- **Security Group**: SSH access is open to 0.0.0.0/0 - consider restricting to your IP
- **S3 Bucket**: Public access is blocked by default
- **HTTPS**: Consider adding SSL/TLS certificate for production use

## Cost Considerations

- **t2.micro**: Eligible for AWS Free Tier
- **S3**: Pay for storage and requests
- **Data Transfer**: Charges may apply for data transfer

## Cleanup

To avoid ongoing charges, destroy the resources when no longer needed:
```bash
terraform destroy
```

## Troubleshooting

1. **Key Pair Error**: Ensure the key pair exists in the specified region
2. **Permission Denied**: Check AWS credentials and IAM permissions
3. **SSH Connection**: Verify security group rules and key file permissions
4. **S3 Bucket Name**: Bucket names must be globally unique (handled automatically)
