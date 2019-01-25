#!/bin/bash
mkdir result_rtt
echo "test start" 
sed -i "93c pp1.SetChannelAttribute(\"Delay\", StringValue(\"1ms\"));"  ./scratch/tcp-low-rate.cc
for i in 10 20 30 40 50 60 70 80 90 100 110 120 130 140 150 160 170 180 190 200 210 220 230 
do	
	echo $i
	sed -i "98c pp2.SetChannelAttribute(\"Delay\", StringValue(\"${i}ms\"));"  ./scratch/tcp-low-rate.cc
	./waf --run scratch/tcp-low-rate
	cp -r PCAPs result_rtt/PCAPs_rtt_$i
done	

