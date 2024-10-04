# provider "aws" {
#     region = "ap-south-1"
#     profile = "shubham"
# }

provider "aws" {
  region     = "ap-south-1"  # Specify your desired AWS region
 shared_credentials_files = ["C:/Users/spota/.aws/credentials"]
}
