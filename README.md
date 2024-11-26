# Kir-Dev infrastructure

This repository contains the configuration for setting up and managing a Terraform Enterprise (TFE) organization using Terraform Cloud.

It provides a script for creating a new TFE organization and terraform code to automate TFE workspace creation and management.

## Requirements

1. **Terraform**: Version 1.9.8 or later [Download Terraform](https://developer.hashicorp.com/terraform/install)
2. **Terraform Cloud Account**: An active account on [Terraform Cloud](https://app.terraform.io/session)
3. **Terraform Cloud User API Token**: A [user API token](https://app.terraform.io/app/settings/tokens) of the organization owner.
4. **Empty Terraform Cloud Organization**: A new or unused organization in Terraform Cloud where configurations will be set up.

## Getting Started

### Step 1: Bootstrap Your TFE Organization

1. Clone this repository:
   ```bash
   git clone <repository-url>
   cd terraform-tfe
   ```

2. Run the interactive CLI program [install.sh](./install.sh) to initialize your Terraform Cloud organization and GitHub integration.
   ```bash
   ./install.sh
   ```
   This script will guide you through the process of creating a new Terraform Cloud organization, installing the Terraform Cloud GitHub App, and configuring the GitHub integration.

### Step 2: Configure Environment Variables in TFE

Once the organization is bootstrapped, set up your environment variables in the Terraform Cloud workspace(s) to match your infrastructure needs.

### Step 3: Make Changes in Source Repositories

After bootstrapping, any changes to your infrastructure should be managed through this repository. Use the following workflow for updates:

1. Make changes to the relevant Terraform files.
2. Commit and push your changes to the source repository.
3. Approve the changes in the Terraform Cloud workspace(s).

## Acknowledgments

This repository was built using resources and inspiration from the [ALT-F4-LLC/fem-eci-terraform-tfe](https://github.com/ALT-F4-LLC/fem-eci-terraform-tfe.git) project. 
