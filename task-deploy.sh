#!/bin/bash

#install wget
Wget=$(which wget)
if [[ -z ${Wget} ]]; then
   echo "wget installation"
   sudo apt-get install -y wget
fi
wget https://github.com/WorkflowCenter-Repositories/ToolsInstallationScripts/raw/master/tools-install.sh

chmod u+x tools-install.sh
. ./tools-install.sh

sudo service docker start

  echo "deploy the workflow"
   if [[ -d ~/SAMTools-Picard ]]; then
      echo "previous workflow execution exists and will be deleted"
      rm -r ~/SAMTools-Picard 
   fi
  cfy local init --install-plugins -p SAMTools-Picard.yaml --input input.yaml

cfy local execute -w install
