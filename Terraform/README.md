# Terraform

To install Terraform into a container running the image from https://hub.docker.com/r/google/cloud-sdk/ (see README.md in root directory) run the
'install_terraform' from within a container based on that image.


## Terraform Authentication

Login by doing 'gcloud auth application-default login' which will write application credentials to a well-known location. Refer to
the documentation at https://cloud.google.com/docs/authentication/application-default-credentials Note that these credentials are
different to gcloud credentials. Refer https://cloud.google.com/docs/authentication/provide-credentials-adc  Once logged in Terraform
will use those credentials.

Can also (I think) create a service account using the guidelines found at https://developer.hashicorp.com/terraform/tutorials/gcp-get-started/build-the-google-cloud

- Go to https://console.cloud.google.com
- Select 'IAM & Admin'
- Select 'Service Accounts'
- Create service account called 'terraform-cli-sa'
- Grant the service account the 'editor' role
- Skip granting additional users access

To download the new key:
- Select the 'terraform-cli-sa' service account from the list
- Select the 'Keys' tab
- In the drop down menu, select 'Create new key'
- Leave the 'Key Type' as JSON.
- Click 'Create' to create the key and save the key file to your system.



## Logon to the VM

For Linux machines it's recommended to use SSH. There are two SSH options:

- OS Login. This is preferred as you use Google Compute Engine IAM roles to manage SSH access.
- Managed SSH keys in metadata.

Refer: https://cloud.google.com/compute/docs/instances/access-overview

If OS Loign is enabled can't use metadata login. To check whether its enabled or not do:

    gcloud compute instances describe vm_instance_name --flatten="metadata[]" --project XXXXX

Check whether the key 'enable-oslogin' exists and is set to true.

If OS Login is not enabled can connect by doing:

    gcloud compute ssh chris@vm_instance_name --project XXXXX

Note that connecting as root is not allowed. By default the above command will connect as current user. Have specified 'chris' as user above.

