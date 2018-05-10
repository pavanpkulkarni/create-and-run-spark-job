#!/bin/bash

currtime=$(date +"%Y%m%d")
LogFile=dockerRun_${currtime}.log

#pull spark docker image
echo "***** Begin Pulling image ***** " >>$LogFile 2>&1
docker pull pavanpkulkarni/spark_image:2.2.1
echo "***** End Pulling image *****" >>$LogFile 2>&1

#create a n node cluster with default configurations 
number_of_nodes=3
echo "***** Creating " $number_of_nodes " node cluster *****" >>$LogFile 2>&1
docker-compose build >>$LogFile 2>&1
docker-compose up -d --scale slave=$number_of_nodes >>$LogFile 2>&1

#run the job on the cluster
echo "***** Executing job on " $number_of_nodes "node cluster *****" >>$LogFile 2>&1
docker exec master /opt/spark/bin/spark-submit \
			--class com.pavanpkulkarni.dockerwordcount.DockerWordCount \
			--master spark://master:6066 \
			--deploy-mode cluster \
			--verbose \
			/opt/Docker_WordCount_Spark-1.0.jar /opt/sample.txt  /opt/output/op1 >>$LogFile 2>&1


#Uncomment below lines to add logic to bring down the cluster after spark job finish

# submissionId=$(grep submissionId $LogFile | cut -d \" -f4)

# echo "submission Id is : " $submissionId >>$LogFile 2>&1

# driverState=$(curl http://localhost:6066/v1/submissions/status/$submissionId | grep driverState | cut -d \" -f4) >>$LogFile 2>&1

# echo "driver state is : " $driverState >>$LogFile 2>&1

# #remove the cluster iff driver is finished
# if [[ "$driverState" == "FINISH" ]]; then
# 	echo "driver has successfully finished execution.. bringing down the cluster !!! " >>$LogFile 2>&1
# 	docker-compose down >>$LogFile 2>&1
# fi
