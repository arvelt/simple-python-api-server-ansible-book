#! /bin/bash

echo -n "username:[default:vagrant]"
read USERNAME
if [ ! ${USERNAME} ]; then USERNAME="nothing"; fi
if [ ${USERNAME} == "nothing" ]; then
    USERNAME="vagrant"
fi

echo "Use ${USERNAME} user"

vars="{
    \"APP_USER_NAME\":\"$USERNAME\",
    \"APP_NAME\":\"hello-flask\"
}"

DIR=$(cd $(dirname $0); pwd)

ansible-galaxy install gdamjan.uwsgi -p ${DIR}
ansible-galaxy install jdauphant.nginx -p ${DIR}
ansible-playbook -i hosts -u ${USERNAME} --extra-vars="${vars}" site.yml
