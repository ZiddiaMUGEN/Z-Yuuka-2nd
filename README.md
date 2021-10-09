# Z-Yuuka 2nd

Second release of the first 1.1-compatible supernull. This version extends compatibility to 1.0, 1.1a4, and 1.1b1.
Documentation for the supernull technique can be found in the Supernull folder.
Please don't move or rename any of the files starting with `LoadASM` in the character root folder, as these are loaded and run by the supernull.

## Usage

If you want to use the supernull technique yourself, I recommend reading the documentation attached to this character.
However, the most straightforward way to start using it is just to grab the `Supernull.st` file and load it as the `st` file for your character.
This file includes the ROP chain, bootstrap, and loader, so it has everything that's needed to set up a supernull. It will load and execute the `LoadASM*.bin` file from the character's root folder (the file used depends on MUGEN version).
All you need to provide is your custom code in these files.
Note that this version MUST use `st` rather than `st0~9`. We opted for this as `st` is loaded before the indexed files.

## Credits

Warunoyari (mugen.sanso.moe) - providing a method to identify path + load files from the character folder, as well as assisting with expanding the ROP method to be compatible with other versions.

Choon (choon429.blog.fc2.com) - helped with tips for techniques for file loading + some tips for crashes.
