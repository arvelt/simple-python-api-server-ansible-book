#! /bin/bash

echo -n "username:[default:vagrant]"
read USERNAME
if [ ! ${USERNAME} ]; then USERNAME="nothing"; fi
if [ ${USERNAME} == "nothing" ]; then
    USERNAME="vagrant"
    echo "Use vagrant user"
fi

vars="{
    \"APP_USER_NAME\":\"$USERNAME\",
    \"APP_REPOSITORY\":\"https://github.com/arvelt/hello-flask.git\"
}"
DIR=$(cd $(dirname $0); pwd)

ansible-galaxy install gdamjan.uwsgi -p ${DIR}
ansible-galaxy install jdauphant.nginx -p ${DIR}
ansible-galaxy install vitalk.flaskapp -p ${DIR}
ansible-playbook -i hosts -u ${USERNAME} --extra-vars="${vars}" site.yml
