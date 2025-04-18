data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_launch_template" "web_template" {
  name_prefix   = "lt-web-"
  image_id      = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"
  key_name      = var.key_name

  # AGORA usa o SG público
  vpc_security_group_ids = [var.sg_public_ec2]

  user_data = filebase64("${path.module}/docker.sh")

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name    = "ec2-public-instance"
      Aluno   = var.Aluno
      Periodo = var.Periodo
    }
  }
}

resource "aws_autoscaling_group" "web_asg" {
  desired_capacity    = 1
  max_size            = 2
  min_size            = 1
  vpc_zone_identifier = [var.subnet_public_id]
  target_group_arns   = var.target_group_arns
  health_check_type   = "EC2"

  launch_template {
    id      = aws_launch_template.web_template.id
    version = "$Latest"
  }

  tag {
    key                 = "aluno"
    value               = var.Aluno
    propagate_at_launch = true
  }

  tag {
    key                 = "periodo"
    value               = var.Periodo
    propagate_at_launch = true
  }

  tag {
    key                 = "Name"
    value               = "ec2-public-instance"
    propagate_at_launch = true
  }
}