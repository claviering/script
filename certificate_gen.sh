#! /bin/sh
echo 'step 0: create root private key ...'
echo 'step 1: create root certificate ...'
echo 'step 2: create server private key ...'
echo 'step 3: create server csr ...'
echo 'step 4: Issuance of certificates with root certificates'

# if root.conf exist, delete it
if [ -f root.conf ]
then
  echo 'delete root.conf ...'
  rm root.conf
fi
echo 'create root.conf ...'
echo '[ req ]' >> root.conf
echo 'default_md         = sha384' >> root.conf
echo 'default_keyfile    = root.key' >> root.conf
echo 'prompt             = no' >> root.conf
echo 'distinguished_name = req_distinguished_name' >> root.conf
echo '[ req_distinguished_name ]' >> root.conf
echo 'countryName = "CN"' >> root.conf
echo 'localityName = "GZ"' >> root.conf
echo 'organizationName = "root"' >> root.conf
echo 'organizationalUnitName = "root"' >> root.conf
echo 'commonName = "root certificate"' >> root.conf
echo 'emailAddress = "root@email.com"' >> root.conf

# if server.conf exist, delete it
if [ -f server.conf ]
then
  echo 'delete server.conf ...'
  rm server.conf
fi
echo 'create server.conf ...'
echo '[ req ]' >> server.conf
echo 'default_bits       = 4096' >> server.conf
echo 'default_md         = sha384' >> server.conf
# echo 'encrypt_key        = 123456' >> server.conf
echo 'prompt             = no' >> server.conf
echo 'distinguished_name = dn' >> server.conf
echo '[dn]' >> server.conf
echo 'C = US' >> server.conf
echo 'ST = server' >> server.conf
echo 'L = server' >> server.conf
echo 'O = server' >> server.conf
echo 'OU = server' >> server.conf
echo 'emailAddress = server@email.address' >> server.conf
echo 'CN = server' >> server.conf

# if v3.ext exist, delete it
if [ -f v3.ext ]
then
  echo 'delete v3.ext ...'
  rm v3.ext
fi

echo 'create v3.ext ...'
echo 'authorityKeyIdentifier=keyid,issuer' >> v3.ext
echo 'basicConstraints=CA:FALSE' >> v3.ext
echo 'keyUsage=digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment' >> v3.ext
echo 'subjectAltName=DNS:scnu.club' >> v3.ext
echo '[alt_names]' >> v3.ext
echo 'DNS.1=localhost' >> v3.ext
echo 'DNS.2=example.com' >> v3.ext


echo 'check openssl version ...'
openssl version
openssl ecparam -name secp384r1 -genkey -out root.key
openssl req -x509 -new -config root.conf -key root.key -sha384 -days 3650 -out root.crt
openssl ecparam -genkey -name secp384r1 -out server.key
openssl req -new -config server.conf -key server.key -out server.csr -sha384
openssl x509 -req -in server.csr -CA root.crt -CAkey root.key -CAcreateserial -out server.crt -days 3650 -sha384 -extfile v3.ext

echo 'done ...'

echo '电脑导入根证书，需要重启电脑，使证书生效'
echo 'ssl_certificate      server.crt'
echo 'ssl_certificate_key  server.key'