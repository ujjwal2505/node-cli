file_path=$1
key_path=$2

file_name=$(basename $file_path)

openssl pkeyutl -encrypt -inkey $key_path -pubin -in $file_path -out $DATAFORTRESS_HOME/encrypted_$file_name
