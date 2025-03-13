# azure-lab-infra
# **Terraform Azure Backend - Azure Lab**

## 📌 Project Overview
This repository demonstrates enterprise-grade Infrastructure as Code (IaC) implementation using Terraform to deploy and manage resources in Microsoft Azure. It showcases best practices for remote state management, modular design, and DevOps integration.

## 🎯 Key Features
✅ **Remote State Management**: Azure Storage backend for secure and collaborative state storage  
✅ **Infrastructure as Code**: Complete Azure environment defined in Terraform  
✅ **DevOps Ready**: Prepared for CI/CD integration with GitHub Actions  
✅ **Security-Focused**: Implements Azure security best practices  
✅ **Modular Design**: Reusable infrastructure components for different environments  

## 🔧 Technical Components
- **Virtual Networks & Subnets**: Properly segregated network architecture
- **Security Groups**: Controlled network access and security policies
- **Resource Groups**: Logical organization of Azure resources
- **Storage Configuration**: Secure and optimized storage solutions
- **Identity & Access Management**: Proper RBAC implementation

---

## 🔧 **Prerequisites**
Before running Terraform, ensure you have the following:

### 🛠 Required Tools
- [Azure CLI](https://aka.ms/installazurecliwindows) - For Azure authentication and resource management
- [Terraform CLI](https://developer.hashicorp.com/terraform/downloads) (v1.0+) - For infrastructure deployment
- [GitHub CLI](https://cli.github.com/) (Optional) - For repository management
- [Visual Studio Code](https://code.visualstudio.com/) with Terraform and Azure extensions

### ☁️ Azure Account Requirements
- Active Azure subscription (Free tier eligible: [Azure Free Account](https://azure.microsoft.com/en-us/free/))
- Contributor or Owner permissions on the subscription

---

## 📂 **Project Structure**
```plaintext
azure-lab-infra/
│── main.tf             # Infrastructure definition (Resource Group)
│── variables.tf        # Reusable variables
│── backend.tf          # Remote backend configuration in Azure
│── providers.tf        # Azure provider configuration
│── outputs.tf          # Useful output definitions
│── .gitignore          # Ignore sensitive files like terraform.tfstate
```


## 🚀 **Setup Steps**

### **1️⃣ Authenticate with Azure**
Log in to Azure:
```sh
az login
```
If you have multiple subscriptions, select the correct one:
```sh
az account set --subscription "YOUR_SUBSCRIPTION_ID"
```

### **2️⃣ Create the Resource Group and Storage Account**
Run the following commands to create the resource group and storage:
```sh
az group create --name rg-terraform-backend --location eastus

az storage account create --name tfbackendstorage \  
    --resource-group rg-terraform-backend \  
    --location eastus \  
    --sku Standard_LRS \  
    --kind StorageV2
```

### **3️⃣ Create a Container in the Storage Account**
```sh
az storage container create --name terraform-state --account-name tfbackendstorage
```




---

## 📜 **Terraform Code**

### **📄 File `backend.tf`** (Defines remote storage in Azure Storage)
```hcl
terraform {
  backend "azurerm" {
    resource_group_name   = "rg-terraform-backend"
    storage_account_name  = "tfbackendstorage"
    container_name        = "terraform-state"
    key                   = "terraform.tfstate"
  }
}
```

### **📄 File `main.tf`** (Defines the base infrastructure)
```hcl
resource "azurerm_resource_group" "lab" {
  name     = "rg-azure-lab"
  location = var.location
}
```

### **📄 File `variables.tf`** (Defines reusable variables)
```hcl
variable "location" {
  description = "location where all resources will be deploy"
  default     = "eastus"
}

variable "resource_group_name" {
  description = "resource group name"
  default     = "rg-azure-lab"
}
```

---

## 🏗 **Running Terraform**
### **1️⃣ Initialize Terraform**
```sh
terraform init
```
📌 **This connects Terraform to the backend in Azure Storage.**

### **2️⃣ Validate the Execution Plan**
```sh
terraform plan
```
📌 **Displays the changes that will be applied to Azure.**

### **3️⃣ Apply Changes to Azure**
```sh
terraform apply -auto-approve
```
📌 **Deploys the infrastructure in Azure.**

### **4️⃣ Verify Resources in Azure**
```sh
az resource list --resource-group rg-azure-lab --output table
```
📌 **Confirms that the resource group was created successfully.**

### **5️⃣ Verify State Stored in Azure Storage**
```sh
terraform show
```
📌 **Displays the deployed infrastructure and confirms the remote backend is working.**

---
🔍 Validation and Testing

State Verification: terraform show - Confirms remote state storage
Infrastructure Tests: Validates resource configuration and connectivity
Security Validation: Ensures proper access controls and network security

🚦 CI/CD Integration
This repository is designed to work with GitHub Actions for automated infrastructure deployment:

Pull Request Validation: Terraform plan execution for code review
Infrastructure Deployment: Automated deployment to development environment
Environment Promotion: Controlled promotion to production

🔮 Future Enhancements

Add Azure Policy implementation for compliance monitoring
Implement cost optimization recommendations
Add disaster recovery configurations
Integrate with Azure Monitor for operational insights


👨‍💻 Author
Daniel Andrade - Azure Certified Cloud Engineer


