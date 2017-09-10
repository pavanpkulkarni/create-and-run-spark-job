#!/bin/bash

#create a 5 node cluster with default configurations 
docker-compose build && docker-compose up -d && docker-compose scale slave=5

#spawn an image from where the job will be submitted to cluster 
docker build -t pavanpkulkarni/spark_image_2.0.1:first_image . 

#run the job on the cluster
docker run --net createsparkcluster210_default -e "SPARK_CLASS=com.pavanpkulkarni.docker.SampleSparkScalaCode" pavanpkulkarni/spark_image_2.0.1:first_image

#remove the cluster 
docker-compose down