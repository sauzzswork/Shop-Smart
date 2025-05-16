# backend.tf
terraform {
  backend "s3" {
    bucket         = "shopsmart-terraform-state-akash"   # Replace with your bucket name
    key            = "terraform.tfstate"            # The path to the state file within the bucket
    region         = "ap-southeast-1"                    # Replace with your bucket region
    dynamodb_table = "terraform-state-lock-aakash"         # Optional: Replace with your DynamoDB table name for locking
    encrypt        = true                            # Enable server-side encryption
  }
}
