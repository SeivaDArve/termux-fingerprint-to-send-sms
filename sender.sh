#/!bin/bash

# Title: Use fingerprint reader to send an automated sms to any choosen phone number

# Description: This app was created to send a sweet message to girlfriend any time I open the terminal and type 'I <3 U' in this script, that key was changed simplyfied to 'send'
# Use: Requires TERMUX terminal emulator and TERMUX-API for the Android manipulation
# Sugestion: Insrall Termux from the 'f-droid' playstore instead of Google Playstore
# Author: Seiva D'Arve
   # email: flowreshe.seiva.d.arve@gmail.com

function f_set_tmp {
   # Creating a file to store temporary values
      mkdir -p ~/.tmp
      touch ~/.tmp/tmp
}

function f_create_shortcut {
   # Define a keyword to call this app any time, any where in the terminal
      # Change 'send' to any choosen shortcut
      # Change path of the scrip in order to the 'send' command run the fingerprint test before sms dispatch
         echo 'alias send="bash <scrip path here>"' >> ~/.bashrc
}


function f_send {
   # Send sms to specific number
      termux-sms-send -n 910000000 "Many kisses :*"
}

function f_fingerprint {
   # Reads fingerprint

   # Use Termux API to send output of fingerprint to a file
      termux-fingerprint > ~/.tmp/tmp

   # Cut parts of the output
      w=$(tail -n 2 ~/.tmp/tmp)
      echo $w > ~/.tmp/tmp

   # To simplify the test. Get only the field where Permition may be found
      e=$(cat ~/.tmp/tmp | cut -d ' ' -f 2)
      echo $e > ~/.tmp/tmp
}

function f_test {
   # If tested fingerprint is stored on Android, the fingerprit test turns positive and runs

   if [[ $e == '"AUTH_RESULT_FAILURE"' ]]; then
      clear
      echo "Not authorized to send sweet messages to my sweet heart."
   elif [[ $e == '"AUTH_RESULT_SUCCESS"' ]]; then
      clear
      echo "Message sent;) "
      f_send
   fi

}

function f_exec {
   # Runs every function of this script in the corrext sequence

   # Uncomment this function for it to run (do it only once not to flood your ~/.bashrc file with repetitions of this line)
      #f_create_shortcut 
      
   f_set_tmp
   f_fingerprint
   f_test
}
f_exec
