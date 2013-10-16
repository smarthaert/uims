This package contains a Unicode support library along with some additional files to use 
WideStrings/Unicode strings within your application. You need Delphi 4 or higher to compile it.

What you get is:

- More than 100 low level and intermediate level functions for:
  + null terminated strings: StrLenW, StrECopyW, StrLICompW etc.
  + WideStrings: WideStringOfChar, WideComposeHangul, WideTitleCase etc.
  + Unicode character test routines: UnicodeIsAlpha, UnicodeIsOpenPunctuation, UnicodeIsRTL etc.
  + conversion: WideStringToUTF8 and vice versa
  + KeyUnicode: conversion of a given ANSI character to Unicode based on the currently active keyboard layout
  + and many more...
- TWideStrings and TWideStringList classes, which work like their ANSI counterparts, but with Unicode.
- A Unicode Tuned Boyer-Moore search engine (UTBM), for fast linear text searches taking surrogates into account. Special options: case sensitivity, ignore non-spacing, space compression, whole words only.
- A comfortable Unicode Regular Expression search engine (URE), implementing most of the Perl 8 RE implementation. This includes:
  + base operators like: . + * ? () {m, n} (unlimited nesting of subexpressions)
  + literals and constants: c, \x..., \U....
  + character classes: [...], [^...], \pN1, N2, ...Nn, \PN1, PN2, ...PNn (examples for these classes are: combining, non-spacing, numdigit, separator, currency symbol). They can be combined with literals and constants like:<br>[abc\U10A\p1,3,4]
   + POSIX classes: :alnum:, :digit:, :upper: etc.
   + the same special options apply here as to the UTBM search engine
- Both search engines are based on the same core class to allow for variable search actions.

There is currently no demo project included but the Unicode edit control which is soon to be released will contain one which makes heavy use of the Unicode library.

This library will be part of the JEDI VCL collection (see also www.delphi-jedi.org) called JCL. According to the rules which apply to this collection the Unicode library is published under the GPL or a similar licence (the final decision is still notmet, as far as I know).


Have fun and

Ciao, Mike

public@lischke-online.de
www.lischke-online.de