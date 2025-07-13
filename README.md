**Terraform AWS**, cobrindo todos os módulos (EC2, Auto Scaling, IAM, Monitoring), os scripts de instalação, uso do `terraform.tfvars`, pipeline ECR, além de dicas de como rodar o projeto com segurança para evitar custos desnecessários:

---

````markdown
# 🚀 Projeto Terraform AWS - Infraestrutura Completa na AWS

Este repositório contém uma infraestrutura completa provisionada na AWS utilizando Terraform. O projeto é modularizado, focado em boas práticas de automação e escalabilidade, incluindo:

- EC2 (instância para API)
- Auto Scaling Group (com Launch Template)
- IAM Roles e Instance Profile
- Monitoring (Prometheus e Grafana via EC2)
- Balanceadores de carga (ALB)
- Scripts de bootstrap com `user_data`
- Pipeline de deploy para Docker (ECR)

---

## 📁 Estrutura do Projeto

```bash
terraform-aws-demo/
├── environments/
│   └── dev/
│       ├── main.tf
│       ├── variables.tf
│       ├── terraform.tfvars
├── modules/
│   ├── ec2/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   ├── autoscaling/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   ├── iam/
│   │   ├── main.tf
│   │   └── outputs.tf
│   ├── monitoring/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── user_data.sh.tpl
│   │   └── outputs.tf
├── docs/
│   └── README.md (este arquivo)
````

---

## ⚙️ Pré-requisitos

* [x] Conta AWS (preferencialmente dentro do Free Tier)
* [x] [Terraform](https://developer.hashicorp.com/terraform/downloads)
* [x] [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)
* [x] [Docker](https://docs.docker.com/engine/install/) (opcional para build da imagem da API)
* [x] Chave PEM da AWS salva localmente (`xxxxxxxxxxxx.pem` ou outro nome)

---

## 📦 Instalação (Linux/macOS/WSL)

```bash
# Instalar Terraform (caso não tenha)
curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list
apt update && apt install terraform -y

# Instalar AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip && sudo ./aws/install

# Configurar AWS
aws configure
```

---

## 🧠 Sobre os Módulos

### ✅ `ec2/`

* Cria uma instância EC2 com segurança via SG
* Ideal para deploy inicial ou instância única da API
* Inclui chave SSH e SG com porta 22

### ✅ `autoscaling/`

* Cria Launch Template com `user_data.sh.tpl`
* Auto Scaling Group com ALB
* SG controlado por variável
* Permite escalar horizontalmente a API

### ✅ `monitoring/`

* EC2 com Prometheus + Grafana instalados via `user_data.sh.tpl`
* ALB configurado com porta 3000 (Grafana)
* Reset automático de senha de admin do Grafana

### ✅ `iam/`

* Cria `iam_role`, `iam_policy` e `instance_profile`
* Necessário para permitir que instâncias acessem o ECR, CloudWatch etc

---

## ⚙️ Variáveis principais (`terraform.tfvars`)

```hcl
name_prefix              = "myapp"
ami_id                   = "ami-xxxxxxxxxxxx" # Amazon Linux 2 / Ubuntu
instance_type            = "t3.micro"
key_name                 = "nomedasuaKeyPair"
vpc_id                   = "vpc-xxxxxxxxxxxxxxxxx"
subnet_ids               = ["subnet-xxxxxxxx", "subnet-yyyyyyyy"]
allowed_ssh_cidr_blocks  = ["0.0.0.0/0"] # Para testes, restrinja depois!
grafana_admin_password   = "admin123456789-senhahipotetica"
iam_instance_profile_name = "myapp-ec2-profile"
docker_image             = "xxxxxxxxxxxx.dkr.ecr.us-east-1.amazonaws.com/minha-api:latest"
```

---

## 🚀 Como Executar

1. Acesse o diretório de ambiente:

```bash
cd environments/dev
```

2. Inicialize o Terraform:

```bash
terraform init
```

3. Visualize o plano de execução:

```bash
terraform plan -var-file=terraform.tfvars
```

4. Aplique:

```bash
terraform apply -var-file=terraform.tfvars
```

5. Para destruir:

```bash
terraform destroy -var-file=terraform.tfvars
```

---

## 🐳 Deploy via ECR

Já temos integração com AWS ECR no pipeline. Para usar:

```bash
# Autenticar no ECR (substitua pela sua região e repo ID)
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin xxxxxxxxxxxx.dkr.ecr.us-east-1.amazonaws.com

# Build da imagem
docker build -t minha-api .

# Tag e push
docker tag minha-api:latest xxxxxxxxxxxx.dkr.ecr.us-east-1.amazonaws.com/minha-api:latest
docker push xxxxxxxxxxxx.dkr.ecr.us-east-1.amazonaws.com/minha-api:latest
```

---

## 🛑 Cuidado com Custos

* Use instâncias `t3.micro` ou `t2.micro` para se manter no Free Tier
* Remova os recursos com `terraform destroy` ao final dos testes
* Monitore seu [AWS Billing Console](https://console.aws.amazon.com/billing/home#/)

---

## 📌 Próximos passos

* [ ] Criar pipeline CI/CD com GitHub Actions
* [ ] Configurar Prometheus como systemd
* [ ] Adicionar monitoramento via Node Exporter
* [ ] Criar painel customizado no Grafana via API

---

## 📄 Licença

Este projeto é open-source sob a licença MIT.

---

