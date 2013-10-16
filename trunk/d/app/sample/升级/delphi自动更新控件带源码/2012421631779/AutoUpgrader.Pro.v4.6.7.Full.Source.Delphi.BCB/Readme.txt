########################################################
         ----------------------------------
                  AutoUpgrader Pro
                    SOURCE CODE

             for Delphi and C++ Builder
                   Version 4.6.7
         ----------------------------------

          Legal: (c) 1999-2006 Utilmind Solutions
          Email: info@appcontrols.com
            Web: http://www.appcontrols.com
                 http://www.utilmind.com
########################################################

TABLE OF CONTENTS

    1. Welcome / Introduction
        1.1 Compatiblity
    2. Installation
        2.1. Note for C++ Builder developers
    3. Problems

1. Welcome
----------------------------------------------------
Advanced AutoUpgrader component which allows to make your software
"auto-upgradable" software without single line of code! It contains
built-in "Application Update Wizard", built-in multi-language
support (it automatically recognize language used on user's PC and
displays all messages in native language). The AutoUpgrader can
download your files either from the Web or local intraweb.

Current version automatically translates all wizard's contents to 27
languages: English, Spanish, German, French, Russian, Portuguese, Italian,
Dutch, Danish, Finnish, Chinese and many others. However, if you
don't want to use built-in Wizard, you still can make customized
progress-dialogs using numerous events.

If you store newer version of your program in password protected Web
directories, you can pre-configure the username/password to access files, or
let the AutoUpgrader to prompt login information from user when it's necessary.

With AutoUpgrader your customers will use only latest versions of your
software! Package contains two bonus components from AppControls pack:
auHTTP (WinInet-based HTTP client which also supports file uploading,
introduced in RFC1867, Internet Explorer's cache etc) and auThread (easy to
use thread component which also works on ActiveForms of D6 and D7).


1.1 Compatibility
=================
AutoUpgrader compatible with Delphi 2/3/4/5/6/7/2005, BDS 2006 and BCB 3/4/5/6,
has been tested on Win95, Win95OSR2, Win98, WinME, NT4, Win2K and WinXP.


2. Installation
----------------------------------------------------
 1. Unzip files from "Sources" directory to your "..\Lib" directory.
 2. Start Delphi / C++ Builder IDE.
 3. Select "File | Open" menu item and point to "AutoUpgraderProDx.dpk" or
    "AutoUpgraderProCBx.bpk" ('x' is the version of Delphi or BCB).
    Note: Delphi 2 users please select "Component | Install..." menu item,
    add "_AUReg.pas" file and rebuild the library.
 4. Click "Compile" button in the package box to compile source files,
    then "Install" button to install it to the component palette.

NOTE: Delphi 2 requires "WinInet.pas" unit which can be found in
"Sources\Delphi2" directory. Please copy it to "..\Lib" directory too
if you're using Delphi 2.


2.1. Note for C++ Builder developers
===============================
When you are using the Internet components (i.e: auHTTP, auAutoUpgrader)
don't forget to add INET.LIB (WININET.LIB for BCB6) to your project
(it can be found at "CBuilder\Lib" directory). This file contains the
references to routines from WinInet.dll. So if you got linker error
such like following:
  [Linker Error] Unresolved external 'InternetCrackUrlA' referenced from
  C:\PROGRAM FILES\BORLAND\CBUILDER5\PROJECTS\LIB\AUTOUPGRADERPROCB5.LIB
please don't worry and be aware that InternetCrackUrlA are used to parse
the URL (split URL to domain name, port, document name etc). To solve
this problem, just add INET.LIB to your project (use "Project | Add to
project" menu item in C++ Builder IDE).


3. Problems
----------------------------------------------------
If you have any problems during the setup or using this
component, please visit the support area of our website
at http://www.appcontrols.com or contact us: info@appcontrols.com

    
Good Luck!

UtilMind Solutions
info@utilmind.com
http://www.utilmind.com
http://www.appcontrols.com
