unit mshtml_stuff;

{ This unit provides simple functions and procedures to enable simple editing
  functions on a TwebBrowser or TembededdWB component which is being used for
  interactive editing.

  Each of the routines is briefly explained in the body of the unit.

  Please use if useful, I've taken all care but all the responsability for using this
  unit is yours.

  GNU license.

  Paul A Norman   http://PaulANorman.com   106121.717@compuserve.com }

interface

uses
 SysUtils,comctrls, menus, SHDocVw_TLB, mshtml_tlb, EmbeddedWB;

function editable(editor:tembeddedWB) : string; overload;
function editable(editor:twebbrowser) : string; overload;

procedure makeEditable(editor:tembeddedWB); overload;
procedure makeEditable(editor:twebbrowser);  overload;

procedure selPasteHtml(editor:twebbrowser;HTML :string); overload;
procedure selPasteHtml(editor:tembeddedWB;HTML :string); overload;

function selHtml(editor:twebbrowser) :string; overload;
function selHtml(editor:tembeddedWB) :string; overload;

function selText(editor:tembeddedWB) :string; overload;
function selText(editor:twebbrowser) :string; overload;

function selTextRange(editor:twebbrowser) : olevariant; overload;
function selTextRange(editor:tembeddedWB) : olevariant; overload;

function selSelection(editor:twebbrowser):olevariant; overload;
function selSelection(editor:tembeddedWB):olevariant; overload;

function selBodyRange(editor:twebbrowser):olevariant; overload;
function selBodyRange(editor:tembeddedWB):olevariant; overload;

procedure selCurrentTag(editor:tembeddedWB); overload;
procedure selCurrentTag(editor:twebbrowser); overload;

function selType(editor:tembeddedWB) :string; overload;
function selType(editor:twebbrowser) :string; overload;


procedure ToolButtonPlainClick(editor:tembeddedWB;Sender: TObject);overload;
procedure ToolButtonPlainClick(editor:twebbrowser;Sender: TObject);overload;

function returnSelect(editor:tembeddedWB):olevariant; overload;
function returnSelect(editor:twebbrowser):olevariant; overload;


      var
          currentTag:olevariant;

implementation

   // if you use tool buttons or menu items with the hint set to words like
   // (no quote marks) "Justify Full"  "Bold" "Underline" etc ..
   // then this routine will implement the commnads
   // (see mk:@MSITStore:c:\ [somewhere] inet.chm::/workshop/author/dhtml/reference/commandids.htm
   //   leave the "IDM_" portion off.
   //
   //Allows for the Delphi 7 happening where the menu items are often auto '&'-ed
   //If it happens to you you'll know about it.
procedure ToolButtonPlainClick(editor:tembeddedWB;Sender: TObject);
 var cmd :string;
begin
  // using hint string as command verb so first remove all spaces and any ampersands
  // from hint string
  if (sender is TToolButton) then
CMD :=stringreplace((Sender as TToolButton).Hint,#32,'',[rfreplaceall])
 else
   if (sender is Tmenuitem) then
CMD :=stringreplace((Sender as Tmenuitem).caption,#32,'',[rfreplaceall]);
CMD :=stringreplace(CMD,'&','',[rfreplaceall]);

if returnSelect(editor).queryCommandEnabled(CMD) then
   returnSelect(editor).execCommand(CMD,false,true);
end;

procedure ToolButtonPlainClick(editor:twebbrowser;Sender: TObject);
 var cmd :string;
begin
  // using hint string as command verb so first remove all spaces  and any ampersands
  // from hint string
  if (sender is TToolButton) then
CMD :=stringreplace((Sender as TToolButton).Hint,#32,'',[rfreplaceall])
 else
   if (sender is Tmenuitem) then
CMD :=stringreplace((Sender as Tmenuitem).caption,#32,'',[rfreplaceall]);
CMD :=stringreplace(CMD,'&','',[rfreplaceall]);

if returnSelect(editor).queryCommandEnabled(CMD) then
   returnSelect(editor).execCommand(CMD,false,true);
end;

         // returns  a range from a selected area
function returnSelect(editor:tembeddedWB):olevariant;
var selected :olevariant;
begin
        selected :=
editor.OleObject.document.selection.createRange;

      returnSelect := selected;
end;

function returnSelect(editor:twebbrowser):olevariant;
var selected :olevariant;
begin
        selected :=
editor.OleObject.document.selection.createRange;

      returnSelect := selected;
end;

         // returns a string telling you what kind of thing is selected
         // None or Text or Control
function selType(editor:twebbrowser) :string;
begin
    result := selSelection(editor).type;
end;

function selType(editor:tembeddedWB) :string;
begin
    result := selSelection(editor).type;
end;


         // creates a textRange over a selected portion of text
         // establishes what the parent (enclosing) <tag> is
         // moves the textRange to those limits and
         // shows the new textRangs as a selection.
         //
         // Also sets the Global varible (in this unit's var clause) currentTag
         //  as the current tag.
         //
         //  (You can do things like:
         //          currentTag.style.border := 'solid 1pt black';
         //       showmessage(currentTag.style.cssText);
procedure selCurrentTag(editor:twebbrowser);
var textRange:olevariant;
begin
         textRange := selTextRange(editor);
       currentTag := textRange.parentElement;
        TextRange:= selBodyRange(editor);
        TextRange.moveToElementText(currentTag);
        TextRange.select;
end;

procedure selCurrentTag(editor:tembeddedWB);
var textRange:olevariant;
begin
         textRange := selTextRange(editor);
       currentTag := textRange.parentElement;
        TextRange:= selBodyRange(editor);
        TextRange.moveToElementText(currentTag);
        TextRange.select;
end;


        // returns a textrange object created on the document Body
function selBodyRange(editor:twebbrowser):olevariant;
begin
result:=    editor.OleObject.document.body.createTextRange;
end;

function selBodyRange(editor:tembeddedWB):olevariant;
begin
result:=    editor.OleObject.document.body.createTextRange;
end;


            // returns the selection object
            // exposed by the document object
function selSelection(editor:tembeddedWB):olevariant;
begin
    result := editor.OleObject.document.selection;
end;

function selSelection(editor:twebbrowser):olevariant;
begin
    result := editor.OleObject.document.selection;
end;


        // returns the Range represented by a selection
function selTextRange(editor:twebbrowser) : olevariant;
begin
    result := selSelection(editor).createRange;
end;

function selTextRange(editor:tembeddedWB) : olevariant;
begin
    result := selSelection(editor).createRange;
end;


       // returns the plain Text in a selected area
function selText(editor:tembeddedWB) :string;
begin
   result:=selTextRange(editor).text;
end;

function selText(editor:twebbrowser) :string;
begin
   result:=selTextRange(editor).text;
end;


      // returns the HTML underlying a selected area
function selHtml(editor:twebbrowser) :string;
begin
   result := selTextRange(editor).htmlText;
end;

function selHtml(editor:tembeddedWB) :string;
begin
   result := selTextRange(editor).htmlText;
end;


      // Replaces the selected text underlying HTML with the HTML you
      // Supply
procedure selPasteHtml(editor:twebbrowser;HTML :string);
begin
    seltextRange(editor).pasteHTML(HTML);
end;

procedure selPasteHtml(editor:tembeddedWB;HTML :string);
begin
    seltextRange(editor).pasteHTML(HTML);
end;
   

     //tells you if the BODY tag is set for user editing
function editable(editor:tembeddedWB) : string;
begin
    result :=editor.OleObject.document.body.contentEditable;
end;

function editable(editor:twebbrowser) : string;
begin
    result :=editor.OleObject.document.body.contentEditable;
end;



     //tells you if the BODY tag is set for user editing
procedure makeEditable(editor:tembeddedWB);
begin
  editor.OleObject.document.body.contentEditable := true;
end;

procedure makeEditable(editor:twebbrowser) ;
begin
    editor.OleObject.document.body.contentEditable := true;
end;


end.
