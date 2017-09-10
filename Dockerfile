FROM pavanpkulkarni/spark_image_2.0.1:first_image
MAINTAINER pavan.git@gmail.com

COPY SparkDocker-1.0.jar /opt/SparkDocker-1.0.jar
COPY sample.txt /opt/sample.txt

CMD /opt/spark/bin/spark-submit --class $SPARK_CLASS --master spark://master:7077 /opt/SparkDocker-1.0.jar /opt/sample.txt
