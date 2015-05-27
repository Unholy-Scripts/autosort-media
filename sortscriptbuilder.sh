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
# Date           : 05/26/2015                                                  #
#                                                                              #
# Version        : 1.0.1                                                       #
#                                                                              #
# Usage          : bash sortscriptbuilder.sh                                   #
#                                                                              #
# Notes          : This script must be run with sudo to function properly      #
#                                                                              #
# Bash Version   : Tested on version 3.2.57(1)-release (x86_64-apple-darwin14) #
#                  and 4.2.25(1)-release (x86_64-pc-linux-gnu)                 #
#                                                                              #
################################################################################


#######################################################################
#                                                                     #
# This Source Code Form is subject to the terms of the Mozilla Public #
# License, v. 2.0. If a copy of the MPL was not distributed with this #
# file, You can obtain one at http://mozilla.org/MPL/2.0/.            #
#                                                                     #
#######################################################################

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


read -p "Enter your username: [$USER]" -e usrnm;
    usrnm=${usrnm:-$USER} 
    printf "Setting name to $usrnm...\n"

while true;
do

read -e -p "Enter your sudo password: " -s supass; 
    printf "\n"
read -e -p "Enter your sudo password (again): " -s supassv;
    printf "\n"
    [ "$supass" = "$supassv" ] && break 
    printf "Passwords Did Not Match...\n"

done

read -e -p "Enter the rtorrent directory for finished downloads: [$HOME/rtorrent/finished]" findir
    findir=${findir:-$HOME/rtorrent/finished};     ### defines the default value for this variable if no input detected ###
    printf "Setting directory to $findir...\n"

read -e -p "Enter the directory where you want your organized media to go: [$HOME/Media]" meddir; 
    meddir=${meddir:-$HOME/Media};     ### defines the default value for this variable if no input detected ###
    printf "Setting Media directory to $meddir...\n"

read -e -p "Would you like to enable remote transfer of files?? (Yy|Nn)" yn;
    yn=${yn:-Yes};

        if [[ $yn = "Y"* || $yn = "y"* ]]
            then
                RT="ON"
                printf "Enabling Remote transfer of Files.\n"
            else
                RT="OFF"
                printf "Disabling Remote transfer of Files.\n"
        fi
read -e -p "Would you like to remove local files after remote transfer? (Yy|Nn)" rd;

        if [[ $rd = "Y"* || $rd = "y"* ]]
            then
                RD="ON"
                printf "Enabling Cleanup of Files After Transfer.\n"
            else
                RD="OFF"
                printf "Disabling Cleanup of Files After Transfer.\n"
        fi

while [[ "$yn" = "Y"* || "$yn" = "y"* || -z "$yn" ]] ; do
    yn2="Yes"
            case $yn2 in
                Y* | y* ) 
                    read -e -p "Enter your username for the remote destination: [$USER]" remusr; 
                        remusr=${remusr:-$USER};     ### defines the default value for this variable if no input detected ###
                        printf "Setting remote username to $remusr...\n";
                    read -e -p "Enter your password for the remote destination:" -s rempass; 
                        rempass=${rempass:-$PASSWORD};     ### defines the default value for this variable if no input detected ###
                        printf "Setting remote password...\n";
                    read -e -p "Enter the IP Address of the remote location: [127.0.0.1]" addr;
                        addr=${addr:-127.0.0.1};     ### defines the default value for this variable if no input detected ###
                        printf "Setting remote IP Address to $addr...\n";
                    read -e -p "Enter the remote directory where you want to transfer your media to: [$addr/$HOME/Media]" rdest;
                        rdest=${rdest:-$addr/$HOME/Media};     ### defines the default value for this variable if no input detected ###
                        printf "Setting Media directory to $rdest...\n";

                    exec sudo mkdir ~/.ssh || true  ### If the directory exists, it will not create/overwrite, but it will also return 
                                                    ### a status of true to the system, to avoid exiting due to an error
                    exec sudo chmod 700 ~/.ssh

####################################################################################################################################
### This section runs the expect script to automatically establish the ssh connection, and send the RSA key to the remote client ###
####################################################################################################################################

<<expect_eof ./dep/sshest.exp  "$addr" "$rempass" "$remusr" "$HOME" 
expect_eof
            wait $! &

####################################
### End of expect script section ###
####################################


                        printf "Choosing yes to the following option will begin \n"
                        printf "configuration of directories to move media to after \n"
                        printf "sorting has completed. You should choose yes. \n"
                        printf "For parameters please follow this format: \n"
                        printf "If you want to move every folder/directory that \n"
                        printf "contains the string 720p in it's name then the \n"
                        printf "parameter should read *'720p'* . \n"
                        printf "If you are using Autotools' Automove feature to \n"
                        printf "automatically create subdirectories, then simply \n"
                        printf "defining 'Movies' (etc...) as your parameter should \n"
                        printf "effectively move everything within that directory. \n"
                        sleep 4
                        read -e -p "Create Media Directories? [Yes]"
                                    yn3=${yn3:-Yes};
                        case $yn3 in 
                            Y* | y* ) 
                                read -e -p "Provide a Name for the First Media Directory: [Movies]" dirn1;
                                dirn1=${dirn1:-Movies}
                                printf "Setting First Media Directory Name to $dirn1...\n";
                                dir1="$meddir/$dirn1"
                                while [[ -z "$par1" ]]; do
                                    read -e -p "Please define the parameter for this directory [$dirn1]" p1;
                                    p1=${p1:-$dirn1};
                                    printf "Setting Parameter to $p1"
                                    par1="$p1"
                                done
                                read -e -p "Create another? [Yes]" yn4;
                                yn4=${yn4:-Yes};
                                    case $yn4 in 
                                        Y* | y* )
                                            read -e -p "Provide a Name for the Second Media Directory: [TV Shows]" dirn2;
                                                dirn2=${dirn2:-TV\ Shows};
                                                printf "Setting First Media Directory Name to $dirn2...\n";
                                                dir2="$meddir/$dirn2"
                                                    while [[ -z "$par2" ]]; do
                                                        read -e -p "Please define the parameter for this directory [$dirn2]" p2;
                                                        p2=${p2:-$dirn2};
                                                        printf "Setting Parameter to $p2"
                                                        par2="$p2"
                                                    done
                                                read -e -p "Create another? [Yes]" yn5;
                                                yn5=${yn5:-Yes};
                                                    case $yn5 in 
                                                        Y* | y* )
                                                            read -e -p "Provide a Name for the Third Media Directory: [Music]" dirn3;
                                                                dirn3=${dirn3:-Music};
                                                                printf "Setting First Media Directory Name to $dirn3...\n";
                                                                dir3="$meddir/$dirn3"
                                                                    while [[ -z "$par3" ]]; do
                                                                        read -e -p "Please define the parameter for this directory [$dirn3]" p3;
                                                                        p3=${p3:-$dirn3};
                                                                        printf "Setting Parameter to $p3"
                                                                        par3="$p3"
                                                                    done
                                                                yn6=${yn6:-Yes};
                                                                case $yn6 in 
                                                                    Y* | y* )
                                                                        read -e -p "Provide a Name for the Fourth Media Directory: [Kids]" dirn4;
                                                                            dirn4=${dirn4:-Music};
                                                                            printf "Setting First Media Directory Name to $dirn4...\n";
                                                                            dir4="$meddir/$dirn4"
                                                                                while [[ -z "$par4" ]]; do
                                                                                    read -e -p "Please define the parameter for this directory [$dirn4]" p4;
                                                                                    p4=${p4:-$dirn4};
                                                                                    printf "Setting Parameter to $p4"
                                                                                    par4="$p4"
                                                                                done
                                                                            break;
                                                                    ;;
                                                                    N* | n* ) yn="No"; break;;
                                                                    * ) printf "Please Answer Yes or No!\n";
                                                                esac
                                                        ;;
                                                        N* | n* ) yn="No"; break;;
                                                        * ) printf "Please Answer Yes or No!\n";
                                                    esac
                                        ;;
                                        N* | n* ) yn="No"; break;;
                                        * ) printf "Please Answer Yes or No!\n";
                                    esac
                            ;;
                            N* | n* ) yn="No"; break;;
                            * ) printf "Please answer Yes or No!";;
                        esac
                ;;
                N* | n* ) yn="No"; break;;
                * ) printf "Please Answer Yes or No!\n";;
            esac
done

read -e -p "Enter the location for the log to be stored: [$HOME/logs]" tlogv1;
tlogv1=${tlogv1:-$HOME/logs};
logfile="$tlogv1/sortlog.txt"
printf "Logs will be written to $logfile\n"

read -e -p "Enter the location for the script to be placed: [$HOME/scripts]" tscr1;
tscr1=${tscr1:-$HOME/scripts};
scriptfile="$tscr1/sortmedia.sh"
printf "Creating Directory : $tscr1\n"
mkdir $tscr1
printf "Creating Script File : $scriptfile\n"
touch $scriptfile
printf "Giving Script Execute Permissions.\n"
chmod +x "$scriptfile"

cat > $scriptfile <<EOT
#!/bin/bash

#################################################################################
#                                                                               #
# Title          : sortmedia.sh                                                 #
#                                                                               #
# Description    : This script sorts media files based on the defined           #
#                  parameters. Contact the author for specific questions.       #
#                  or consult the autodl-community page on git-hub.             #
#                                                                               #
# Author         : IOnine                                                       #
#                                                                               #
# Contact        : rbleattler@gmail.com (Please use Subject: Media Sort Script) #
#                                                                               #
# Date           : 05/26/2015                                                   #
#                                                                               #
# Version        : 1.0.1                                                        #
#                                                                               #
# Usage          : bash sortscriptbuilder.sh                                    #
#                                                                               #
# Notes          : This script must be run with sudo to function properly       #
#                                                                               #
# Bash Version   : Tested on version 3.2.57(1)-release (x86_64-apple-darwin14)  #
#                  and 4.2.25(1)-release (x86_64-pc-linux-gnu)                  #
#                                                                               #
#################################################################################


#######################################################################
#                                                                     #
# This Source Code Form is subject to the terms of the Mozilla Public #
# License, v. 2.0. If a copy of the MPL was not distributed with this #
# file, You can obtain one at http://mozilla.org/MPL/2.0/.            #
#                                                                     #
#######################################################################


########################################################################
#                                                                      #
# This section defines the variables that will be used in this script. # 
#                                                                      #
########################################################################

findir="$findir"
meddir="$meddir"
addr="$addr"
usrnm="$usrnm"
rdest="$rdest"
logfile="$logfile"
dir1="$dir1"
dir2="$dir2"
dir3="$dir3"
dir4="$dir4"
par1="$par1"
par2="$par2"
par3="$par3"
par4="$par4"
RT="$RT"
RD="$RD"


########################################################################
#                                                                      #
# This section defines the functions that will be used in this script. # 
#                                                                      #
########################################################################

EOT
cat >> $scriptfile <<'EOT'
function sortdir1(){
    for dir in $(find /* $findir/ -maxdepth 1 -type d );
    do
        if [[ "$dir" = "$par1" ]]  
            then
                printf "$(date)   : Moving $dir to $dir3. \n" | tee -a "$logfile"
                mv $dir $dir1
        fi
    done
}

function sortdir2(){
    for dir in $(find /* $findir/ -maxdepth 1 -type d );
    do
        if [[ "$dir" = "$par2" ]]  
            then
                printf "$(date)   : Moving $dir to $dir2. \n" | tee -a "$logfile"
                mv $dir $dir2
        fi
    done
}

function sortdir3(){
    for dir in $(find /* $findir/ -maxdepth 1 -type d );
    do
        if [[ "$dir" = "$par3" ]]  
            then
                printf "$(date)   : Moving $dir to $dir3. \n" | tee -a "$logfile"
                mv $dir $dir3
        fi
    done
}

function sortdir4(){
    for dir in $(find /* $findir/ -maxdepth 1 -type d );
    do
        if [[ "$dir" = "$par4" ]]  
            then
                printf "$(date)   : Moving $dir to $dir4. \n" | tee -a "$logfile"
                mv $dir $dir4
        fi
    done
}

function tarit(){
    tar cvf $1.tar $1 
}

function sendtorem(){

    printf "$(date)  : Creating directories in $rdest.\n" | tee -a "$logfile"
        ssh $remusr@$addr "exec cd $rdest; exec mkdir $dirn1; exec mkdir $dirn2; exec mkdir $dirn3"  | tee -a "$logfile"
    wait $! &

    printf "Tx $(date)  : Copying Stuff\n" | tee -a "$logfile"
        tarit $dir1  | tee -a "$logfile"
        wait $! &
        scp -c arcfour256 -p 22 -o Compression=no $dir1.tar $remusr@$addr:$rdest  | tee -a "$logfile"
        wait $! &  | tee -a "$logfile"
        tarit $dir2  | tee -a "$logfile"
        wait $! &
        scp -c arcfour256 -p 22 -o Compression=no $dir2.tar $remusr@$addr:$rdest   | tee -a "$logfile"
        wait $! &
        tarit $dir3  | tee -a "$logfile"
        wait $! &
        scp -c arcfour256 -p 22 -o Compression=no $dir3.tar $remusr@$addr:$rdest | tee -a "$logfile"
        wait $! &

}

function cleanup(){

    for file in $meddir;
        do
            rm -rf $file
        done
}

function scriptmain(){

    shopt -s nocasematch
    shopt -s nocaseglob

    sortdir1
    sortdir2
    sortdir3
    sortdir4

        if [ $RT = "ON" ]
            then
                sendtorem
        fi

        if [ $RD = "ON" ]
            then
                cleanup
        fi 

    shopt -u nocasematch
    shopt -u nocaseglob
}


########################################################################
#                                                                      #
#                   This section runs the script.                      #
#                                                                      #
########################################################################

scriptmain

exit
EOT

exit