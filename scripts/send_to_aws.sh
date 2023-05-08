file_path=$1
login=$2
key_path=$3

login_user=$(echo $login | cut -d "@" -f1)

sudo scp -i $key_path $file_path $login:/home/$login_user/transfer/
