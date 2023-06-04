# google.cloud.play
Experimenting with Google Cloud Platform (GCP)

## Console

https://console.cloud.google.com


## Using Google Cloud SDK Image

Instead of installing the Google Cloud Tools on local machine can use the image from https://hub.docker.com/r/google/cloud-sdk/ and mount this repo
into the container. Can then edit the files with tool of your choice and run from the container.

Check versions:

    nerdctl run -ti --rm google/cloud-sdk:latest gcloud version

Run container and mount this repo assuming you are inside it (i.e. note use of PWD in below command):

    nerdctl run -ti --rm --mount type=bind,source=$PWD,target=/root/google.cloud.play google/cloud-sdk:latest /bin/bash

Login to gcloud CLI:

    gcloud auth login

Then set the default project

     gcloud config set project PROJECT_ID
