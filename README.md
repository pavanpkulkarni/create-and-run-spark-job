# Create n-node Cluster and Run Jobs on Docker  

### Prerequisites 
1. java - [Installation Instruction](https://www.java.com/en/download/help/download_options.xml)
2. git - [Installation Instruction](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
3. docker - [Installation Instruction](https://docs.docker.com/engine/installation/)

### To Run
1. Clone this repo to your local
2. Execute the script : [RunSparkJobOnDocker.sh](blob/master/RunSparkJobOnDocker.sh)

### RunSparkJobOnDocker.sh Details
This repository contains all the required files to create a n-node spark cluster and run a simple app on it. In this project, the script [RunSparkJobOnDocker.sh](blob/master/RunSparkJobOnDocker.sh) does the following:  
1.  Pull the image from [docker-hub](https://hub.docker.com/r/pavanpkulkarni/spark_image/) 
2.  Create a n-node cluster. in our case, we are creating a 5-node cluster. This can changes by specifying `docker-compose scale slave=n`
3.  Next, we build an image which acts as expternal image that will submit the job on the cluster that we just created.
4.  Run the job on the cluster. You can either pull this [Source Code](https://github.com/pavanpkulkarni/Spark_WordCount_Gradle) and build wiht Gradle or try something of your own.
5.  Finally, when the job is executed, we bring down the cluster.

### Spark Job Description. 
This is a simple spark job in Scala to read a file - [sample.txt](blob/master/sample.txt) and perform a basic Word Count on this file.

### Spark Dockerfile
[Dockerfile](https://github.com/pavanpkulkarni/docker-spark-image) 
