unit DateCn;

interface

uses Windows, SysUtils, Controls;
//download by http://www.codefans.net
const
  BaseAnimalDate = '1972';
  BaseSkyStemDate = '1974';
  START_YEAR = 1901;
  END_YEAR = 2050;

  gLunarHolDay: array[0..1799] of Byte = (
    $96, $B4, $96, $A6, $97, $97, $78, $79, $79, $69, $78, $77,
    $96, $A4, $96, $96, $97, $87, $79, $79, $79, $69, $78, $78,
    $96, $A5, $87, $96, $87, $87, $79, $69, $69, $69, $78, $78,
    $86, $A5, $96, $A5, $96, $97, $88, $78, $78, $79, $78, $87,
    $96, $B4, $96, $A6, $97, $97, $78, $79, $79, $69, $78, $77,
    $96, $A4, $96, $96, $97, $97, $79, $79, $79, $69, $78, $78,
    $96, $A5, $87, $96, $87, $87, $79, $69, $69, $69, $78, $78,
    $86, $A5, $96, $A5, $96, $97, $88, $78, $78, $69, $78, $87,
    $96, $B4, $96, $A6, $97, $97, $78, $79, $79, $69, $78, $77,
    $96, $A4, $96, $96, $97, $97, $79, $79, $79, $69, $78, $78,
    $96, $A5, $87, $96, $87, $87, $79, $69, $69, $69, $78, $78,
    $86, $A5, $96, $A5, $96, $97, $88, $78, $78, $69, $78, $87,
    $95, $B4, $96, $A6, $97, $97, $78, $79, $79, $69, $78, $77,
    $96, $B4, $96, $A6, $97, $97, $79, $79, $79, $69, $78, $78,
    $96, $A5, $97, $96, $97, $87, $79, $79, $69, $69, $78, $78,
    $96, $A5, $96, $A5, $96, $97, $88, $78, $78, $79, $77, $87,
    $95, $B4, $96, $A6, $96, $97, $78, $79, $78, $69, $78, $87,
    $96, $B4, $96, $A6, $97, $97, $79, $79, $79, $69, $78, $77,
    $96, $A5, $97, $96, $97, $87, $79, $79, $69, $69, $78, $78,
    $96, $A5, $96, $A5, $96, $97, $88, $78, $78, $79, $77, $87,
    $95, $B4, $96, $A5, $96, $97, $78, $79, $78, $69, $78, $87,
    $96, $B4, $96, $A6, $97, $97, $79, $79, $79, $69, $78, $77,
    $96, $A4, $96, $96, $97, $87, $79, $79, $69, $69, $78, $78,
    $96, $A5, $96, $A5, $96, $97, $88, $78, $78, $79, $77, $87,
    $95, $B4, $96, $A5, $96, $97, $78, $79, $78, $69, $78, $87,
    $96, $B4, $96, $A6, $97, $97, $78, $79, $79, $69, $78, $77,
    $96, $A4, $96, $96, $97, $87, $79, $79, $79, $69, $78, $78,
    $96, $A5, $96, $A5, $96, $96, $88, $78, $78, $78, $87, $87,
    $95, $B4, $96, $A5, $96, $97, $88, $78, $78, $79, $77, $87,
    $96, $B4, $96, $A6, $97, $97, $78, $79, $79, $69, $78, $77,
    $96, $A4, $96, $96, $97, $87, $79, $79, $79, $69, $78, $78,
    $96, $A5, $96, $A5, $96, $96, $88, $78, $78, $78, $87, $87,
    $95, $B4, $96, $A5, $96, $97, $88, $78, $78, $69, $78, $87,
    $96, $B4, $96, $A6, $97, $97, $78, $79, $79, $69, $78, $77,
    $96, $A4, $96, $96, $97, $97, $79, $79, $79, $69, $78, $78,
    $96, $A5, $96, $A5, $96, $96, $88, $78, $78, $78, $87, $87,
    $95, $B4, $96, $A5, $96, $97, $88, $78, $78, $69, $78, $87,
    $96, $B4, $96, $A6, $97, $97, $78, $79, $79, $69, $78, $77,
    $96, $A4, $96, $96, $97, $97, $79, $79, $79, $69, $78, $78,
    $96, $A5, $96, $A5, $96, $96, $88, $78, $78, $78, $87, $87, 
    $95, $B4, $96, $A5, $96, $97, $88, $78, $78, $69, $78, $87,
    $96, $B4, $96, $A6, $97, $97, $78, $79, $79, $69, $78, $77,
    $96, $A4, $96, $96, $97, $97, $79, $79, $79, $69, $78, $78,
    $96, $A5, $96, $A5, $A6, $96, $88, $78, $78, $78, $87, $87,
    $95, $B4, $96, $A5, $96, $97, $88, $78, $78, $79, $77, $87,
    $95, $B4, $96, $A6, $97, $97, $78, $79, $78, $69, $78, $77,
    $96, $B4, $96, $A6, $97, $97, $79, $79, $79, $69, $78, $78,
    $96, $A5, $A6, $A5, $A6, $96, $88, $88, $78, $78, $87, $87,
    $A5, $B4, $96, $A5, $96, $97, $88, $79, $78, $79, $77, $87,
    $95, $B4, $96, $A5, $96, $97, $78, $79, $78, $69, $78, $77,
    $96, $B4, $96, $A6, $97, $97, $79, $79, $79, $69, $78, $78,
    $96, $A5, $A6, $A5, $A6, $96, $88, $88, $78, $78, $87, $87,
    $A5, $B4, $96, $A5, $96, $97, $88, $78, $78, $79, $77, $87,
    $95, $B4, $96, $A5, $96, $97, $78, $79, $78, $68, $78, $87,
    $96, $B4, $96, $A6, $97, $97, $78, $79, $79, $69, $78, $77,
    $96, $A5, $A5, $A5, $A6, $96, $88, $88, $78, $78, $87, $87,
    $A5, $B4, $96, $A5, $96, $97, $88, $78, $78, $79, $77, $87,
    $95, $B4, $96, $A5, $96, $97, $88, $78, $78, $69, $78, $87,
    $96, $B4, $96, $A6, $97, $97, $78, $79, $79, $69, $78, $77,
    $96, $A4, $A5, $A5, $A6, $96, $88, $88, $88, $78, $87, $87,
    $A5, $B4, $96, $A5, $96, $96, $88, $78, $78, $78, $87, $87,
    $96, $B4, $96, $A5, $96, $97, $88, $78, $78, $69, $78, $87,
    $96, $B4, $96, $A6, $97, $97, $78, $79, $79, $69, $78, $77,
    $96, $A4, $A5, $A5, $A6, $96, $88, $88, $88, $78, $87, $87,
    $A5, $B4, $96, $A5, $96, $96, $88, $78, $78, $78, $87, $87,
    $95, $B4, $96, $A5, $96, $97, $88, $78, $78, $69, $78, $87,
    $96, $B4, $96, $A6, $97, $97, $78, $79, $79, $69, $78, $77,
    $96, $A4, $A5, $A5, $A6, $A6, $88, $88, $88, $78, $87, $87,
    $A5, $B4, $96, $A5, $96, $96, $88, $78, $78, $78, $87, $87,
    $95, $B4, $96, $A5, $96, $97, $88, $78, $78, $69, $78, $87,
    $96, $B4, $96, $A6, $97, $97, $78, $79, $79, $69, $78, $77,
    $96, $A4, $A5, $A5, $A6, $A6, $88, $88, $88, $78, $87, $87,
    $A5, $B5, $96, $A5, $A6, $96, $88, $78, $78, $78, $87, $87,
    $95, $B4, $96, $A5, $96, $97, $88, $78, $78, $69, $78, $87,
    $96, $B4, $96, $A6, $97, $97, $78, $79, $78, $69, $78, $77,
    $96, $A4, $A5, $B5, $A6, $A6, $88, $89, $88, $78, $87, $87,
    $A5, $B4, $96, $A5, $96, $96, $88, $88, $78, $78, $87, $87,
    $95, $B4, $96, $A5, $96, $97, $88, $78, $78, $79, $78, $87,
    $96, $B4, $96, $A6, $96, $97, $78, $79, $78, $69, $78, $77,
    $96, $A4, $A5, $B5, $A6, $A6, $88, $88, $88, $78, $87, $87,
    $A5, $B4, $96, $A5, $A6, $96, $88, $88, $78, $78, $77, $87,
    $95, $B4, $96, $A5, $96, $97, $88, $78, $78, $79, $77, $87,
    $95, $B4, $96, $A5, $96, $97, $78, $79, $78, $69, $78, $77,
    $96, $B4, $A5, $B5, $A6, $A6, $87, $88, $88, $78, $87, $87,
    $A5, $B4, $A6, $A5, $A6, $96, $88, $88, $78, $78, $87, $87,
    $A5, $B4, $96, $A5, $96, $97, $88, $78, $78, $79, $77, $87,
    $95, $B4, $96, $A5, $96, $97, $88, $79, $78, $69, $78, $87,
    $96, $B4, $A5, $B5, $A6, $A6, $87, $88, $88, $78, $87, $86,
    $A5, $B4, $A5, $A5, $A6, $96, $88, $88, $88, $78, $87, $87,
    $A5, $B4, $96, $A5, $96, $96, $88, $78, $78, $79, $77, $87,
    $95, $B4, $96, $A5, $86, $97, $88, $78, $78, $69, $78, $87,
    $96, $B4, $A5, $B5, $A6, $A6, $87, $88, $88, $78, $87, $86,
    $A5, $B3, $A5, $A5, $A6, $96, $88, $88, $88, $78, $87, $87,
    $A5, $B4, $96, $A5, $96, $96, $88, $78, $78, $78, $87, $87,
    $95, $B4, $96, $A5, $96, $97, $88, $76, $78, $69, $78, $87,
    $96, $B4, $A5, $B5, $A6, $A6, $87, $88, $88, $78, $87, $86,
    $A5, $B3, $A5, $A5, $A6, $A6, $88, $88, $88, $78, $87, $87,
    $A5, $B4, $96, $A5, $96, $96, $88, $78, $78, $78, $87, $87,
    $95, $B4, $96, $A5, $96, $97, $88, $78, $78, $69, $78, $87,
    $96, $B4, $A5, $B5, $A6, $A6, $87, $88, $88, $78, $87, $86,
    $A5, $B3, $A5, $A5, $A6, $A6, $88, $88, $88, $78, $87, $87,
    $A5, $B4, $96, $A5, $96, $96, $88, $78, $78, $78, $87, $87,
    $95, $B4, $96, $A5, $96, $97, $88, $78, $78, $69, $78, $87,
    $96, $B4, $A5, $B5, $A6, $A6, $87, $88, $88, $78, $87, $86,
    $A5, $B3, $A5, $A5, $A6, $A6, $88, $88, $88, $78, $87, $87,
    $A5, $B4, $96, $A5, $A6, $96, $88, $88, $78, $78, $87, $87,
    $95, $B4, $96, $A5, $96, $97, $88, $78, $78, $69, $78, $87,
    $96, $B4, $A5, $B5, $A6, $A6, $87, $88, $87, $78, $87, $86,
    $A5, $B3, $A5, $B5, $A6, $A6, $88, $88, $88, $78, $87, $87,
    $A5, $B4, $96, $A5, $A6, $96, $88, $88, $78, $78, $87, $87,
    $95, $B4, $96, $A5, $96, $97, $88, $78, $78, $79, $78, $87,
    $96, $B4, $A5, $B5, $A5, $A6, $87, $88, $87, $78, $87, $86,
    $A5, $B3, $A5, $B5, $A6, $A6, $87, $88, $88, $78, $87, $87,
    $A5, $B4, $96, $A5, $A6, $96, $88, $88, $78, $78, $87, $87,
    $95, $B4, $96, $A5, $96, $97, $88, $78, $78, $79, $77, $87,
    $95, $B4, $A5, $B4, $A5, $A6, $87, $88, $87, $78, $87, $86,
    $A5, $C3, $A5, $B5, $A6, $A6, $87, $88, $88, $78, $87, $87,
    $A5, $B4, $A6, $A5, $A6, $96, $88, $88, $78, $78, $87, $87,
    $A5, $B4, $96, $A5, $96, $96, $88, $78, $78, $79, $77, $87,
    $95, $B4, $A5, $B4, $A5, $A6, $97, $87, $87, $78, $87, $86,
    $A5, $C3, $A5, $B5, $A6, $A6, $87, $88, $88, $78, $87, $86,
    $A5, $B4, $A5, $A5, $A6, $96, $88, $88, $88, $78, $87, $87,
    $A5, $B4, $96, $A5, $96, $96, $88, $78, $78, $79, $77, $87,
    $95, $B4, $A5, $B4, $A5, $A6, $97, $87, $87, $78, $87, $96,
    $A5, $C3, $A5, $B5, $A6, $A6, $87, $88, $88, $78, $87, $86,
    $A5, $B3, $A5, $A5, $A6, $A6, $88, $88, $88, $78, $87, $87,
    $A5, $B4, $96, $A5, $96, $96, $88, $78, $78, $78, $87, $87,
    $95, $B4, $A5, $B4, $A5, $A6, $97, $87, $87, $78, $87, $96,
    $A5, $C3, $A5, $B5, $A6, $A6, $87, $88, $88, $78, $87, $86,
    $A5, $B3, $A5, $A5, $A6, $A6, $88, $88, $88, $78, $87, $87,
    $A5, $B4, $96, $A5, $96, $96, $88, $78, $78, $78, $87, $87,
    $95, $B4, $A5, $B4, $A5, $A6, $97, $87, $87, $78, $87, $96,
    $A5, $C3, $A5, $B5, $A6, $A6, $88, $88, $88, $78, $87, $86,
    $A5, $B3, $A5, $A5, $A6, $A6, $88, $78, $88, $78, $87, $87,
    $A5, $B4, $96, $A5, $A6, $96, $88, $88, $78, $78, $87, $87,
    $95, $B4, $A5, $B4, $A5, $A6, $97, $87, $87, $78, $87, $96,
    $A5, $C3, $A5, $B5, $A6, $A6, $87, $88, $88, $78, $87, $86,
    $A5, $B3, $A5, $A5, $A6, $A6, $88, $88, $88, $78, $87, $87,
    $A5, $B4, $96, $A5, $A6, $96, $88, $88, $78, $78, $87, $87,
    $95, $B4, $A5, $B4, $A5, $A6, $97, $87, $87, $78, $87, $96,
    $A5, $C3, $A5, $B5, $A5, $A6, $87, $88, $87, $78, $87, $86,
    $A5, $B3, $A5, $B5, $A6, $A6, $88, $88, $88, $78, $87, $87,
    $A5, $B4, $96, $A5, $A6, $96, $88, $88, $78, $78, $87, $87,
    $95, $B4, $A5, $B4, $A5, $A6, $97, $87, $87, $88, $87, $96,
    $A5, $C3, $A5, $B4, $A5, $A6, $87, $88, $87, $78, $87, $86,
    $A5, $B3, $A5, $B5, $A6, $A6, $87, $88, $88, $78, $87, $87,
    $A5, $B4, $96, $A5, $A6, $96, $88, $88, $78, $78, $87, $87,
    $95, $B4, $A5, $B4, $A5, $A5, $97, $87, $87, $88, $86, $96,
    $A4, $C3, $A5, $A5, $A5, $A6, $97, $87, $87, $78, $87, $86,
    $A5, $C3, $A5, $B5, $A6, $A6, $87, $88, $78, $78, $87, $87);


  CnData: array[0..599] of Byte = (
    $0B, $52, $BA, $00, $16, $A9, $5D, $00, $83, $A9, $37, $05, $0E, $74, $9B, $00,
    $1A, $B6, $55, $00, $87, $B5, $55, $04, $11, $55, $AA, $00, $1C, $A6, $B5, $00,
    $8A, $A5, $75, $02, $14, $52, $BA, $00, $81, $52, $6E, $06, $0D, $E9, $37, $00,
    $18, $74, $97, $00, $86, $EA, $96, $05, $10, $6D, $55, $00, $1A, $35, $AA, $00,
    $88, $4B, $6A, $02, $13, $A5, $6D, $00, $1E, $D2, $6E, $07, $0B, $D2, $5E, $00,
    $17, $E9, $2E, $00, $84, $D9, $2D, $05, $0F, $DA, $95, $00, $19, $5B, $52, $00,
    $87, $56, $D4, $04, $11, $4A, $DA, $00, $1C, $A5, $5D, $00, $89, $A4, $BD, $02,
    $15, $D2, $5D, $00, $82, $B2, $5B, $06, $0D, $B5, $2B, $00, $18, $BA, $95, $00,
    $86, $B6, $A5, $05, $10, $56, $B4, $00, $1A, $4A, $DA, $00, $87, $49, $BA, $03,
    $13, $A4, $BB, $00, $1E, $B2, $5B, $07, $0B, $72, $57, $00, $16, $75, $2B, $00,
    $84, $6D, $2A, $06, $0F, $AD, $55, $00, $19, $55, $AA, $00, $86, $55, $6C, $04,
    $12, $C9, $76, $00, $1C, $64, $B7, $00, $8A, $E4, $AE, $02, $15, $EA, $56, $00,
    $83, $DA, $55, $07, $0D, $5B, $2A, $00, $18, $AD, $55, $00, $85, $AA, $D5, $05,
    $10, $53, $6A, $00, $1B, $A9, $6D, $00, $88, $A9, $5D, $03, $13, $D4, $AE, $00,
    $81, $D4, $AB, $08, $0C, $BA, $55, $00, $16, $5A, $AA, $00, $83, $56, $AA, $06,
    $0F, $AA, $D5, $00, $19, $52, $DA, $00, $86, $52, $BA, $04, $11, $A9, $5D, $00,
    $1D, $D4, $9B, $00, $8A, $74, $9B, $03, $15, $B6, $55, $00, $82, $AD, $55, $07,
    $0D, $55, $AA, $00, $18, $A5, $B5, $00, $85, $A5, $75, $05, $0F, $52, $B6, $00,
    $1B, $69, $37, $00, $89, $E9, $37, $04, $13, $74, $97, $00, $81, $EA, $96, $08,
    $0C, $6D, $52, $00, $16, $2D, $AA, $00, $83, $4B, $6A, $06, $0E, $A5, $6D, $00,
    $1A, $D2, $6E, $00, $87, $D2, $5E, $04, $12, $E9, $2E, $00, $1D, $EC, $96, $0A,
    $0B, $DA, $95, $00, $15, $5B, $52, $00, $82, $56, $D2, $06, $0C, $2A, $DA, $00,
    $18, $A4, $DD, $00, $85, $A4, $BD, $05, $10, $D2, $5D, $00, $1B, $D9, $2D, $00,
    $89, $B5, $2B, $03, $14, $BA, $95, $00, $81, $B5, $95, $08, $0B, $56, $B2, $00,
    $16, $2A, $DA, $00, $83, $49, $B6, $05, $0E, $64, $BB, $00, $19, $B2, $5B, $00,
    $87, $6A, $57, $04, $12, $75, $2B, $00, $1D, $B6, $95, $00, $8A, $AD, $55, $02,
    $15, $55, $AA, $00, $82, $55, $6C, $07, $0D, $C9, $76, $00, $17, $64, $B7, $00,
    $86, $E4, $AE, $05, $11, $EA, $56, $00, $1B, $6D, $2A, $00, $88, $5A, $AA, $04,
    $14, $AD, $55, $00, $81, $AA, $D5, $09, $0B, $52, $EA, $00, $16, $A9, $6D, $00,
    $84, $A9, $5D, $06, $0F, $D4, $AE, $00, $1A, $EA, $4D, $00, $87, $BA, $55, $04,
    $12, $5A, $AA, $00, $1D, $AB, $55, $00, $8A, $A6, $D5, $02, $14, $52, $DA, $00,
    $82, $52, $BA, $06, $0D, $A9, $3B, $00, $18, $B4, $9B, $00, $85, $74, $9B, $05,
    $11, $B5, $4D, $00, $1C, $D6, $A9, $00, $88, $35, $AA, $03, $13, $A5, $B5, $00,
    $81, $A5, $75, $0B, $0B, $52, $B6, $00, $16, $69, $37, $00, $84, $E9, $2F, $06,
    $10, $F4, $97, $00, $1A, $75, $4B, $00, $87, $6D, $52, $05, $11, $2D, $69, $00,
    $1D, $95, $B5, $00, $8A, $A5, $6D, $02, $15, $D2, $6E, $00, $82, $D2, $5E, $07,
    $0E, $E9, $2E, $00, $19, $EA, $96, $00, $86, $DA, $95, $05, $10, $5B, $4A, $00,
    $1C, $AB, $69, $00, $88, $2A, $D8, $03);

function DaysNumberOfDate(Date: TDate): Integer;
function CnMonthOfDate(Date: TDate; Days: Integer): string; OverLoad;
function CnMonthOfDate(Date: TDate): string; OverLoad;
function CnMonth(Date: TDate): Integer;
function CnDay(Date: TDate): Integer;
function CnDayOfDate(Date: TDate): string; overload;
function CnDayOfDate(Year, Month, Day: integer): string; overload;
function CnDayOfDate(Date: TDate; Days: integer; ShowDate: Boolean = false): string; overload;
function CnDateOfDateStr(Date: TDate): string;
function CnDayOfDatePH(Date: TDate): string;
function CnDateOfDateStrPH(Date: TDate): string;
function CnDayOfDateJr(Date: TDate): string; overload;
function CnDayOfDateJr(Date: TDate; Days: Integer): string; overload;
function CnanimalOfYear(Date: TDate): string;
function CnSkyStemOfYear(Date: TDate): string;
function CnSolarTerm(Date: TDate): string;
function GetLunarHolDay(InDate: TDateTime): string; overload;
function GetLunarHolDay(InDate: TDateTime; Days: Integer): string; overload;
function l_GetLunarHolDay(iYear, iMonth, iDay: Word): Word;
function GetAnimal(Date: TDate): integer;
function GetCnDateToDate(dDate: TDateTime): TDateTime; overload;
function GetCnDateToDate(cYear, cMonth, cDay: word): TDateTime; overload;
function OtherHoliday(Month, Day: integer): string;
function Holiday(Date: TDateTime; Day: integer): string;
function GetDays(ADate: TDate): Extended;
function Constellation(Date: TDateTime; Day: integer): string; overload;
function Constellation(ADate: TDate): string; overload;

implementation

function Year(MyDate: TDateTime): Word;
begin
  result := StrToInt(FormatDateTime('yyyy', MyDate)); //SetDates(MyDate, 1);
end;

function Month(MyDate: TDateTime): Word;
begin
  result := StrToInt(FormatDateTime('mm', MyDate)); //SetDates(MyDate, 2);
end;

function day(MyDate: TDateTime): Word;
begin
  result := StrToInt(FormatDateTime('dd', MyDate)); //SetDates(MyDate, 3);
end;

function DaysNumberOfDate(Date: TDate): Integer;
var
  DaysNumber: Integer;
  I: Integer;
  yyyy, mm, dd: Word;
begin
  DecodeDate(Date, yyyy, mm, dd);
  DaysNumber := 0;
  for I := 1 to mm - 1 do
    Inc(DaysNumber, MonthDays[IsLeapYear(yyyy), I]);
  Inc(DaysNumber, dd);
  Result := DaysNumber;
end;

function GetAnimal(Date: TDate): integer;
var
  Animal: string;
begin
  Animal := CnanimalOfYear(Date);
  if Animal = '子鼠' then result := 0;
  if Animal = '丑牛' then result := 1;
  if Animal = '寅虎' then result := 2;
  if Animal = '卯兔' then result := 3;
  if Animal = '辰龙' then result := 4;
  if Animal = '巳蛇' then result := 5;
  if Animal = '午马' then result := 6;
  if Animal = '未羊' then result := 7;
  if Animal = '申猴' then result := 8;
  if Animal = '酉鸡' then result := 9;
  if Animal = '戌狗' then result := 10;
  if Animal = '亥猪' then result := 11;
end;

function CnDateOfDate(Date: TDate): Integer;
var
  CnMonth, CnMonthDays: array[0..15] of Integer;
  CnBeginDay, LeapMonth: Integer;
  yyyy, mm, dd: Word;
  Bytes: array[0..3] of Byte;
  I: Integer;
  CnMonthData: Word;
  DaysCount, CnDaysCount, ResultMonth, ResultDay: Integer;
begin
  DecodeDate(Date, yyyy, mm, dd);
  if (yyyy < 1901) or (yyyy > 2050) then
  begin
    Result := 0;
    Exit;
  end;
  Bytes[0] := CnData[(yyyy - 1901) * 4];
  Bytes[1] := CnData[(yyyy - 1901) * 4 + 1];
  Bytes[2] := CnData[(yyyy - 1901) * 4 + 2];
  Bytes[3] := CnData[(yyyy - 1901) * 4 + 3];
  if (Bytes[0] and $80) <> 0 then
    CnMonth[0] := 12
  else
    CnMonth[0] := 11;
  CnBeginDay := (Bytes[0] and $7F);
  CnMonthData := Bytes[1];
  CnMonthData := CnMonthData shl 8;
  CnMonthData := CnMonthData or Bytes[2];
  LeapMonth := Bytes[3];
  for I := 15 downto 0 do
  begin
    CnMonthDays[15 - I] := 29;
    if ((1 shl I) and CnMonthData) <> 0 then
      Inc(CnMonthDays[15 - I]);
    if CnMonth[15 - I] = LeapMonth then
      CnMonth[15 - I + 1] := -LeapMonth
    else
    begin
      if CnMonth[15 - I] < 0 then
        CnMonth[15 - I + 1] := -CnMonth[15 - I] + 1
      else
        CnMonth[15 - I + 1] := CnMonth[15 - I] + 1;
      if CnMonth[15 - I + 1] > 12 then CnMonth[15 - I + 1] := 1;
    end;
  end;
  DaysCount := DaysNumberOfDate(Date) - 1;
  if DaysCount <= (CnMonthDays[0] - CnBeginDay) then
  begin
    if (yyyy > 1901) and
      (CnDateOfDate(EncodeDate(yyyy - 1, 12, 31)) < 0) then
      ResultMonth := -CnMonth[0]
    else
      ResultMonth := CnMonth[0];
    ResultDay := CnBeginDay + DaysCount;
  end
  else
  begin
    CnDaysCount := CnMonthDays[0] - CnBeginDay;
    I := 1;
    while (CnDaysCount < DaysCount) and
      (CnDaysCount + CnMonthDays[I] < DaysCount) do
    begin
      Inc(CnDaysCount, CnMonthDays[I]);
      Inc(I);
    end;
    ResultMonth := CnMonth[I];
    ResultDay := DaysCount - CnDaysCount;
  end;
  if ResultMonth > 0 then
    Result := ResultMonth * 100 + ResultDay
  else
    Result := ResultMonth * 100 - ResultDay
end;

function CnMonth(Date: TDate): Integer;
begin
  Result := Abs(CnDateOfDate(Date) div 100);
end;

function CnMonthOfDate(Date: TDate; Days: Integer): string;
var
  Year, Month, Day: word;
begin
  DecodeDate(Date, Year, Month, Day);
  Result := CnMonthOfDate(EncodeDate(Year, Month, Days));

end;

function CnMonthOfDate(Date: TDate): string;
const
  CnMonthStr: array[1..12] of string = ('正', '二', '三', '四', '五', '六', '七', '八', '九', '十','冬', '腊');
var
  Month: Integer;
begin
  Month := CnDateOfDate(Date) div 100;
  if Month < 0 then
    Result := '闰' + CnMonthStr[-Month]
  else
    Result := CnMonthStr[Month] + '月';
end;

function CnDayOfDatePH(Date: TDate): string;
const
  CnDayStr: array[1..30] of string = (
    '初一', '初二', '初三', '初四', '初五',
    '初六', '初七', '初八', '初九', '初十',
    '十一', '十二', '十三', '十四', '十五',
    '十六', '十七', '十八', '十九', '二十',
    '廿一', '廿二', '廿三', '廿四', '廿五',
    '廿六', '廿七', '廿八', '廿九', '三十');
var
  Day: Integer;
begin
  Day := Abs(CnDateOfDate(Date)) mod 100;
  Result := CnDayStr[Day];
end;

function CnDateOfDateStr(Date: TDate): string;
begin
  Result := CnMonthOfDate(Date) + CnDayOfDatePH(Date);
end;

function CnDayOfDate(Date: TDate; Days: integer; ShowDate: Boolean = false): string; //指定日期的农历日包括节日
var
  Year, Month, Day: word;
begin
  DecodeDate(Date, Year, Month, Day);
  Result := CnDayOfDate(EncodeDate(Year, Month, Days));
end;

function CnDayOfDate(Year, Month, Day: integer): string; overload; //指定日期的农历日包括节日
begin
  Result := CnDayOfDate(EncodeDate(Year, Month, Day));
end;


function CnDay(Date: TDate): Integer;
begin
  Result := Abs(CnDateOfDate(Date)) mod 100;
end;

function CnDayOfDate(Date: TDate): string;
const
  CnDayStr: array[1..30] of string = (
    '初一', '初二', '初三', '初四', '初五',
    '初六', '初七', '初八', '初九', '初十',
    '十一', '十二', '十三', '十四', '十五',
    '十六', '十七', '十八', '十九', '二十',
    '廿一', '廿二', '廿三', '廿四', '廿五',
    '廿六', '廿七', '廿八', '廿九', '三十');
var
  Day: Integer;
begin
  Day := Abs(CnDateOfDate(Date)) mod 100;
  Result := CnDayStr[Day];
end;

function CnDateOfDateStrPH(Date: TDate): string;
begin
  Result := CnMonthOfDate(Date) + CnDayOfDate(Date);
end;

function CnDayOfDateJr(Date: TDate; Days: Integer): string;
var
  Year, Month, Day: word;
begin
  DecodeDate(Date, Year, Month, Day);
  Result := CnDayOfDateJr(EncodeDate(Year, Month, Days));

end;

function CnDayOfDateJr(Date: TDate): string;
var
  Day: Integer;
begin
  Result := '';
  Day := Abs(CnDateOfDate(Date)) mod 100;
  case Day of
    1:  if (CnMonthOfDate(Date) = '正月') then  Result := '春节';
    5:  if CnMonthOfDate(Date) = '五月' then    Result := '端午节';
    7:  if CnMonthOfDate(Date) = '七月' then    Result := '七夕节';
    15: if CnMonthOfDate(Date) = '八月' then    Result := '中秋节' else  if (CnMonthOfDate(Date) = '正月') then Result := '元宵节';
    9:  if CnMonthOfDate(Date) = '九月' then    Result := '重阳节';
    8:  if CnMonthOfDate(Date) = '腊月' then    Result := '腊八节';
  else
    if (CnMonthOfDate(Date + 1) = '正月') and (CnMonthOfDate(Date) <> '正月') then
      Result := '除夕';
  end; {case}
end;

function CnanimalOfYear(Date: TDate): string;
var
  i: integer;
  DateStr: string;
begin
  DateStr := FormatDateTime('yyyy/mm/dd', Date);
  i := length(inttostr(month(date)));
  case (StrToInt(Copy(DateStr, 1, 4)) - StrToInt(BaseAnimalDate))
    mod 12 of
    0:
      if (StrToInt(Copy(DateStr, 6, i)) < 4) and ((Pos('腊', CnMonthOfDate(Date)) = 0) and (Pos('冬', CnMonthOfDate(Date)) = 0)) then
        Result := '子鼠'
      else
      begin
        if StrToInt(Copy(DateStr, 6, i)) < 4 then
          Result := '亥猪'
        else
          Result := '子鼠';
      end;
    1, -11:
      if (StrToInt(Copy(DateStr, 6, i)) < 4) and ((Pos('腊',
        CnMonthOfDate(Date)) = 0) and (Pos('冬', CnMonthOfDate(Date)) = 0)) then
        Result := '丑牛'
      else
      begin
        if StrToInt(Copy(DateStr, 6, i)) < 4 then
          Result := '子鼠'
        else
          Result := '丑牛';
      end;
    2, -10:
      if (StrToInt(Copy(DateStr, 6, i)) < 4) and ((Pos('腊',
        CnMonthOfDate(Date)) = 0) and (Pos('冬', CnMonthOfDate(Date)) = 0)) then
        Result := '寅虎'
      else
      begin
        if StrToInt(Copy(DateStr, 6, i)) < 4 then
          Result := '丑牛'
        else
          Result := '寅虎';
      end;
    3, -9:
      if (StrToInt(Copy(DateStr, 6, i)) < 4) and ((Pos('腊',
        CnMonthOfDate(Date)) = 0) and (Pos('冬', CnMonthOfDate(Date)) = 0)) then
        Result := '卯兔'
      else
      begin
        if StrToInt(Copy(DateStr, 6, i)) < 4 then
          Result := '寅虎'
        else
          Result := '卯兔';
      end;
    4, -8:
      if (StrToInt(Copy(DateStr, 6, i)) < 4) and ((Pos('腊',
        CnMonthOfDate(Date)) = 0) and (Pos('冬', CnMonthOfDate(Date)) = 0)) then
        Result := '辰龙'
      else
      begin
        if StrToInt(Copy(DateStr, 6, i)) < 4 then
          Result := '卯兔'
        else
          Result := '辰龙';
      end;
    5, -7:
      if (StrToInt(Copy(DateStr, 6, i)) < 4) and ((Pos('腊',
        CnMonthOfDate(Date)) = 0) and (Pos('冬', CnMonthOfDate(Date)) = 0)) then
        Result := '巳蛇'
      else
      begin
        if StrToInt(Copy(DateStr, 6, i)) < 4 then
          Result := '辰龙'
        else
          Result := '巳蛇';
      end;
    6, -6:
      if (StrToInt(Copy(DateStr, 6, i)) < 4) and ((Pos('腊',
        CnMonthOfDate(Date)) = 0) and (Pos('冬', CnMonthOfDate(Date)) = 0)) then
        Result := '午马'
      else
      begin
        if StrToInt(Copy(DateStr, 6, i)) < 4 then
          Result := '巳蛇'
        else
          Result := '午马';
      end;
    7, -5:
      if (StrToInt(Copy(DateStr, 6, i)) < 4) and ((Pos('腊',
        CnMonthOfDate(Date)) = 0) and (Pos('冬', CnMonthOfDate(Date)) = 0)) then
        Result := '未羊'
      else
      begin
        if StrToInt(Copy(DateStr, 6, i)) < 4 then
          Result := '午马'
        else
          Result := '未羊';
      end;
    8, -4:
      if (StrToInt(Copy(DateStr, 6, i)) < 4) and ((Pos('腊',
        CnMonthOfDate(Date)) = 0) and (Pos('冬', CnMonthOfDate(Date)) = 0)) then
        Result := '申猴'
      else
      begin
        if StrToInt(Copy(DateStr, 6, i)) < 4 then
          Result := '未羊'
        else
          Result := '申猴';
      end;
    9, -3:
      if (StrToInt(Copy(DateStr, 6, i)) < 4) and ((Pos('腊',
        CnMonthOfDate(Date)) = 0) and (Pos('冬', CnMonthOfDate(Date)) = 0)) then
        Result := '酉鸡'
      else
      begin
        if StrToInt(Copy(DateStr, 6, i)) < 4 then
          Result := '申猴'
        else
          Result := '酉鸡';
      end;
    10, -2:
      if (StrToInt(Copy(DateStr, 6, i)) < 4) and ((Pos('腊',
        CnMonthOfDate(Date)) = 0) and (Pos('冬', CnMonthOfDate(Date)) = 0)) then
        Result := '戌狗'
      else
      begin
        if StrToInt(Copy(DateStr, 6, i)) < 4 then
          Result := '酉鸡'
        else
          Result := '戌狗';
      end;
    11, -1:
      if (StrToInt(Copy(DateStr, 6, i)) < 4) and ((Pos('腊',
        CnMonthOfDate(Date)) = 0) and (Pos('冬', CnMonthOfDate(Date)) = 0)) then
        Result := '亥猪'
      else
      begin
        if StrToInt(Copy(DateStr, 6, i)) < 4 then
          Result := '戌狗'
        else
          Result := '亥猪';
      end;
  end;
end;

function CnSkyStemOfYear(Date: TDate): string;
var
  i: integer;
  DateStr: string;
begin
  DateStr := FormatDateTime('yyyy/mm/dd', Date);
  i := length(inttostr(month(date)));
  case (StrToInt(Copy(DateStr, 1, 4)) - StrToInt(BaseSkyStemDate))
    mod 10 of
    0:
      if (StrToInt(Copy(DateStr, 6, i)) < 4) and ((Pos('腊',
        CnMonthOfDate(Date)) = 0) and (Pos('冬', CnMonthOfDate(Date)) = 0)) then
        Result := '甲'
      else
      begin
        if StrToInt(Copy(DateStr, 6, i)) < 4 then
          Result := '癸'
        else
          Result := '甲';
      end;
    1, -9:
      if (StrToInt(Copy(DateStr, 6, i)) < 4) and ((Pos('腊',
        CnMonthOfDate(Date)) = 0) and (Pos('冬', CnMonthOfDate(Date)) = 0)) then
        Result := '乙'
      else
      begin
        if StrToInt(Copy(DateStr, 6, i)) < 4 then
          Result := '甲'
        else
          Result := '乙';
      end;
    2, -8:
      if (StrToInt(Copy(DateStr, 6, i)) < 4) and ((Pos('腊',
        CnMonthOfDate(Date)) = 0) and (Pos('冬', CnMonthOfDate(Date)) = 0)) then
        Result := '丙'
      else
      begin
        if StrToInt(Copy(DateStr, 6, i)) < 4 then
          Result := '乙'
        else
          Result := '丙';
      end;
    3, -7:
      if (StrToInt(Copy(DateStr, 6, i)) < 4) and ((Pos('腊',
        CnMonthOfDate(Date)) = 0) and (Pos('冬', CnMonthOfDate(Date)) = 0)) then
        Result := '丁'
      else
      begin
        if StrToInt(Copy(DateStr, 6, i)) < 4 then
          Result := '丙'
        else
          Result := '丁';
      end;
    4, -6:
      if (StrToInt(Copy(DateStr, 6, i)) < 4) and ((Pos('腊',
        CnMonthOfDate(Date)) = 0) and (Pos('冬', CnMonthOfDate(Date)) = 0)) then
        Result := '戊'
      else
      begin
        if StrToInt(Copy(DateStr, 6, i)) < 4 then
          Result := '丁'
        else
          Result := '戊';
      end;
    5, -5:
      if (StrToInt(Copy(DateStr, 6, i)) < 4) and ((Pos('腊',
        CnMonthOfDate(Date)) = 0) and (Pos('冬', CnMonthOfDate(Date)) = 0)) then
        Result := '巳'
      else
      begin
        if StrToInt(Copy(DateStr, 6, i)) < 4 then
          Result := '戊'
        else
          Result := '巳';
      end;
    6, -4:
      if (StrToInt(Copy(DateStr, 6, i)) < 4) and ((Pos('腊',
        CnMonthOfDate(Date)) = 0) and (Pos('冬', CnMonthOfDate(Date)) = 0)) then
        Result := '庚'
      else
      begin
        if StrToInt(Copy(DateStr, 6, i)) < 4 then
          Result := '巳'
        else
          Result := '庚';
      end;
    7, -3:
      if (StrToInt(Copy(DateStr, 6, i)) < 4) and ((Pos('腊',
        CnMonthOfDate(Date)) = 0) and (Pos('冬', CnMonthOfDate(Date)) = 0)) then
        Result := '辛'
      else
      begin
        if StrToInt(Copy(DateStr, 6, i)) < 4 then
          Result := '庚'
        else
          Result := '辛';
      end;
    8, -2:
      if (StrToInt(Copy(DateStr, 6, i)) < 4) and ((Pos('腊',
        CnMonthOfDate(Date)) = 0) and (Pos('冬', CnMonthOfDate(Date)) = 0)) then
        Result := '壬'
      else
      begin
        if StrToInt(Copy(DateStr, 6, i)) < 4 then
          Result := '辛'
        else
          Result := '壬';
      end;
    9, -1:
      if (StrToInt(Copy(DateStr, 6, i)) < 4) and ((Pos('腊',
        CnMonthOfDate(Date)) = 0) and (Pos('冬', CnMonthOfDate(Date)) = 0)) then
        Result := '癸'
      else
      begin
        if StrToInt(Copy(DateStr, 6, i)) < 4 then
          Result := '壬'
        else
          Result := '癸';
      end;
  end;
  Result := Result + Copy(CnanimalOfYear(Date), 1, 3);
end;

function CnSolarTerm(Date: TDate): string;
var
  Year, Month, Day, Hour: Word;
begin
  DecodeDate(Date, Year, Month, Day);
end;

function GetLunarHolDay(InDate: TDateTime; Days: Integer): string;
var
  Year, Month, Day, Hour: Word;
begin
  DecodeDate(Date, Year, Month, Day);
  Result := GetLunarHolDay(EncodeDate(Year, Month, Days));

end;

function GetLunarHolDay(InDate: TDateTime): string;
var
  i, iYear, iMonth, iDay: Word;
begin
  Result := '';
  DecodeDate(InDate, iYear, iMonth, iDay);
  i := l_GetLunarHolDay(iYear, iMonth, iDay);
  case i of
    1: Result := '小寒';
    2: Result := '大寒';
    3: Result := '立春';
    4: Result := '雨水';
    5: Result := '惊蛰';
    6: Result := '春分';
    7: Result := '清明';
    8: Result := '谷雨';
    9: Result := '立夏';
    10: Result := '小满';
    11: Result := '芒种';
    12: Result := '夏至';
    13: Result := '小暑';
    14: Result := '大暑';
    15: Result := '立秋';
    16: Result := '处暑';
    17: Result := '白露';
    18: Result := '秋分';
    19: Result := '寒露';
    20: Result := '霜降';
    21: Result := '立冬';
    22: Result := '小雪';
    23: Result := '大雪';
    24: Result := '冬至';
  end;
end;

function l_GetLunarHolDay(iYear, iMonth, iDay: Word): Word;
var
  Flag: Byte;
  Day: Word;
begin
  Flag := gLunarHolDay[(iYear - START_YEAR) * 12 + iMonth - 1];
  if iDay < 15 then
    Day := 15 - ((Flag shr 4) and $0F)
  else
    Day := (Flag and $0F) + 15;
  if iDay = Day then
    if iDay > 15 then
      Result := (iMonth - 1) * 2 + 2
    else
      Result := (iMonth - 1) * 2 + 1
  else
    Result := 0;
end;


function OtherHoliday(Month, Day: integer): string;
begin
end;

function Holiday(Date: TDateTime; Day: integer): string; //由公历日期决定的节假日
var
  dDate: TDate;
begin
  result := '';
  case Month(Date) of
    1:
      begin
        if day = 1 then result := '元旦节';
      end;
    2:
      begin
        if day = 2 then  result := '湿地日';
        if day = 10 then result := '气象节';
        if day = 14 then result := '情人节';
      end;
    3:
      begin
        if day = 3 then  result := '爱耳日';
        if day = 8 then  result := '妇女节';
        if day = 12 then result := '植树节';
        if day = 14 then result := '警察日';
        if day = 15 then result := '消费节';
        if day = 21 then result := '森林日';
        if day = 22 then result := '水日';
        if day = 23 then result := '气象日';
      end;
    4:
      begin
        if day = 1 then  result := '愚人节';
        if day = 7 then  result := '卫生日';
        if day = 22 then result := '地球日';
      end;
    5:
      begin
        if day = 1 then  result := '劳动节';
        if day = 4 then  result := '青年节';
        if day = 8 then  result := '红十字';
        if day = 12 then result := '护士节';
        if day = 15 then result := '家庭日';
        if day = 17 then result := '电信日';
        if day = 18 then result := '博物馆';
        if day = 19 then result := '助残日';
        if day = 23 then result := '牛奶日';
        if day = 31 then result := '无烟日';
        dDate := EnCodeDate(Year(Date), Month(Date), Day);
        if (DayOfWeek(dDate) = 1) then if (Trunc((Day - 1) / 7) = 1) then result := '母亲节';
      end;
    6:
      begin
        if day = 1 then  result := '儿童节';
        if day = 5 then  result := '环境日';
        if day = 6 then  result := '爱眼日';
        if day = 23 then result := '体育日';
        if day = 25 then result := '土地日';
        if day = 26 then result := '反毒品';
        dDate := EnCodeDate(Year(Date), Month(Date), Day);
        if (DayOfWeek(dDate) = 1) then if (Trunc((Day - 1) / 7) = 2) then result := '父亲节';
      end;
    7:
      begin
        if day = 1 then  result := '建党节';
        if day = 11 then result := '人口日';
      end;
    8:
      begin
        if day = 1 then result := '建军节';
      end;
    9:
      begin
        if day = 8 then  result := '扫盲日';
        if day = 10 then result := '教师节';
        if day = 17 then result := '和平日';
        if day = 20 then result := '爱牙日';
        if day = 22 then result := '聋人节';
        if day = 27 then result := '旅游日';
      end;
    10:
      begin
        if day = 1 then  result := '国庆节';
        if day = 4 then  result := '动物日';
        if day = 6 then  result := '老人节';
        if day = 7 then  result := '住房日';
        if day = 9 then  result := '邮政日';
        if day = 15 then result := '盲人节';
        if day = 16 then result := '粮食日';
        if day = 31 then result := '万圣节';
      end;
    11:
      begin
        if day = 8 then  result := '记者日';
        if day = 9 then  result := '消防日';
        if day = 17 then result := '大学生';
        dDate := EnCodeDate(Year(Date), Month(Date), Day);
        if (DayOfWeek(dDate) = 5) then if (Trunc((Day - 1) / 7) = 3) then result := '感恩节';
      end;
    12:
      begin
        if day = 9 then  result := '足球日';
        if day = 24 then result := '平安夜';
        if day = 25 then result := '圣诞节';
      end;
  end;
end;

function GetCnDateToDate(dDate: TDateTime): TDateTime;
begin
  Result := GetCnDateToDate(Year(Now), CnMonth(dDate), CnDay(dDate));
end;

function GetCnDateToDate(cYear, cMonth, cDay: word): TDateTime;
var
  tempDate: TDateTime;
  tempDay, tempMonth: Integer;

begin
  if cMonth > 11 then
    tempDate := EnCodeDate(cYear - 1, cMonth, cDay)
  else
    tempDate := EnCodeDate(cYear, cMonth, cDay);
  Result := 0;
  tempMonth := 0;
  tempDay := 0;
  while Result = 0 do
  begin
    tempDate := tempDate + 1;
    if CnMonth(tempDate) = cMonth then
      if CnDay(tempDate) = cDay then
      begin
        Result := tempDate;
        exit;
      end
      else
        if (cDay = 30) and (CnDay(tempDate) = 29)
          and (CnDay(tempDate + 1) <> 30) then
        begin
          Result := tempDate;
          exit;
        end;

  end;
end;

function GetDays(ADate: TDate): Extended;
var
  FirstOfYear: TDateTime;
begin
  FirstOfYear := EncodeDate(StrToInt(FormatDateTime('yyyy', now)) - 1, 12, 31);
  Result := ADate - FirstOfYear;
end;

function Constellation(Date: TDateTime; Day: integer): string; overload;
var
  Year, Month, Days, Hour: Word;
begin
  DecodeDate(Date, Year, Month, Days);
  Result := Constellation(EncodeDate(Year, Month, Day));
end;

function Constellation(ADate: TDate): string;  //由公历日期求得星座名
begin
  case Month(ADate) of
    1:
      begin
        if day(ADate) <= 19 then result := '摩羯座';
        if day(ADate) >= 20 then result := '水瓶座';
      end;
    2:
      begin
        if day(ADate) <= 18 then result := '水瓶座';
        if day(ADate) >= 19 then result := '双鱼座';
      end;
    3:
      begin
        if day(ADate) <= 20 then result := '双鱼座';
        if day(ADate) >= 21 then result := '白羊座';
      end;
    4:
      begin
        if day(ADate) <= 19 then result := '白羊座';
        if day(ADate) >= 20 then result := '金牛座';
      end;
    5:
      begin
        if day(ADate) <= 20 then result := '金牛座';
        if day(ADate) >= 21 then result := '双子座';
      end;
    6:
      begin
        if day(ADate) <= 21 then result := '双子座';
        if day(ADate) >= 22 then result := '巨蟹座';
      end;
    7:
      begin
        if day(ADate) <= 22 then result := '巨蟹座';
        if day(ADate) >= 23 then result := '狮子座';
      end;
    8:
      begin
        if day(ADate) <= 22 then result := '狮子座';
        if day(ADate) >= 24 then result := '处女座';
      end;

    9:
      begin
        if day(ADate) <= 22 then result := '处女座';
        if day(ADate) >= 23 then result := '天秤座';
      end;
    10:
      begin
        if day(ADate) <= 23 then result := '天秤座';
        if day(ADate) >= 24 then result := '天蝎座';
      end;
    11:
      begin
        if day(ADate) <= 21 then result := '天蝎座';
        if day(ADate) >= 22 then result := '射手座';
      end;
    12:
      begin
        if day(ADate) <= 21 then result := '射手座';
        if day(ADate) >= 22 then result := '摩羯座';
      end;
  end;
end;

end.

