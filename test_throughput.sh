#!/bin/bash
mkdir result_RTO
echo "test start" 
#sed -i "109c TimeValue (Seconds (2.0))," ./src/internet/model/tcp-socket-base.cc
sed -i "62c #define ATTACKER_RATE (std::string)\"12000kb/s\"" ./scratch/tcp-low-rate.cc
for k in 15 20 25
do
m=0
sed -i "63c #define ON_TIME (std::string)\"0.$k\"" ./scratch/tcp-low-rate.cc
if [ $k -eq 25 ];then
        sed -i "62c #define ATTACKER_RATE (std::string)\"7000kb/s\"" ./scratch/tcp-low-rate.cc 
fi      
for i in 0.5 0.8 1.0 1.2 1.4 1.6 1.8 2.0 
do      
#       cd /home/chuck/Project/ns3/Low-Rate-TCP-DoS-Attack-master
        echo $i
        sed -i "64c #define BURST_PERIOD $i"  ./scratch/tcp-low-rate.cc
        ./waf --run scratch/tcp-low-rate
        let "m++"
        cp -r PCAPs result_RTO/PCAPs$k$m
done    
done

