# [autosort-media](https://github.com/Unholy-Scripts/autosort-media)

This script was developed to automatically sorts files based on user-defined parameters.

The core script reads the user's input, and writes a sorting script that will sort and move files.

## Getting Started

The script [sortscriptbuilder.sh](https://github.com/Unholy-Scripts/autosort-media/blob/master/sortscriptbuilder.sh) should always be run as ''sudo''. It will force an exit if it is not. This is because there are commands which require root access within the script. 

## Dependencies

### Expect

This script depends on the expect shell environment as a secondary environment to function properly. In Ubuntu (and other similar distributions) you may run ''apt-get install expect'' to have it installed on your system.

You can find the binary installers here: [Expect](http://www.activestate.com/activetcl/downloads).
You can find the source code here: [Expect](http://sourceforge.net/projects/expect/).

## Contributions 

Contributions are currently appreciated, and welcomed but must be specifically directed at the creator [IONine](https://github.com/IOnine). Once I have established a reasonable system for contributing through the github interface, more instructions will be posted.

## Coming Additions

* Adding automated cronjob scheduler as an option
* Additional paramaterization of categories
* Automatic install of dependencies
* More...

## Current Version

## [autosort-media-v1.1.0]

## Recent Changes

  #### Major Changes
  * Changed scripting methodology to call functions from an outside file
  * Included the majority of functions in config file
  * Added Configuration file to ''/Dep'' directory
  
  #### Minor Changes
  * Version updates
  * Minor Formatting changes

### Honorable Mentions

This was written as a compliment to the creator's installation of https://github.com/autodl-community/autodl-irssi.

Please note that this project is in no way affiliated with autodl-irssi. All credit where credit is due to the 
autodl-community developers.


