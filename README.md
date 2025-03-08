# azure-lab-infra
# **Terraform Azure Backend - Azure Lab**

## 📌 **Project Description**
This repository contains the Terraform configuration to deploy a basic infrastructure in **Microsoft Azure**, using a **remote backend in Azure Storage** to securely and collaboratively store Terraform state.

## 🎯 **Project Objectives**
✅ Configure **Terraform** to deploy infrastructure in Azure.  
✅ Use **Azure Storage** as a remote backend to store Terraform state.  
✅ Integrate automation with **GitHub Actions** for CI/CD (in future phases).  
✅ Document each step for real-world usage and professional portfolio.  

---

## 🔧 **Prerequisites**
Before running Terraform, ensure you have the following:

### 🛠 **Required Tools**
- [Azure CLI](https://aka.ms/installazurecliwindows) - To interact with Azure from the command line.
- [Terraform CLI](https://developer.hashicorp.com/terraform/downloads) - To manage infrastructure as code.
- [GitHub CLI](https://cli.github.com/) (Optional) - To manage repositories from the terminal.
- [Visual Studio Code](https://code.visualstudio.com/) - With Terraform and Azure CLI extensions.

### 🆓 **Azure Account**
You can sign up for **[Azure Free Tier](https://azure.microsoft.com/en-us/free/)** to get **$200 in credits** for 30 days.

---

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
  description = "Location where resources will be deployed"
  default     = "eastus"
}

variable "resource_group_name" {
  description = "Name of the resource group"
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

## ✅ **Expected Results**
- Terraform stores the state in **Azure Storage**.
- The **resource group `rg-azure-lab`** is created in Azure.
- All Terraform files are organized and versioned in **GitHub**.
- In future phases, we will integrate **CI/CD with GitHub Actions**.


