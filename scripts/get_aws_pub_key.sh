login=$1
key_path=$2

login_user=$(echo $login | cut -d "@" -f1)

sudo scp -i $key_path $login:/home/$login_user/transfer/public_key.pem $DATAFORTRESS_HOME/rec_cred/
