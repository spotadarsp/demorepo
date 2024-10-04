terraform {
  backend "s3" {
    bucket         = "testbucket-vegapeojce"
    key            = "dev/terraform.tfstate"
    region         = "ap-south-1"
  }
}
