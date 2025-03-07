resource "aws_security_group" "dlr_alb_sg" {
  name_prefix = "dlr-alb-sg-"
  description = "Allow HTTP and HTTPS traffic for ALB"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = {
    Name = "dlr-alb-security-group"
  }
}

resource "aws_lb" "dlr_alb" {
  name               = "dlr-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.dlr_alb_sg.id]
  subnets            = var.public_subnets

  enable_deletion_protection = false

  tags = {
    Name = "dlr-alb"
  }
}

resource "aws_lb_target_group" "server1" {
  name     = "tg-dlr-server1"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    interval            = 30
    timeout             = 5
    unhealthy_threshold = 3
    healthy_threshold   = 5
  }

  tags = {
    Name = "tg-dlr-server1"
  }
}

resource "aws_lb_target_group" "server2" {
  name     = "tg-dlr-server2"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    interval            = 30
    timeout             = 5
    unhealthy_threshold = 3
    healthy_threshold   = 5
  }

  tags = {
    Name = "tg-dlr-server2"
  }
}

resource "aws_lb_target_group" "interview" {
  name     = "tg-dlr-interview"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    interval            = 30
    timeout             = 5
    unhealthy_threshold = 3
    healthy_threshold   = 5
  }

  tags = {
    Name = "tg-dlr-interview"
  }
}

resource "aws_lb_target_group_attachment" "server1" {
  target_group_arn = aws_lb_target_group.server1.arn
  target_id        = element(var.instance_ids, 0)
  port             = 80
}

resource "aws_lb_target_group_attachment" "server2" {
  target_group_arn = aws_lb_target_group.server2.arn
  target_id        = element(var.instance_ids, 1)
  port             = 80
}

resource "aws_lb_target_group_attachment" "interview" {
  target_group_arn = aws_lb_target_group.interview.arn
  target_id        = element(var.instance_ids, 2)
  port             = 80
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.dlr_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "Not Found"
      status_code  = "404"
    }
  }
}

resource "aws_lb_listener_rule" "server1_rule" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 10

  condition {
    path_pattern {
      values = ["/server1*"]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.server1.arn
  }
}

resource "aws_lb_listener_rule" "server2_rule" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 20

  condition {
    path_pattern {
      values = ["/server2*"]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.server2.arn
  }
}

resource "aws_lb_listener_rule" "interview_rule" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 30

  condition {
    path_pattern {
      values = ["/interview*"]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.interview.arn
  }
}
