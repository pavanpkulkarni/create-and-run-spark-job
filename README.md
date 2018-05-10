# Create n-node Cluster and Run Jobs on Docker  

### Prerequisites 
1. java - [Installation Instruction](https://www.java.com/en/download/help/download_options.xml)
2. git - [Installation Instruction](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
3. docker - [Installation Instruction](https://docs.docker.com/engine/installation/)

### To Run
1. Clone this repo to your local
2. Execute the script : [RunSparkJobOnDocker.sh](https://github.com/pavanpkulkarni/create-and-run-spark-job/blob/master/RunSparkJobOnDocker.sh)

### RunSparkJobOnDocker.sh Details
This repository contains all the required files to create a n-node spark cluster and run a simple app on it. In this project, the script [RunSparkJobOnDocker.sh](https://github.com/pavanpkulkarni/create-and-run-spark-job/blob/master/RunSparkJobOnDocker.sh) does the following:  
1.  Pull the Spark image from [docker-hub](https://hub.docker.com/r/pavanpkulkarni/spark_image/). Tag : 2.2.1
2.  Build and Create a n-node cluster. Here I'm creating a 3-node cluster. This can be changed by specifying `docker-compose up -d --scale slave=$number_of_nodes`
3.  Run the job on the cluster. You can either pull this [Source Code](https://github.com/pavanpkulkarni/Spark_WordCount_Gradle) and build with Gradle or try something of your own.
4.  Optional - after successful completion of job, bring down the cluster by running `docker-compose down`.

### Spark UI:
Master - [localhost:8080](http://localhost:8080)  
History Server - [localhost:18080](http://localhost:18080)  
Executors - The port bindings can be found by running `docker ps -a`. Eg:

```
Pavans-MacBook-Pro:create-and-run-spark-job pavanpkulkarni$ docker ps -a
CONTAINER ID        IMAGE                              COMMAND                  CREATED             STATUS              PORTS                                                                                                                 NAMES
30a51b5f5a77        pavanpkulkarni/spark_image:2.2.1   "/usr/bin/supervisor…"   12 seconds ago      Up 16 seconds       4040/tcp, 6066/tcp, 7077/tcp, 8080/tcp, 18080/tcp, 0.0.0.0:32854->8081/tcp                                            create-and-run-spark-job_slave_3
```
So, the executor can be accessed using [localhost:32854](http://localhost:32854)

### Spark Docker Image Details
[Check this repo for Docker image details](https://github.com/pavanpkulkarni/docker-spark-image) 
