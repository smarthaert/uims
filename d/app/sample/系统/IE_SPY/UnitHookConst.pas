unit UnitHookConst;

interface
    uses windows;
const
  MappingFileName='_MyDllMouse';

type
  TShareMem=record
    data1:array [1..2] of DWORD;
    data2:TMOUSEHOOKSTRUCT;
    IfRbutton:boolean;
    buffer:array[0..1024]of char;
  end;
  PShareMem=^TShareMem;
  
implementation

end.
 