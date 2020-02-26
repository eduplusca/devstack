#!/usr/bin/env bash
# Provisioning script for the notes service
set -e
set -o pipefail
set -x

# Common provisioning tasks for IDAs, including requirements, migrations, oauth client creation, etc.
./provision-ida.sh edx_notes_api edx-notes 18120 edxnotesapi

# This will build the elasticsearch index for notes.
echo -e "${GREEN}Creating indexes for edx_notes_api...${NC}"
docker exec -t edx.devstack.edxnotesapi bash -c 'source /edx/app/$1/$1_env && cd /edx/app/$1/$1/ && python manage.py rebuild_index --noinput' -- edx_notes_api
