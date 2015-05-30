# [autosort-media](https://github.com/Unholy-Scripts/autosort-media)

This script was developed to automatically sorts files based on user-defined parameters.
The core script reads the user's input, and writes a sorting script that will sort and move files.

The script that you interact with builds an end script which can be used to automatically search a directory for subdirectories using criteria provided by the user during the initial set up, and move those subdirectories based on that criteria. The script also provides the capability to configure automatic upload to a remote client. This is very useful for scouring your **Finished Torrents** folder, analyzing subdirectory names, and moving those subdirectories to a **Media** folder specified during setup.

## The Flow of the Script

![Example of Sorting with filters](/sortmediaflowchart.jpg)

## Getting Started

The script [sortscriptbuilder.sh](https://github.com/Unholy-Scripts/autosort-media/blob/master/sortscriptbuilder.sh) should always be run as ''sudo''. It will force an exit if it is not. This is because there are commands which require root access within the script. 

## Dependencies

### Expect

This script depends on the expect shell environment as a secondary environment to function properly. In Ubuntu (and other similar distributions) you may run ''apt-get install expect'' to have it installed on your system.

In this version of **autosort-media [v1.2.0-beta]** the option to automatically install expect is built in.

You can find the binary installers here: [Expect](http://www.activestate.com/activetcl/downloads).
You can find the source code here: [Expect](http://sourceforge.net/projects/expect/).

## Contributions 

Contributions are currently appreciated, and welcomed but must be specifically directed at the creator [IONine](https://github.com/IOnine). Once I have established a reasonable system for contributing through the github interface, more instructions will be posted.

## Coming Additions

* Adding automated cronjob scheduler as an option
* Metadata analytics and filtering based on these analytics
* More...

## Current Version [autosort-media-v1.2.0-beta]

## Recent Changes
* Massive rework of scripting methodology.

#### Major Changes
* Separated into multiple files, referencing eachother
* Added dependency installer function.
* Added liability waiver
* Increased functionality to expand directories and parameters indefinitely if the user wants.

#### Minor Changes
  * Version updates
  * Minor Formatting changes

### Honorable Mentions

This was written as a compliment to the creator's installation of https://github.com/autodl-community/autodl-irssi.

Please note that this project is in no way affiliated with autodl-irssi. All credit where credit is due to the 
autodl-community developers.


