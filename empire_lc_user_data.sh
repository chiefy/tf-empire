#!/bin/bash
ECS_CONFIG=/etc/ecs/ecs.config

echo ECS_CLUSTER="empire" >> $ECS_CONFIG
echo ECS_ENGINE_AUTH_TYPE=docker >> $ECS_CONFIG
echo ECS_ENGINE_AUTH_DATA=\"{}\" >> $ECS_CONFIG

mkdir -p /home/ec2-user/.docker && echo "{}" >> /home/ec2-user/.docker/config.json
