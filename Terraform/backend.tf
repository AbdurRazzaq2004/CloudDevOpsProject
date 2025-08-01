terraform {
  backend "s3" {
    bucket         = "terraform-lock-ivolve"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    //dynamodb_table = "table-lock-terraform"
  }
}