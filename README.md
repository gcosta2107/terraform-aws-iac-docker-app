# 📄 Relatório  
**Documento de Serviços**  
**Nome do(a) Aluno(a):** Diogo Costa Maranhão Rodrigues; Gabriel Costa e Silva  
**Título do Projeto/Demanda:** CONTAINERS E DOCKER  
**Data:** 18/04/2025  

---

## 📚 Sumário
1. [Descrição geral da demanda técnica](#descrição-geral-da-demanda-técnica)  
2. [Premissas](#premissas)  
3. [Problemas atuais do contexto](#problemas-atuais-do-contexto)  
4. [Proposta de solução preliminar](#proposta-de-solução-preliminar)  
5. [Teste de validação da solução](#teste-de-validação-da-solução)  
6. [Diagrama de Arquitetura](#diagrama-de-arquitetura)  
7. [Anexos e conteúdos relacionados](#anexos-e-conteúdos-relacionados)  

---

## 📌 Descrição geral da demanda técnica

O objetivo dessa atividade é realizar o provisionamento de uma infraestrutura na nuvem AWS com Terraform, utilizando o Visual Studio Code como ferramenta de desenvolvimento. O provisionamento inclui:

- Uma VPC com três subnets específicas (uma pública e duas privadas)  
- Security Groups personalizados  
- Auto Scaling Group (ASG) com instâncias EC2 contendo Docker instalado  
- Aplicação "Getting Started" executando em containers  
- Application Load Balancer (ALB) associado ao ASG  
- Instância RDS MySQL privada  

---

## ⚙️ Premissas

- VPC configurada em CIDR `172.31.0.0/16`
- Subnets:
  - Pública: `172.31.1.0/24`
  - Privadas: `172.31.2.0/24`, `172.31.3.0/24`
- EC2 com Docker instalado automaticamente via **UserData**
- RDS MySQL com retenção de backups por **7 dias**

---

## ❗ Problemas atuais do contexto

A infraestrutura atual demanda flexibilidade e automação para escalabilidade. O provisionamento manual é:

- Lento
- Suscetível a erros
- Incapaz de atender rapidamente às variações de demanda

---

## 💡 Proposta de solução preliminar

Para solucionar os problemas destacados, adotou-se uma abordagem automatizada com **Terraform**.

1. **Configuração da VPC** e subnets específicas
2. **Security Groups** definidos para:
   - Permitir acesso ao ALB
   - Restringir o acesso às instâncias EC2 e RDS
     
3. **Auto Scaling Group**:
   - Tipo da instância: `t2.micro`
   - Mínimo: 1 instância | Máximo: 2 instâncias
   - **UserData** para:
     - Instalar Docker
     - Clonar o repositório da aplicação
     - Buildar e executar o container da aplicação

4. **Application Load Balancer**:
   - Distribui o tráfego externo (porta 80) para as instâncias EC2 no ASG
   - Garante alta disponibilidade da aplicação

5. **Amazon RDS MySQL**:
   - Tipo `t3.micro`
   - Instância privada
   - Backups automáticos por 7 dias

6. **Script shell para execução do Docker**:
  - Para automatizar a instalação do Docker e execução da aplicação em contêiner, foi criado um script shell chamado `docker.sh`.
  - Esse script é executado automaticamente via `user_data` nas instâncias EC2, realizando:
    - Atualização do sistema
    - Instalação e inicialização do Docker
    - Inclusão do usuário `ec2-user` no grupo `docker`
    - Execução da imagem do Docker Hub `gabgabgabas/getting-started`

---

## ✅ Teste de validação da solução

Para validar o provisionamento:

- Acessou-se o **DNS público** fornecido pelo Application Load Balancer
- A aplicação "Getting Started" do Docker foi carregada com sucesso no navegador
- Isso confirma que o container foi iniciado corretamente nas instâncias EC2

---

## 🗺️ Diagrama de Arquitetura

![Captura de tela 2025-04-18 180808](https://github.com/user-attachments/assets/cde375bb-fdee-48b7-9ec6-0000e09f563a)

---

## 📎 Anexos e conteúdos relacionados

- Código base utilizado sem uso de containers:  
  🔗 [Repositório no GitHub](https://github.com/Dcmaran/terraform-iac)

- Imagem publicada no Docker Hub:  
  🐳 [gabgabgabas/getting-started](https://hub.docker.com/r/gabgabgabas/getting-started)

- Aplicação de referência em container:  
  📘 [Docker Getting Started Guide](https://docs.docker.com/get-started/workshop/02_our_app/)

---
