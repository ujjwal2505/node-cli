openssl genrsa -out $DATAFORTRESS_HOME/private_key.pem 1024;
openssl rsa -in $DATAFORTRESS_HOME/private_key.pem -pubout -out $DATAFORTRESS_HOME/public_key.pem;
