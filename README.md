<pre>
======================================================================
================ File Numbering Assistant Information ================
======================================================================
====================== Important Note ================================
By reading this information you acknowledge that use of this program
is at your own risk. The creator will not hold responsibility for any
lost files or possible damage. It is recommended that you keep a copy
of any files you wish to modify set aside in such an event.

======================================================================
======================== Description =================================
The original intention for this program was to suppliment
the makemkv application as it is limited in it's ability
to number ripped files.

This program is designed to re-number all files in a folder 
using the last number found in the file names. 

Two modes are offered at the start:

Default mode will simply rename all files in a designated folder 
based on user inputs.

SafeMode will copy all files with the new numbering format and
ask the user to verify that the new file numbering is correct
before deleting the originals, renaming the copies, and closing
the program.

Requirements to run FNA:
	This program requires PowerShell to be installed on your 
	operating system. Windows computers have this by default.

Requirements to run SafeMode:
	2x disk space of files intended to be renamed

======================================================================
=================== How to Run FNA_V1.X.ps1 ==========================
1)Have a folder of files with a numeric numbering system. 
2)Each file number should only have a difference of 1 from the 
  following or preceding file. 

**If this program is run in a folder not using this setup files will be 
improperly named and any without a number will lose their file extension 
and randomly numbered as well.
 
3a)In order to run this program you will have to right click the
   file and select the 'Run with PowerShell' option. 

3b)You can also open Command Prompt and enter:
powershell -ExecutionPolicy Unrestricted C:/[path to file]/FNA_V1.0.ps1

Or you can navigate to the folder's location with the cd command and run:
powershell -ExecutionPolicy Unrestricted ./FNA_V1.0.ps1

'-ExecutionPolicy Unrestricted' is required to run file-based PowerShell
scripts on your computer. It may not be required if you are using
Windows 7 or an earlier version of Windows.

3c)To use as an executable I have included a batch shortcut that will run
   the program as long is it is in the same folder location. This will
   only run if you have PowerShell v1.0 on your system. If you do not, it
   will simply stop running.

4)Following the onscreen prompts. (After all, it's not a user friendly
  program if you have to enter all the settings when calling the 
  executable)

======================================================================
======================== Known Issues ================================
SafeMode:
	The larger the files in the designated folder are, the
	longer it will take to make copies of them.
	- Please be patient for this process to complete. It will
	then ask you for verification on the new file names.

Application:
	When running this program in SafeMode, it will create copies
	in reverse order, last to first. This is normal and will not
	effect the order of the files after the program finishes.

Moving FNA.exe.bat
	If you wish to move FNA.exe.bat somewhere else and keep the 
	.ps1 file in a separate location, edit the .bat file in a
	text editor and change .\FNA_V1.x.ps1 to the full path of
	where you are storing the .ps1 file.
	EX: "C:\Program Files\FNA\FNA_V1.x.ps1"
	
======================================================================
===================== Author's Comments ==============================
As this is a project that was done in my spare time, I cannot
guarantee that it is without errors. 

Please do not try to 'break' this program. It has been designed 
to properly respond in cases of invalid input however, as a 
programmer I can think of several attacks that may work against
it.

Also, please do not modify this program without first asking.

If you find any errors or have any suggestions for improvement
you can contact me at csnmocchi@gmail.com.
======================================================================
</pre>
