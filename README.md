# Terraform AWS Demo com Módulos - Codespaces Ready

Este projeto é um exemplo completo de infraestrutura AWS usando Terraform modularizado, ideal para rodar no GitHub Codespaces.

## O que o projeto cria:

- VPC com duas subnets públicas, internet gateway e rotas básicas.
- Instância EC2 com acesso SSH.
- Bucket S3 com versionamento ativado.

---

## Estrutura do Projeto

- `modules/` — módulos reutilizáveis para VPC, EC2, S3.
- `environments/dev/` — ambiente dev que usa os módulos.
- `.devcontainer/` — configuração para rodar no GitHub Codespaces com Terraform e AWS CLI.

---

## Pré-requisitos

- Conta AWS com permissões para criar VPC, EC2 e S3.
- Chave SSH criada na AWS (para acesso EC2).
- Configurar as credenciais AWS no Codespaces (via `aws configure` ou variáveis de ambiente).

---

## Passo a passo para usar

1. **Abra o projeto no GitHub Codespaces**.

2. **Configure as credenciais AWS**:
   
   No terminal do Codespaces, rode:
   ```bash
   aws configure
