# Zscaler - Automation with Terraform

This repository contains Terraform configurations for automating Zscaler Internet Access (ZIA) and Zscaler Private Access (ZPA) deployment and management.

## Requirements

1. You need to configure Zscaler OneAPI with appropriate permissions.
2. You need to have Terraform installed on your system.
3. You need to decide on a secrets management method for storing Zscaler OneAPI credentials.

## Configuration

### Zscaler OneAPI credentials

In order to use the Ansible playbooks and roles in this repository, you will need to generate Zscaler OneAPI credentials. You can obtain these by logging into the [Zscaler Experience Center](https://console.zscaler.com) and navigating to the OneAPI section (***Administration -> API Configuration -> OneAPI***).

At this moment Zscaler OneAPI is only supported on the ZIA collection. When using the ZPA collection you will need to use the Legacy API.

For the Legacy API you will also need your **customer ID** and the name of the **ZPA cloud**.

#### DevBox Installation and basic usage

```shell
# Install DevBox
curl -fsSL https://get.jetify.com/devbox | bash

# Install Nix package manager
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install

# Activate DevBox virtual environment - executes the content of devbox.json
devbox shell

# Update DevBox packages
devbox update

# Add DevBox package
devbox add <package>

# Upgrade DevBox
devbox version update
```

## Secrets Management

Pass will be installed as soon as you run the DevBox virtual environment. [Gopass](https://www.gopass.pw) is a more modern and intuitive way to manage the Password Store, and will also be installed as part of the DevBox installation.

### Authentication Methods

The easiest way to authenticate to Zscaler OneAPI is using environment variables. This prevents credentials from being stored in plain text in your Terraform configuration files.

**Provider configuration in `provider.tf`:**

```hcl
# Zscaler Internet Access provider
# Authentication via environment variables (see below)
provider "zia" {}

# Zscaler Private Access provider
# Authentication via environment variables (see below)
provider "zpa" {}
```

### Setting Environment Variables

Export the required credentials using Gopass to retrieve stored secrets. This is done automatically when the virtual environment is activated.

```shell
export ZSCALER_CLIENT_ID=$(gopass show ansible/zscaler/zia/client_id)
export ZSCALER_CLIENT_SECRET=$(gopass show ansible/zscaler/zia/client_secret)
export ZSCALER_VANITY_DOMAIN=$(gopass show ansible/zscaler/zia/vanity_domain)
export ZPA_CUSTOMER_ID=$(gopass show ansible/zscaler/zpa/customer_id)
```

**Documentation:**

- [ZIA Environment Variables](https://registry.terraform.io/providers/zscaler/zia/latest/docs#default-environment-variables)
- [ZPA Environment Variables](https://registry.terraform.io/providers/zscaler/zpa/latest/docs#default-environment-variables)

## Usage

### Initialize Terraform

```shell
# Activate DevBox environment first
devbox shell

# Initialize Terraform (downloads providers)
terraform init

# Validate configuration
terraform validate

# Preview changes
terraform plan

# Apply changes
terraform apply
```

### Managing State

```shell
# Show current state
terraform show

# List resources in state
terraform state list

# Remove a resource from state (without destroying it)
terraform state rm <resource_address>
```
