# Spark-2.1.0 Create and Run Jobs on Docker  

This repository contains all the required files to create a n-node spark cluster and run a simple app on it. In this project, the script [RunSparkJobOnDocker.sh](RunSparkJobOnDocker.sh) does the following:  
1.  Pull the image from [docker-hub](https://hub.docker.com/r/pavanpkulkarni/spark_image_2.0.1/) 
2.  Create a n-node cluster. in our case, we are creating a 5-node cluster. This can changes by specifying `docker-compose scale slave=n`
3.  Next, we build an image which acts as expternal image that will submit the job on the cluster that we just created.
4.  Run the job on the cluster. You can either clone this [Source Code](https://github.com/pavanpkulkarni/SparkDocker) or try something of your own.
5.  Finally, when the job is executed, we bring down the cluster.

# Spark Job Description. 
This is a simple spark job in Scala to read a file - [sample.txt](sample.txt) and perform a basic Word Count on this file.

# Image Dockerfile
[Dockerfile](https://github.com/pavanpkulkarni/docker-spark-image_2.1.0) 
