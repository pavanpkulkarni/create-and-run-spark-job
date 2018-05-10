#!/bin/bash

currtime=$(date +"%Y%m%d%H%M%S")
LogFile=dockerRun_${currtime}.log

#pull spark docker image
printf "+-------------------------------------------+\n" >>$LogFile 2>&1
printf "  Begin Pulling image                        \n" >>$LogFile 2>&1
printf "+-------------------------------------------+\n" >>$LogFile 2>&1

docker pull pavanpkulkarni/spark_image:2.2.1 >>$LogFile 2>&1

printf "\n" >>$LogFile 2>&1
printf "+-------------------------------------------+\n" >>$LogFile 2>&1
printf "  End Pulling image                          \n" >>$LogFile 2>&1
printf "+-------------------------------------------+\n" >>$LogFile 2>&1
printf "\n" >>$LogFile 2>&1

#create a n node cluster with default configurations 
number_of_nodes=3 >>$LogFile 2>&1

printf "+-------------------------------------------------+\n" >>$LogFile 2>&1
printf "Creating %s node cluster \n" "$number_of_nodes"        >>$LogFile 2>&1
printf "+-------------------------------------------------+\n" >>$LogFile 2>&1

docker-compose build >>$LogFile 2>&1
docker-compose up -d --scale slave=$number_of_nodes >>$LogFile 2>&1

printf "\n" >>$LogFile 2>&1
printf "+----------------------------------------------------+\n"   >>$LogFile 2>&1
printf "  %s node cluster  up and running    \n" "$number_of_nodes" >>$LogFile 2>&1
printf "  Check status of nodes running 'docker ps -a'        \n"   >>$LogFile 2>&1
printf "+----------------------------------------------------+\n"   >>$LogFile 2>&1
printf "\n" >>$LogFile 2>&1

#run the job on the cluster
printf "+----------------------------------------------------------+\n" >>$LogFile 2>&1
printf "  Executing Spark job on %s node cluster \n" "$number_of_nodes" >>$LogFile 2>&1
printf "+----------------------------------------------------------+\n" >>$LogFile 2>&1

docker exec master /opt/spark/bin/spark-submit \
			--class com.pavanpkulkarni.dockerwordcount.DockerWordCount \
			--master spark://master:6066 \
			--deploy-mode cluster \
			--verbose \
			/opt/Docker_WordCount_Spark-1.0.jar /opt/sample.txt  /opt/output/wordcount_output >>$LogFile 2>&1

printf "\n" >>$LogFile 2>&1
printf "+----------------------------------------------------------------+\n" >>$LogFile 2>&1
printf "  Check localhost:8080 for job status                             \n" >>$LogFile 2>&1
printf "  Check localhost:18080 for history server                        \n" >>$LogFile 2>&1
printf "  Executor port bindings can be found by running 'docker ps -a'   \n" >>$LogFile 2>&1
printf "+----------------------------------------------------------------+\n" >>$LogFile 2>&1
printf "\n" >>$LogFile 2>&1

#Uncomment below lines to add logic to bring down the cluster after spark job finish

# submissionId=$(grep submissionId $LogFile | cut -d \" -f4)

# printf "submission Id is : " $submissionId >>$LogFile 2>&1

# driverState=$(curl http://localhost:6066/v1/submissions/status/$submissionId | grep driverState | cut -d \" -f4) >>$LogFile 2>&1

# printf "driver state is : " $driverState >>$LogFile 2>&1

# #remove the cluster iff driver is finished
# if [[ "$driverState" == "FINISH" ]]; then
# 	printf "driver has successfully finished execution.. bringing down the cluster !!! " >>$LogFile 2>&1
# 	docker-compose down >>$LogFile 2>&1
# fi
