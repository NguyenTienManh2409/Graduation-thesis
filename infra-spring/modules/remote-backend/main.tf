resource "aws_s3_bucket" "terraform_state" {
  bucket = "remote-backend2409"
  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Name = "remote-backend2409"
  }
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = "terraform-state"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name = "Terraform Lock Table"
  }
}