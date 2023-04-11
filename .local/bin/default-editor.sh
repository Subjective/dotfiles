#!/bin/sh

NVIM_PROFILE_NAME="astro3"
NVIM_COMMAND="nvim"

exec env NVIM_APPNAME="nvim-profiles/${NVIM_PROFILE_NAME}" \
     ${NVIM_COMMAND} \
     "$@"
