#!/bin/bash

################################################################################
#                                                                              #
# Title          : sortscriptbuilder.sh                                        #
#                                                                              #
# Description    : This script creates sortmedia.sh. Read header in            #
#                  sortmedia.sh for information on it's Description            #
#                                                                              #
# Author         : IOnine                                                      #
#                                                                              #
# Contact        : rbleattler@gmail.com (Please use Subject: Autodl Script)    #
#                                                                              #
# Date           : 05/27/2015                                                  #
#                                                                              #
# Version        : 1.1.0                                                       #
#                                                                              #
# Usage          : bash sortscriptbuilder.sh                                   #
#                                                                              #
# Notes          : This script must be run with sudo to function properly      #
#                                                                              #
# Bash Version   : Tested on version 3.2.57(1)-release (x86_64-apple-darwin14) #
#                  and 4.2.25(1)-release (x86_64-pc-linux-gnu)                 #
#                                                                              #
################################################################################

## The following is the source file for all functions used below ##

. ./dep/builderconfig.conf

clear               ## Clears the Terminal Window.

version="1.1.0"     ## Defines the current version of this script

#######################################################################
#                                                                     #
# This Source Code Form is subject to the terms of the Mozilla Public #
# License, v. 2.0. If a copy of the MPL was not distributed with this #
# file, You can obtain one at http://mozilla.org/MPL/2.0/.            #
#                                                                     #
#######################################################################


## The following checks for sudo permissions ##

if [ "$EUID" -ne 0 ]
  then echo "Please run as root ('sudo' will suffice)"
  exit
fi

########################################################################
#                                                                      #
#  This section finds out the user specific information to set in the  #
#                               script.                                #
#                                                                      #
########################################################################


setdepperm          ## This function sets permissions for the dependency files.

getuserinfo         ## This function obtains user info for use later in the script.

sshkeygen           ## This function generates an RSA Key.

getdirinfo          ## This function obtains the directories the user wishes to use.

remxfer             ## This function configures the remote transfer functionality.

cleandirset         ## This function determines whether the user would like to enable a file cleanup.

remhostsettings     ## This function obtains remote connection settings for the remote transfer.

sshestablish        ## This function establishes the ssh connection with the remote host.

logset              ## This function determines the location the user wants logs to be saved to.

scriptloc           ## This function determines where the final script will be written to.

writescript         ## This function utilizes all gathered data to write the final script.

### END OF SCRIPT ###

exit