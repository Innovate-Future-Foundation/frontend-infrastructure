terraform {
  backend "s3" {
    bucket         = "inff-frontend-infrastructure-tfstate-melj2"  
    key            = "dev/terraform.tfstate"
    region         = "ap-southeast-2"
    dynamodb_table = "inff-frontend-infrastructure-tflock"       
    encrypt        = true
  }
}