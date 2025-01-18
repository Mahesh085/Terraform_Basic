resource "aws_launch_template" "mylt" {
  tags = {
    Name = var.launch_template_name
  }
  description = var.launch_temp_description
  image_id = var.LT_image_id
  instance_type = var.launch_template_instance_type
  key_name = var.LP_key_name
  vpc_security_group_ids = var.LP_security_group
  placement {
    availability_zone = "us-east-1a"
  }
  user_data = base64encode(<<-EOF
  #!/bin/bash
  sudo yum update -y
  sudo yum install httpd -y
  sudo systemctl start httpd
  sudo systemctl enable httpd
  sudo chmod 766 /var/www/html/index.html
  echo "<html><body><h1>Welcome</h1></body></html>" > /var/www/html/index.html
  EOF
  )
}
output launch_template_id {
  value = aws_launch_template.mylt.id
  
}

