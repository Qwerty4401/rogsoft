#!/bin/sh

# build script for rogsoft project

VERSION=1.9.1.9

echo $VERSION > ./softcenter/.soft_ver

cat version
rm -f softcenter.tar.gz
mkdir -p ./softcenter/res

python ./gen_install.py stage1

chmod 755 ./softcenter/scripts/ks_app_install.sh

tar -zcvf softcenter.tar.gz softcenter
cp -rf softcenter.tar.gz koolcenter.tar.gz
md5value=`md5sum softcenter.tar.gz|tr " " "\n"|sed -n 1p`
cat > ./version <<EOF
$VERSION
$md5value
EOF
cat version

cat > ./config.json.js <<EOF
{
"version":"$VERSION",
"md5":"$md5value"
}
EOF

python ./gen_install.py stage2

cat to_remove.txt|xargs rm -f
rm to_remove.txt
