#!/usr/bin/expect -f

set addr        [lindex $argv 0]
set password    [lindex $argv 1]
set remusr      [lindex $argv 2]
set HOME        [lindex $argv 4]

set timeout -1

spawn ssh-keygen -b 2048 -t rsa -f $HOME/.ssh/id_rsa -q -N ""
expect {
        "*exists*"
        {
                exp_send "n\r"
                exp_continue
        }
}

spawn ssh-copy-id $remusr@$addr
expect {
        "*assword*"
                {
                    exp_send "$password\r"
                    exp_continue
                }

        }

spawn ssh $remusr@$addr
send "exit\r"


#expect_eof