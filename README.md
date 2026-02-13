# Zscaler - Automation with Terraform

This repository contains Terraform configurations for automating Zscaler Internet Access (ZIA) and Zscaler Private Access (ZPA) deployment and management.

## Requirements

1. You need to configure Zscaler OneAPI with appropriate permissions.
2. You need to have DevBox and Nix Packet Manager installed on your system.
3. You need to decide on a secrets management method for storing Zscaler OneAPI credentials.

## Configuration

### Zscaler OneAPI credentials

In order to use this repository, you will need to generate Zscaler OneAPI credentials. You can obtain these by logging into the [Zscaler Experience Center](https://console.zscaler.com) and navigating to the OneAPI section (***Administration -> API Configuration -> OneAPI***).

### DevBox Installation and basic usage

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
export ZSCALER_CLIENT_ID=$(gopass show zscaler_oneapi/client_id)
export ZSCALER_CLIENT_SECRET=$(gopass show zscaler_oneapi/client_secret)
export ZSCALER_VANITY_DOMAIN=$(gopass show zscaler_oneapi/vanity_domain)
export ZPA_CUSTOMER_ID=$(gopass show zscaler_oneapi/customer_id)
```

**Documentation:**

- [ZIA Environment Variables](https://registry.terraform.io/providers/zscaler/zia/latest/docs#default-environment-variables)
- [ZPA Environment Variables](https://registry.terraform.io/providers/zscaler/zpa/latest/docs#default-environment-variables)

## Getting Started

### Clone repository from Github

```shell
git clone git@github.com:borgermeister/terraform_zscaler.git
```

### Activate DevBox Environment

```shell
# Activate DevBox environment (this may take some time)
devbox shell
```

### Generate GPG key pair

```shell
# Use GPG to generate a key pair to be used for securing Password Store
gpg --expert --full-generate-key
```

### Initialize Password Store

```shell
# Initialize Password Store using GoPass. Remember to generate a GPG key before initializing.
gopass init 'your GPG key'
```

### Add secrets to Password Store

```shell
# Add Zscaler OneAPI information into the Password Store
gopass insert zscaler_oneapi/client_id
gopass insert zscaler_oneapi/client_secret
gopass insert zscaler_oneapi/vanity_domain
gopass insert zscaler_oneapi/customer_id
```

### Initialize Terraform

```shell
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
