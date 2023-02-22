# terraform-aws-module-skeleton

This is a skeleton to easily create a terraform aws module with github ci/cd (actions). Concretely the example provided is to upload a AWS S3 object in an existing S3 bucket. This skeleton also includes a simple way to test the module.

## File structure

We have several files in the root folder:

- `main.tf`: Terraform module code
- `variables.tf`: Terraform variables type definition used by the module
- `output.tf`: Terraform outputs exposed from the module
- `terraform.env`: File to define which terraform version use. Intended to have it sourced for tracking purposes
- `docker-compose.yml`: Docker definition to use depencences in a Docker container
- `run.sh`: Script to handle terraform using Docker to avoid having dependences installed locally

The rest of files (`LICENSE`, `README` and `.gitignore`) are self explanatory.

The test folder is used to initialize and allow module validation through several dummy tests:

- `test/object_sample.txt`: S3 object to be upload by the module in the test scenario
- `test.tf`: Terraform file that contains several module instantiations as well as AWS provider so that several tests can be easily done

- `.github/workflows/validate_module.yml`: Github actions definition to test the module (`terraform init` & `terraform validate`). We don't execute in there the `run.sh` script to avoid going too deep with an unneeded docker-in-docker approach.

## The run.sh script

The script `run.sh`  is a wrapper to allow running terraform without any extra dependence besides `docker` and `docker-compose`. Basically the script jumps into the root folder, executes the corresponding terraform command using terraform docker image and goes back to the original location. The allowed commands are defined below:

- `./run.sh fmt [extra_terraform_parameters]`: The script runs `terraform fmt --recursive [extra_terraform_parameters]` using terraform docker image where `[extra_terraform_parameters]` can be any parameter. Its executed in module root so that all files can be formatted
- `./run.sh terraform_command [extra_terraform_parameters]`: The script runs `terraform terraform_command [extra_terraform_parameters]` using terraform docker image inside `test/` folder. Where `terraform_command` can be any command allowed by terraform binary and `extra_terraform_parameters` are optional and takes any parameter and any nymber of those

## Pending TODOs

There is still room for improvement, specially:

- Investigate a better way to do terraform unitary tests 