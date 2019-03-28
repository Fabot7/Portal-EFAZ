#!/bin/bash

CONFIG_CMSSETUP=resources/config/cmssetup.txt


echo ${CONFIG_CMSSETUP}

if [ -f "${CONFIG_CMSSETUP}" ]; then
    echo "Applying custom OpenCms setup script ${CONFIG_CMSSETUP}"
    mv -v "${CONFIG_CMSSETUP}" "${WEBAPPS_HOME_INSTALL}/ROOT/WEB-INF/setupdata/"
else
   echo "No custom OpenCms setup script found!"
fi
