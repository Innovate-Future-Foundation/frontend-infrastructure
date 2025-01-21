terraform {
  backend "s3" {
    bucket         = "inff-frontend-infrastructure-tfstate-xxxxx" # todo
    key            = "dev/terraform.tfstate"
    region         = "ap-southeast-2"  
    dynamodb_table = "inff-frontend-infrastructure-tflock"# todo
    encrypt        = true
  }
}