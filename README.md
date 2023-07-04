# Replicable Infrastructure Adventure

Creating a reliable cloud infrastructure is essential for successful DevOps projects. With Terraform and GitHub Actions, you can automate the deployment of cloud resources, setting a solid foundation for your DevOps portfolio. This repository is forkable, so you can replicate the functionality for your own projects.


## Requirements

- **Accounts:**

  - An [Azure Account](https://azure.microsoft.com/en-us/free/) to deploy cloud resources.
  - A [GitHub Account](https://github.com/join) to host your infrastructure as code and the GitHub Actions worker.

- **Software installed on your local machine:**

  - [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) to configure the initial setup.
  - [Git](https://git-scm.com/downloads) to push infrastructure changes to GitHub.
  - [VS Code](https://code.visualstudio.com/) with the [Terraform extension](https://marketplace.visualstudio.com/items?itemName=HashiCorp.terraform) to write your infrastructure as code.

**Familiarity with the terminal, VS Code, GitHub, Terraform, and Azure is expected.**

## Usage Steps

### Setting up the GitHub Actions workflow:

Steps 1-3 use Azure CLI commands in your terminal. The remaining steps use GitHub, Git, and VS Code.

1. **Login to your Azure account** to create necessary Azure configuration for automation.
   - Run `az login` and follow instructions to log in with your browser.
2. **Create an Azure Service Principal** for authenticating GitHub Actions worker and deploying to your cloud provider with proper permissions.
   - Run `az ad sp create-for-rbac --name <SPNNAME> --role Contributor --scopes /subscriptions/<SUBSCRIPTIONID>`.
3. **Create an Azure Storage Account Container** to store state of Terraform in Azure. This will keep track of provisioned resources and what needs adding, updating, or deleting on subsequent runs.
   - **Create a resource group for storage account**: `az group create -n tfstates -l eastus`
   - **Create a storage account within the created rg**: `az storage account create -n <ACCOUNTNAME> -g tfstates -l eastus2 --sku Standard_LRS`
   - **Create a storage account container within the created storage account**: `az storage container create -n tfstate --account-name <ACCOUNTNAME>`
4. **Fork this repository** to replicate automation environment.
5. **Set up your GitHub actions repository secrets** in your forked repository.
   - In your forked repository, navigate to `./github/workflow/terraform.yml`. This file requires variables set up in your repository settings for the GitHub Action workflow to run correctly.
   - Under your repository settings, navigate to Secrets and Variables > Actions. In the Repository Variables section, create the following variables:
     - `ARM_CLIENT_ID = <spn client ID>`
     - `ARM_CLIENT_SECRET= <SPN password>`
     - `ARM_SUBSCRIPTION_ID = <Azure Subscription ID>`
     - `ARM_TENANT_ID = <SPN tenant ID>`
     - `CONTAINER_NAME = tfstate`
     - `RESOURCE_GROUP = tfstate`
     - `STORAGE_ACCOUNT = <ACCOUNTNAME>`

### Writing Infrastructure as Code

To write infrastructure as code for this project, follow these steps:

1. **Create a new branch** on your forked repository.
2. **Navigate** to the `terraform` directory and **open** `main.tf`.
3. **Add your desired infrastructure as code** to the `main.tf` file.

   - example to add a resource group, you can use the following code:
     `resource "azurerm_resource_group" "rg" {
   name     = "rg-test-adevnture-eastus-01"
   location = "eastus"
   tags = {
      Environment             = "test"
      Deployed_with_Terraform = "true"
   }
}`

4. Commit your changes and **create a pull request**.
5. **The Terraform workflow** will run, initializing and **validating your code**. If everything passes, you can merge your pull request.
6. The workflow will run again, initializing, planning, and **applying your changes to deploy your infrastructure**.

## Future Enhancements/Features:

- Implement Azure KeyVault to store and inject the secrets to the repository.
