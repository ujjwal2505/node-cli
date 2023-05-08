#!/bin/bash

login=$1
key_path=$2

sudo ssh $login -i $key_path source /home/ubuntu/init_setup.sh