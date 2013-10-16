
 THttpScan VCL component for Delphi or C++Builder  
 ------------------------------------------------

 version      : 4.02
 date         : December 16, 2001
 restriction  : THIS REGISTERED VERSION CANNOT BE DISTRIBUTED
 home page    : http://www.delphicity.com
 support      : support@delphicity.com


 Note to C++Builder users:
 ------------------------
 Add a 
 #pragma link "inet.lib" 
 statement at the top of your main cpp file.


 INSTALL
 -------

 1. If a previous THttpScan package is already installed, 
   remove it first:

   - Components | Install Packages,

   - click on "DelphiCity THttpScan",

   - click "Remove",

   - click "Yes",

   - click "Ok",

   - search for "HttpScan.*" and "TH*.*" files in your Borland 
     directories and delete them, to be certain that old units will
     not remain in the search paths (causing later raw errors). 


 2. Install the current package:

    - unzip the archive in a folder of your choice,

    - according to your Delphi or C++Builder version, copy all 
      the Delphi\*.* or CBuilder\*.* archive files to 
      the Borland\Delphi\Imports or \Borland\CBuilder\Imports directory,

    - run Delphi or C++Builder,

    - select Component | Install packages,

    - press the "Add" button,

    - locate the HttpScan.bpl file in the Imports directory and select it,

    - select Open,

    - select Ok,

    - check the Delphicity tab in the right of the component palette. 
      The THttpScan object should have been added.


