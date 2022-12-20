#!/usr/bin/env bash


which helm || brew install helm

helm repo add drone https://charts.drone.io

helm search repo drone

