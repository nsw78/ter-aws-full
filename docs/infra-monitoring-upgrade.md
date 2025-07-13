# Infraestrutura Aprimorada com Monitoramento e Auto Scaling

## 📌 Visão Geral

Essa nova versão da infraestrutura define um conjunto completo de recursos usando módulos Terraform modulares e reutilizáveis. O foco principal é:

- Escalabilidade com Auto Scaling Group (ASG)
- Monitoramento com Grafana + Prometheus
- Exposição via Application Load Balancer (ALB)
- Organização por módulos e uso de boas práticas

---

## ✅ Alterações Realizadas

### 🔧 Novos Módulos

- `modules/autoscaling`: Cria ASG com Launch Template e ALB opcional
- `modules/monitoring`: Instância EC2 com Grafana + Prometheus, com ALB público
- `modules/iam`: (opcional) Pode ser usado para criar o Instance Profile necessário

### 📦 Estrutura Modular Atualizada

```bash
terraform-aws-demo/
├── modules/
│   ├── autoscaling/
│   ├── ec2/
│   ├── monitoring/
│   ├── s3/
│   ├── vpc/
├── environments/
│   └── dev/
│       ├── main.tf
│       ├── terraform.tfvars
│       ├── variables.tf
│       └── outputs.tf