# National Parks Application using Habitat in Azure

This Terraform spins up the National Parks application using [Habitat](https://www.habitat.sh) in Microsoft Azure!

#### Requirements
* Terraform >= 0.11.0
* Microsoft Azure Account
* [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest)
* Cloned or Forked copy of this repository

#### Preflight Considerations
* To keep secrets out of version control I've made it a habit of creating environment files for any of the terraform providers. This allows you for example to `source ~/.env.d/azure` prior to initializing and applying. If you'd like to use this method, the following example is the minimal environment needed:
  ```
  export TF_VAR_azure_sub_id=your-azure-subscription-id
  export TF_VAR_azure_tenant_id=your-azure-tenant-id
  export TF_VAR_azure_public_key_path=/path/to/your/public_ssh_key
  export TF_VAR_azure_private_key_path=/path/to/your/private_ssh_key
  ```
  To obtain your `Azure Subscription ID` and `Azure Tenant ID`, using Azure CLI perform an `az login` and you'll be on your way!

* If you're testing this locally and don't intend to store it in version control, then it's safe to open `variables.tf` and replace the values as needed.

#### Flight Time
* Verify requirements
* Review and implement the Preflight Considerations
* Launch!
  ```
  azure git:master ❯ terraform init
  azure git:master ❯ terraform apply
  ```
* At this point the necessary network and storage resources will be built, followed by the compute instances in the following order:
  * Initial Peer
  * MongoDB
  * National Parks Application

#### Outputs
Once the `terraform apply` is complete, the external IPs of the above instances will be presented as output. You'll then be able to access the application on `http://pip-np_app:8080` where `pip-np_app` is the output provided.
```
pip-initial_peer = xx.xx.xx.xx
pip-mongodb = xx.xx.xx.xx
pip-np_app = xx.xx.xx.xx
```
