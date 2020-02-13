#!/bin/bash

echo "init-env.sh@sh: v2.1, 20190321"
## Variables
# Write down the data required in .env file here for initiation.
ENVFILENAME=.env
ENVFILECONTENTS=(
  "TZ="
  "SRVNAME="
  "# USERS: required arg: \"<username>;<passwd>\""
  "# <username> for user"
  "# <password> for user"
  "# [ID] for user"
  "# [group] for user"
  "# multiple user format: example1;badpass:example2;badpass"
  "USERS="
  "# MOUNTS: Configure a share"
  "# required arg: \"<name>;</path>\""
  "# <name> is how it's called for clients"
  "# <path> path to share"
  "# NOTE: for the default value, just leave blank"
  "# [browsable] default:'yes' or 'no'"
  "# [readonly] default:'yes' or 'no'"
  "# [guest] allowed default:'yes' or 'no'"
  "# [users] allowed default:'all' or list of allowed users"
  "# [admins] allowed default:'none' or list of admin users"
  "# [writelist] list of users that can write to a RO share"
  "# [comment] description of share"
  "# multiple mount format: example1 private share;/example1;no;no;no;example1:example2 private share;/example2;no;no;no;example2"
  "MOUNTS="
  "WORKGROUPNAME=WORKGROUP"
  )

## Script
echo "Initiating ${ENVFILENAME} file."; if [[ ! -f ${ENVFILENAME} ]] || ( echo -n ".env file already initiated. You want to override? [ y/N ]: " && read -r OVERRIDE && echo ${OVERRIDE::1} | grep -iqF "y" ); then echo "Will rewrite the .env file with the default one."; > ${ENVFILENAME} && for i in "${ENVFILECONTENTS[@]}"; do echo $i >> ${ENVFILENAME}; done; echo "All done."; else echo "File already exists with no overwrite permission given."; echo "Not doing anything."; fi