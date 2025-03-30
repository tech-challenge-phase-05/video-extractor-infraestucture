# Video Extractor Infrastructure

Este repositório contém a infraestrutura como código (IaC) para o projeto Video Extractor, utilizando o Terraform para provisionamento dos recursos na AWS.

## Pré-requisitos

- Terraform instalado na máquina local.
- Credenciais da AWS configuradas para provisionamento dos recursos.

## Como Usar

1. Clone este repositório:

   ```bash
   git clone https://github.com/tech-challenge-phase-05/video-extractor-infraestucture.git
   ```

2. Navegue até o diretório do projeto:

   ```bash
   cd video-extractor-infraestucture
   ```

3. Inicialize o Terraform:

   ```bash
   terraform init
   ```

4. Visualize o plano de execução:

   ```bash
   terraform plan
   ```

5. Aplique as configurações para provisionar os recursos:

   ```bash
   terraform apply
   ```
