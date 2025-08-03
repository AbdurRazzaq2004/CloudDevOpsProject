# 🌐 iVolve CI/CD Infrastructure

A comprehensive end-to-end CI/CD infrastructure for containerized applications. This project leverages **Terraform** for AWS infrastructure provisioning, **Ansible** for automated configuration management, **Jenkins** for continuous integration, and **ArgoCD** for GitOps-based deployment to **Kubernetes** clusters.

---
## Project Architecture 

![Architecture](https://github.com/user-attachments/assets/41b21894-f8c2-4ac9-8a57-2fc8349f59e1)

---
## 🏗️ Architecture Overview

### 1. ☁️ AWS Infrastructure (Terraform Provisioned)

- **EC2 Instance (Jenkins Master)**:
  - Hosts the Jenkins Controller for CI pipeline orchestration
- **EC2 Instance (Jenkins Agent)**:
  - Executes resource-heavy CI jobs (e.g., build, test, deploy)
- **Supporting AWS Services**:
  - **S3**: Remote backend for Terraform state management
  - **CloudWatch**: Monitoring, logging, custom dashboards & alarms
  - **SNS**: Email notifications for critical alerts from CloudWatch
- **Amazon EKS (Elastic Kubernetes Service)**:
  - Fully managed Kubernetes cluster with:
  - Control plane managed by AWS
  - Two worker nodes (managed node group)
---

### 2. 💻 Kubernetes Environment

- **EKS Cluster** (Managed by AWS):
  - 1 control plane (managed by AWS) + 2 worker nodes (managed-node)
  - Hosts the iVolve application namespace
  - Handles all containerized deployments (via Kubernetes manifests)

---

### 3. 🔁 ArgoCD (GitOps Deployment)

- **Core Components**:
  - **Application Controller**: Ensures app state matches Git
  - **Repository Server**: Caches Git manifests
  - **GitOps Engine**: Executes sync operations
- **Deployment Workflow**:
  1. Watches GitHub repo for manifest updates
  2. Automatically syncs changes to the EKS cluster
  3. Maintains the declared state from version control

---

### 4. ⚙️ CI/CD Pipeline Flow

1. **Code push** triggers webhook in GitHub
2. **Jenkins Master** detects the change and schedules a job
3. **Jenkins Agent**:
   - Runs unit tests
   - Builds Docker image
   - Pushes image to container registry (e.g., Docker Hub or ECR)
   - Updates Kubernetes manifests with new image tag
   - Commits manifest changes back to GitHub
4. **ArgoCD**:
   - Detects new commit in the GitHub repo
   - Syncs updated manifests to the EKS cluster
5. **Application** is deployed/updated automatically in Kubernetes

---

## ✅ Prerequisites

- AWS account with required permissions and keys
- Docker & Git installed locally
- EKS Cluster setup (via Terraform in this project)

---

## 📁 Project Structure

```bash
.
├── Ansible/               # Ansible roles, playbooks, and dynamic inventory
├── ArgoCD/                # ArgoCD application manifests
├── Docker/                # Dockerfile and app source code
├── Jenkins/               # Jenkinsfile & shared libraries
├── Kubernetes/            # Kubernetes deployment & service manifests
├── Terraform/             # Terraform modules & scripts
└── README.md              # Main documentation file
```

---

## 🧱 Project Components

### 🚀 Terraform (Infrastructure as Code)

Automates provisioning of:
- VPC, public subnets, internet gateway
- EC2 Instances (Jenkins Master & Worker)
- EKS Cluster with Node Groups
- CloudWatch Alarms & Dashboards
- SNS Email Alerts

📄 [Terraform README →](./Terraform/README.md)

---

### ⚙️ Ansible (Configuration Management)

Used to configure:
- Jenkins Master (install Jenkins, Groovy admin script, plugins)
- Jenkins Worker (Trivy, Docker, Git, etc.)
- Uses AWS EC2 dynamic inventory

📄 [Ansible README →](./Ansible/README.md)

---

### 🛠️ Jenkins (CI/CD Pipeline)

Includes:
- `Jenkinsfile` defining pipeline stages:
  - Checkout Code
  - Build & Push Docker Image
  - Security Scan (Trivy)
  - Update Kubernetes manifests
- Shared Library functions in `vars/`

📄 [Jenkins README →](./Jenkins/README.md)

---

### 🐳 Docker (Application Containerization)

- Flask-based sample web app
- Lightweight Docker image (`python:3.12-alpine`)
- Exposes port 5000

📄 [Docker README →](./Docker/README.md)

---

### ☸️ Kubernetes (Container Orchestration)

- Deployment and LoadBalancer service
- Namespace configuration for `ivolve`
- Manifests automatically updated via Jenkins pipeline

📄 [Kubernetes README →](./Kubernetes/README.md)

---

### 🚀 ArgoCD (GitOps Continuous Deployment)

- Automatically syncs updated manifests from GitHub
- Deploys app on EKS cluster using ArgoCD

📄 [ArgoCD README →](./ArgoCD/README.md)


---
## 👨‍💻 Author

**Sherif Shaban**  
Cloud DevOps Engineer  

## 📬 Contact

- [![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-blue?logo=linkedin)](https://www.linkedin.com/in/sherif127)  
- 📧 sherifshabanpp00@gmail.com