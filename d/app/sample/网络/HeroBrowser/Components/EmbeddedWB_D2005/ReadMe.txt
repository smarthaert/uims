EmbeddedWb is a component that demonstrates an easy way to implement IDocHostUIHandler and IDocHostShowUI with TWebbrowser.
Please read the credits file to find "who did What" !!
If you use this components or any code part you do it on your own responcebility!!
Ther is no guarenty what so ever for none!
Please credeit the creators and the contributors.

Idispatch is added to demonstrate Idochostuihandler.GetExternal and to show how DISPID_AMBIENT_DLCONTROL can be used to control what the webbrowser download and execute.

On http://www.euromind.com/iedelphi/embeddedwb.htm   web-site you can find samples showing how to use some of the added functions. The page is still under construction, so check the updates page

If you find the component useful, please e-mail some additional samples to post on this webpage, bug report/fix or suggestions for enhancements.

Most components and samples on this website make use of Microsoft HTML Object Library and Microsoft Shell Doc Object and  Control Library.

EmbeddedWB adds a lot of new functions to TWebbrowser Component. Before Installing EmbeddedWB you must have TWebbrowser  
Installed.(Its OK, Usually its already installed in d2005)

TWebBrowser draws on the WebBrowser functionality of Microsoft’s Shell Doc Object and Control Library (SHDOCVW.DLL) to  Allow you to create a customized Web browsing application or to add Internet, file and network browsing, document Viewing and data downloading capabilities to your Delphi applications.

Delphi 2005 Updates:
============================
Added more FreeWare components to the packege like: 
SecurityManager, IETravelLog, IEDownload, IECache, IEAddress, IE5tools.
Added a folder name Accessories_Files which contain extra files for advanced users

Changes referring to Delphi 2005
New procedures like:
Navigate to url (without adding info to the catch);
MailTheUrl (option to the mail the page URL/title);
And so on...

Favorites components were adapted to d 2005 and to Embedded web browser
Added also a DoubleClick event to the Favorites Tree.

IEAddress - Fixed the flicker bug

ieConst added new needed constants;

ieUtils added new functions like

Extract URL’s (More options to extract the URL’s from favorites and so on);
GetCookiesPath;
GetFavoritesPath;
GetHistoryPath;
GetMailClients (to find mail clients from registry)
And so on...

Install:
=============
Copy the folder with the component to:   "C:\Program Files\Borland\BDS\3.0\lib\"
Borland-->Open--> (browse to "C:\Program Files\Borland\BDS\3.0\lib\") choose "EmbeddedWBD9.bdsproj"
In the project manager stand on "embeddedWBD9.bpl" -->right Click -->Build -->right Click again--> install;
Do not save the changes.
Add the component to the search path by: Borland -->Tools--> Options--> go to Delphi options-->libraery-Win32 --> on the top right you will find Library path. Press on the browse button and add the corresponding folder by pressing OK on the EmbeddedWD folder.

Reinstall/Remove:
===================
Borland-->Component-->install Package--> Choose Embedded Web Browser, and press Remove.
Close Borland IDE
With Window Explorer go to the path: c:\\... \My Documents\Borland Studio Projects\Bpl or where your bpl files are,
And delete EmbeddedWBD9 files.
Start Borland IDE.
Now you can reinstall.
Have Fun.



