provider "aws" {
 region = "ap-south-1"
 access_key = AKIARDOUVHEA3PVWKGM2
 secret_key = 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
  }
variable "BuildAMI" {
 description = "Build Server AMI"
 default = "ami-"
  }
variable "BuildType" {
 description ="Buld Server Type"
 default ="t2.micro"
  }
variable "BuildKey" {
 description ="Build Server Key"
 default = "test"
  }
variable "BuildUser" {
 description = "Build User"
 default ="ubuntu"
  }
  
resource "aws_instance" "example" {
 ami            = var.BuildAMI
 instance_type  = var.BuildType
 key_name       = var.BuildKey
 
 provisioner "local-exec" {
   command = "export ANSIBLE_HOST_KEY_CHECKING=False;sleep 30; ansible-playbook buildsetup.yml-i ${aws_instance.example.private_ip}, -u ${var.BuildUser} --key-file /etc/ansible/${var.BuildKey}.pem"
  }
}
