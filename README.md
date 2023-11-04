# google.cloud.play
Experimenting with Google Cloud Platform (GCP)

## Console

https://console.cloud.google.com


## Using Google Cloud SDK Image

Will want to use the Google Cloud CLI (called gcloud) to interact with GCP. As gcloud is part of the Google Cloud SDK, which has its documentaion
at https://cloud.google.com/sdk, rather than installing it locally can use the image from https://hub.docker.com/r/google/cloud-sdk/, mount this
repository inside it and run gcloud from there. Can then edit the files with tool of your choice from outside the container and run the code from
inside the container.

Check versions:

    nerdctl run -ti --rm google/cloud-sdk:latest gcloud version

Run container and mount this repo assuming you are inside it (i.e. note use of PWD in below command):

    nerdctl run -it --rm  -v "${PWD}":/root/google.cloud.play google/cloud-sdk:latest /bin/bash

Login to gcloud CLI:

    gcloud auth login

Then set the default project

     gcloud config set project PROJECT_ID


The gcloud documentation is at https://cloud.google.com/sdk/gcloud/reference

## GCP Notes ##



### Virtual Private Cloud (VPC) ###

VPC provides networking for your cloud-based services that is global, scalable, and flexible.




### Virtual Machines ###

Spot Instances Documentation: https://cloud.google.com/compute/docs/instances/spot

To use spot instances set the 'provisioning model' to spot, 'preemptible' to true and 'automatic_restart' to false (accoring to Terraform provider documentation).

List images: gcloud compute images list --project XXXXX

Look into Container-Optimized OS that is optimized for running Docker containers: https://cloud.google.com/container-optimized-os/docs
