file_path=$1
key_path=$2

file_name=$(basename $file_path)

openssl enc -e -aes-256-cbc -pbkdf2 -in $file_path -out $DATAFORTRESS_HOME/encrypted_$file_name -kfile $key_path
