# Terraform #

To install Terraform into a container running the image from https://hub.docker.com/r/google/cloud-sdk/ (see README.md in root directory) run the
'install_terraform' from within a container based on that image.

## Linking GCP Resources ##

Most resources managed by the GCP provider have the 'self_link' attribute to uniquely identify them. This can be used instead of other attributes
commonly used in other providers such as name or id. Refer https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/getting_started#linking-gcp-resources


## Terraform Authentication ##

Login by doing 'gcloud auth application-default login' which will write application credentials to a well-known location which will then be used
by Terraform (well - the Gogle Terraform provider I guess). Note that this is different to logging into the gcloud CLI. Refer to the documentation
at https://cloud.google.com/docs/authentication/application-default-credentials that explains Application Default Credentials.

Another method to authenticate is to create a service account. Using the instructions at https://developer.hashicorp.com/terraform/tutorials/gcp-get-started/build-the-google-cloud
the process is to:

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



## Logon to the VM ##

For Linux machines it's recommended to use SSH. There are two SSH options:

- OS Login. This is preferred as you use Google Compute Engine IAM roles to manage SSH access.
- Managed SSH keys in metadata.

Refer: https://cloud.google.com/compute/docs/instances/access-overview

If OS Loign is enabled can't use metadata login. To check whether its enabled or not do:

    gcloud compute instances describe vm_instance_name --flatten="metadata[]" --project XXXXX

Check whether the key 'enable-oslogin' exists and is set to true.

If OS Login is not enabled can connect by doing (generated from the Google Cloud Console):

    gcloud compute ssh --zone "zone_here "vm_name_here" --project "project_here"

Can use the Google Cloud Console to logon to the VM via a web browser interface.

For VM's without an external IP can use Identity-Aware Proxy (IAP) for administrative access. This seems to happen automatically as
when using the command above this message is displayed: "External IP address was not found; defaulting to using IAP tunneling".Can
specify '--tunnel-through-iap' as part of the command to make this explicit. IAP documentation is https://cloud.google.com/iap/docs/using-tcp-forwarding
