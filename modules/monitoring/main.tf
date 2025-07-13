resource "aws_security_group" "monitoring_sg" {
  name        = "${var.name_prefix}-monitoring-sg"
  description = "Allow HTTP access to Grafana"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Para teste. Depois, restrinja.
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # SSH aberto para qualquer IP (teste)
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "monitoring" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = element(var.subnet_ids, 0)
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.monitoring_sg.id]

  user_data = templatefile("${path.module}/user_data.sh.tpl", {
  grafana_admin_password = var.grafana_admin_password,
  PROM_VERSION = "2.47.0"  # ou a versão que você usa no seu script
})

  tags = {
    Name = "${var.name_prefix}-monitoring"
  }
}

resource "aws_lb" "monitoring_alb" {
  name               = "${var.name_prefix}-monitoring-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.monitoring_sg.id]
  subnets            = var.subnet_ids
}

resource "aws_lb_target_group" "monitoring_tg" {
  name     = "${var.name_prefix}-monitoring-tg"
  port     = 3000
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_listener" "monitoring_listener" {
  load_balancer_arn = aws_lb.monitoring_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.monitoring_tg.arn
  }
}

resource "aws_lb_target_group_attachment" "monitoring_attachment" {
  target_group_arn = aws_lb_target_group.monitoring_tg.arn
  target_id        = aws_instance.monitoring.id
  port             = 3000
}