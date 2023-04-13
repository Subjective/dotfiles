#!/bin/sh

NVIM_PROFILE_NAME=""
NVIM_COMMAND="nvim"

exec env NVIM_APPNAME="${NVIM_PROFILE_NAME}" \
     ${NVIM_COMMAND} \
     "$@"
