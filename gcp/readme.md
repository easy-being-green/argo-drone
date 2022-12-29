# GCP

What a dream! Love me some GGP - just so much cleaner.

Anyway..


# To Reseach


# Hardening the Cluster
See [hardening cluster](https://cloud.google.com/kubernetes-engine/docs/how-to/hardening-your-cluster#use_least_privilege_sa)

```
export SA_NAME=${SA_NAME:-"ebg-nodes"}
export DISPLAY_NAME=${DISPLAY_NAME:-"$SA_NAME"}
gcloud iam service-accounts create SA_NAME \
    --display-name="DISPLAY_NAME"
```


# Project Log

## Setup
Setup w/ gcloud was super simple/slick/easy. Love the "show this in the command line" option!

Note: Argo is availabile in the google apps marketplace

## First failure - example app fails to start
The example project fails in the same way on GCP as on AWS, which is:

"exec /bin/sh: exec format error"

So, basically looks like the cluster nodes are on a different platform architecture than
the image.

Checking:
 * [this](https://cloud.google.com/kubernetes-engine/docs/how-to/node-pools)