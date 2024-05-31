resource "aws_instance" "web" {
  ami           = "ami-0f3c7d07486cad139"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.roboshop_aws.id]

  tags = {
    Name = "provisioner"
  }

  provisioner "local-exec" {
    command = "echo ${self.private_ip} > inventory"
  }

#   provisioner "local-exec" {
#     command = "echo .. we can integrate ansible here , this will be parsed as an input to ansible"
#   }

connection {
    type     = "ssh"
    user     = "centos"
    password = "DevOps321"
    host     = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'this is example of remote exec' > /tmp/remote.txt",
      "sudo yum install nginx -y",
      "sudo systemctl start nginx" 
    ]
  }

}

resource "aws_security_group" "roboshop_aws" {  # name here for terraform reference
  name        = "provisioner"        #name here for aws reference
  description = "provisioner remote ecex"
  #vpc_id      = aws_vpc.main.id

  ingress {
    description      ="Allow all ports"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    #ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      ="Allow all ports"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    #ipv6_cidr_blocks = ["::/0"]
  }

   egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    #ipv6_cidr_blocks = ["::/0"]
  }

   tags = {
    Name = "provisioner"
  }

   

}