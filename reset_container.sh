#!/bin/bash
containerId=`docker ps -l | awk 'NR>1 {print $1}'`
if [ -n "$containerId" ]; then
	docker stop $containerId
	docker rm $containerId
fi
