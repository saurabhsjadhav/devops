provider "aws" {
    region = "us-east-1"
  
}
resource "aws_instance" "myec2" {
    ami = "ami-0cafb04477a984411"
    key_name = "devopskey"
    instance_type = "t2.micro"
    security_groups = ["mysecuritygroup"]
    tags = {
      Nmae = "Spiderma_instance"
    }
  
}