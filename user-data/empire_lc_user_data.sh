#!/bin/bash
echo ECS_CLUSTER=${cluster} >> /etc/ecs/ecs.config
echo ECS_ENGINE_AUTH_TYPE=dockercfg >> /etc/ecs/ecs.config
echo ECS_ENGINE_AUTH_DATA="{\"${registry}\": {\"auth\": \"${auth}\",\"email\": \"${email}\"}}" >> /etc/ecs/ecs.config
echo "{\"${registry}\": {\"auth\": \"${auth}\",\"email\": \"${email}\"}}" >> /home/ec2-user/.dockercfg
