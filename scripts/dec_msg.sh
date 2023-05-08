#/bin/bash

login=$1
key_path=$2
transfer_file_name=$3

# Run the commands on the remote server
ssh -i ${key_path} ${login} "cd ~/transfer && \
    openssl pkeyutl -decrypt -inkey private_key.pem -in encrypted_aes256.key | openssl enc -d -aes-256-cbc -pbkdf2 -in encrypted_$transfer_file_name -out ${transfer_file_name} -pass stdin"