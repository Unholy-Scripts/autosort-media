#!/bin/bash
################################################################################
#                                                                              #
# Title          : microfunc.sh                                                #
#                                                                              #
# Description    : This mini script serves as a dependency for the             #
#                  main build script.                                          #
#                                                                              #
# Author         : IOnine                                                      #
#                                                                              #
# Contact        : rbleattler@gmail.com (Please use Subject: Autodl Script)    #
#                                                                              #
# Date           : 05/29/2015                                                  #
#                                                                              #
# Version        : 1.2.0-beta                                                  #
#                                                                              #
# Usage          : N/A                                                         #
#                                                                              #
# Notes          :                                                             #
#                                                                              #
# Bash Version   : Tested on version 3.2.57(1)-release (x86_64-apple-darwin14) #
#                  and 4.2.25(1)-release (x86_64-pc-linux-gnu)                 #
#                                                                              #
################################################################################

. ./dep/builderconfig.conf

K="$md"  ## md is defined by user input, and should always be a numeral.
D="$md"  ## md is defined by user input, and should always be a numeral.
E="$md"  ## md is defined by user input, and should always be a numeral.
R="$md"  ## md is defined by user input, and should always be a numeral.

cat >> $scriptfile <<'EOFUNC' 
########################################################################
#                                                                      #
# This section defines the functions that will be used in this script. # 
#                                                                      #
########################################################################

function tarit(){
    tar cvf $1.tar $1 
}



function sendtorem(){

    printf "$(date)  : Creating directories in $rdest on $addr.\n" | tee -a "$logfile"
EOFUNC        
    
    until (( $K < 1 ));
        do 
        cat >> $scriptfile <<EOFUNC
        ssh \$remusr@\$addr "exec cd \$rdest; if [ ! -e \$dirn$K ] then; exec mkdir \$dirn$K; else; printf "Directory Exists. Exiting ssh!\\n"; fi"  | tee -a "\$logfile"
        wait \$! &
EOFUNC
        (( K-- ))
        done
    until (( $R < 1 ));
        do
        cat >> $scriptfile <<EOFUNC
        printf "Tx \$(date)  : Copying Stuff\\n" | tee -a "\$logfile"
                tarit \$dir$K | tee -a "\$logfile"
                wait \$! &
                scp -c arcfour256 -P 22 -o Compression=no \$dir$K.tar \$remusr@\$addr:\$rdest  | tee -a "\$logfile"
                wait \$! &
EOFUNC
        (( R-- ))
        done

}

cat >> $scriptfile <<'EOFUNC'
function cleanup(){

    for file in $meddir;
        do
            rm -rf $file
        done

    }
EOFUNC


cat >> $scriptfile <<EOFUNC
function scriptmain(){

    shopt -s nocasematch
    shopt -s nocaseglob
EOFUNC

until (( $E < 1 ));
do 
    cat >> $scriptfile <<EOFUNC
    sortdir$E
EOFUNC
(( E-- ))
done

cat >> $scriptfile <<EOFUNC
        if [ \$RT = "ON" ]
            then
                sendtorem
        fi

        if [ \$RD = "ON" ]
            then
                cleanup
        fi 

    shopt -u nocasematch
    shopt -u nocaseglob
}

EOFUNC