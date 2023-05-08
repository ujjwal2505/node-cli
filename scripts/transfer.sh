#!/bin/bash

transfer_file_path=$1
login_name=$2
aws_private_key_path=$3
transfer_file_name=$(basename $transfer_file_path)

export DATAFORTRESS_SRC=$( dirname "$(realpath $0)" )
export DATAFORTRESS_HOME=$HOME/transfer

echo "init_setup.sh"
source $DATAFORTRESS_SRC/init_setup.sh

echo "init_aws_setup.sh"
source $DATAFORTRESS_SRC/init_aws_setup.sh $login_name $aws_private_key_path

echo "gen_aes_key.sh"
source $DATAFORTRESS_SRC/gen_aes_key.sh

echo "gen_key_pair.sh"
source $DATAFORTRESS_SRC/gen_key_pair.sh

echo "enc_file_aes.sh"
source $DATAFORTRESS_SRC/enc_file_aes.sh $transfer_file_path $DATAFORTRESS_HOME/aes256.key

echo "get_aws_pub_key.sh"
source $DATAFORTRESS_SRC/get_aws_pub_key.sh $login_name $aws_private_key_path

echo "enc_file_rsa.sh"
source $DATAFORTRESS_SRC/enc_file_rsa.sh $DATAFORTRESS_HOME/aes256.key $DATAFORTRESS_HOME/rec_cred/public_key.pem

echo "send_to_aws.sh"
source $DATAFORTRESS_SRC/send_to_aws.sh $DATAFORTRESS_HOME/encrypted_aes256.key $login_name $aws_private_key_path

source $DATAFORTRESS_SRC/send_to_aws.sh $DATAFORTRESS_HOME/encrypted_$transfer_file_name $login_name $aws_private_key_path

echo "dec_msg.sh"
source $DATAFORTRESS_SRC/dec_msg.sh $login_name $aws_private_key_path $transfer_file_name