{(((((((((((((((((((((((((((((((((((((O)))))))))))))))))))))))))))))))))))))))
(                                                                            )
(                              THttpScan v4.02                               )
(                       Copyright (c) 2001 Michel Fornengo                   )
(                             All rights reserved.                           )
(                                                                            )
( home page:     http://www.delphicity.com                                   )
( contacts:      contact@delphicity.com                                      )
( support:       support@delphicity.com                                      )
((((((((((((((((((((((((((((((((((((((O)))))))))))))))))))))))))))))))))))))))
(                                                                            )
( Description: fast sort stringlists manager                                 )
(                                                                            )
((((((((((((((((((((((((((((((((((((((O))))))))))))))))))))))))))))))))))))))}

unit ThSlist;

interface

Uses Classes;

type
   TMFStringList = class (TStringList)
      private
         FMemoDescending, FDescending, FRemoveBlankLines : boolean;
         procedure PRemoveBlankLines;
      public
         constructor Create;
         function Find (const S: string; var Index: Integer ; var InsertPos : integer ; Insert_ : boolean = false): Boolean; reintroduce;
         procedure Sort; override;
         property Descending : boolean read FDescending write FDescending;
         property RemoveBlankLines : boolean read FRemoveBlankLines write FRemoveBlankLines;
   end;


implementation

constructor TMFStringList.Create;
begin
   FDescending := false;
   FMemoDescending := FDescending;
   FRemoveBlankLines := true;
end;

function TMFStringList.Find (const S: string; var Index: Integer ; var InsertPos : integer ; Insert_ : boolean = false): Boolean;
var
	Mid : string;

	function MFCmpStr (ItemString : string) : integer;
	var
		fini : boolean;
		i : integer;
		lg1, lg2 : integer;
		Temp1, Temp2 : char;
	begin
		MfCmpStr := 0;
		i := 1;
		lg1 := length (ItemString);
		lg2 := length (Mid);
      fini := false;
      while not fini do begin
         if i > lg1 then begin
            if lg1 <> lg2 then begin
               MFCmpStr := - 1;
            end;
            fini := true;
         end
         else if i > lg2 then begin
            if lg1 <> lg2 then begin
					MFCmpStr := 1;
            end;
            fini := true;
         end
         else begin
            Temp1 := ItemString[i];
            if (Temp1 >= 'a') and (Temp1 <= 'z') then Dec (Temp1, 32);
            Temp2 := Mid[i];
            if (Temp2 >= 'a') and (Temp2 <= 'z') then Dec (Temp2, 32);
				if Temp1 > Temp2 then begin
					MFCmpStr := 1;
					fini := true;
				end
				else if Temp1 < Temp2 then begin
					MFCmpStr := -1;
					Fini := true;
				end;
			end;
			 inc (i);
		end;
	end;

	procedure QuickFindUp (min, max : integer);
	var
		imid : integer;
	begin
		Index := -1;
		imid := (max + min) shr 1;
		if MFCmpStr (Self[iMid]) < 0 then begin
			if imid < max then begin
				QuickFindUp (imid + 1, max);
			end
			else begin
				insertPos := imid + 1;
			end;
		end
		else if MFCmpStr (Self[iMid]) > 0 then begin
			if imid > min then begin
				QuickFindUp (min, imid - 1);
			end
			else begin
				insertPos := imid;
			end;
		end
		else begin
			Index := iMid;
		end;
	end;

	procedure QuickFindDown (min, max : integer);
	var
		imid : integer;
	begin
		Index := -1;
		imid := (max + min) shr 1;
		if MFCmpStr (Self[iMid]) > 0 then begin
			if imid < max then begin
				QuickFindDown (imid + 1, max);
			end
			else begin
				insertPos := imid + 1;
			end;
		end
		else if MFCmpStr (Self[iMid]) < 0 then begin
			if imid > min then begin
				QuickFindDown (min, imid - 1);
			end
			else begin
				insertPos := imid;
			end;
		end
		else begin
			Index := iMid;
		end;
	end;

begin
   Mid := S;
   Index := -1;
   InsertPos := -1;
   Index := -1;
   if Count > 0 then begin
      if not FDescending then  begin
			QuickFindUp (0, Count - 1);
		end
		else begin
			QuickFindDown (0, Count - 1);
      end;
   end
   else begin
      InsertPos := 0;
   end;
   if Index = - 1 then begin
      if Insert_ then begin
         Insert (insertPos, S);
      end;
   end;
   if Index = -1 then begin
		Find := false;
   end
   else begin
      Find := true;
   end;
end;

procedure TMFStringList.PRemoveBlankLines;
var
   i : integer;
begin
	i := 0;
   while i < Count do begin
      if TStringList(Self)[i] = '' then begin
         Delete (i);
		end
		else begin
			inc (i);
		end;
	end;
end;


procedure TMFStringList.Sort;

	procedure MFQSortUp (min, max : integer);
	type
		PtStr = ^string;
	var
		 hi, lo, iMid : integer;
		 MidObject : pointer;
		 Mid: string;

		function MFCmpStr (ItemString : string) : integer;
		var
			fini : boolean;
			i : integer;
			lg1, lg2 : integer;
			Temp1, Temp2 : char;
		begin
			MfCmpStr := 0;
			i := 1;
			lg1 := length (ItemString);
			lg2 := length (Mid);
			fini := false;
			while not fini do begin
				if i > lg1 then begin
					if lg1 <> lg2 then begin
						MFCmpStr := - 1;
					end;
					fini := true;
				end
				else if i > lg2 then begin
					if lg1 <> lg2 then begin
						MFCmpStr := 1;
					end;
					fini := true;
				end
				else begin
					Temp1 := ItemString[i];
					if (Temp1 >= 'a') and (Temp1 <= 'z') then Dec (Temp1, 32);
					Temp2 := Mid[i];
					if (Temp2 >= 'a') and (Temp2 <= 'z') then Dec (Temp2, 32);
					if Temp1 > Temp2 then begin
						MFCmpStr := 1;
						fini := true;
					end
					else if Temp1 < Temp2 then begin
						MFCmpStr := -1;
						Fini := true;
					end;
				end;
				inc (i);
			end;
		end;

	begin
	  if (min < max) then begin

		 iMid := (min + max) shr 1;

		 Mid := Self[iMid];

		 Self[iMid] := Self[min];

		 MidObject := Self.Objects[iMid];
		 Self.Objects[iMid] := Self.Objects[min];

		 lo := min;
		 hi := max;

		 repeat

			  while (MFCmpStr (Self[hi]) >= 0) and (hi > lo) do dec (hi);
			  if lo < hi then begin
				  Self[lo] := Self[hi];
				  Self.Objects[lo] := Self.Objects[hi];

				  while (MFCmpStr (Self[lo]) < 0) and (lo < hi) do inc (lo);

				  if lo < hi then begin
					  Self[hi] := Self[lo];
					  Self.Objects[hi] := Self.Objects[lo];
				  end;
			  end;
		 until lo >= hi;

		 Self[lo] := Mid;
		 Self.Objects[lo] := MidObject;

		 MFQSortUp (min, lo - 1);
		 MFQSortUp (lo + 1, max);
	  end;
	end;

	procedure MFQSortDown (min, max : integer);
	type
		PtStr = ^string;
	var
		 hi, lo, iMid : integer;
		 MidObject : pointer;
		 Mid: string;

		function MFCmpStr (ItemString : string) : integer;
		var
			fini : boolean;
			i : integer;
			lg1, lg2 : integer;
			Temp1, Temp2 : char;
		begin
			MfCmpStr := 0;
			i := 1;
			lg1 := length (ItemString);
			lg2 := length (Mid);
			fini := false;
			while not fini do begin
				if i > lg1 then begin
					if lg1 <> lg2 then begin
						MFCmpStr := - 1;
					end;
					fini := true;
				end
				else if i > lg2 then begin
					if lg1 <> lg2 then begin
						MFCmpStr := 1;
					end;
					fini := true;
				end
				else begin
					Temp1 := ItemString[i];
					if (Temp1 >= 'a') and (Temp1 <= 'z') then Dec (Temp1, 32);
					Temp2 := Mid[i];
					if (Temp2 >= 'a') and (Temp2 <= 'z') then Dec (Temp2, 32);
					if Temp1 > Temp2 then begin
						MFCmpStr := 1;
						fini := true;
					end
					else if Temp1 < Temp2 then begin
						MFCmpStr := -1;
						Fini := true;
					end;
				end;
				inc (i);
			end;
		end;

	begin
	  if (min < max) then begin

		 iMid := (min + max) shr 1;

		 Mid := Self[iMid];

		 Self[iMid] := Self[min];

		 MidObject := Self.Objects[iMid];
		 Self.Objects[iMid] := Self.Objects[min];

		 lo := min;
		 hi := max;

		 repeat

			  while (not (MFCmpStr (Self[hi]) >= 0) and (hi > lo)) do dec (hi);
			  if lo < hi then begin
				  Self[lo] := Self[hi];
				  Self.Objects[lo] := Self.Objects[hi];

				  while (not (MFCmpStr (Self[lo]) < 0)) and (lo < hi) do inc (lo);

				  if lo < hi then begin
					  Self[hi] := Self[lo];
					  Self.Objects[hi] := Self.Objects[lo];
				  end;
			  end;
		 until lo >= hi;

		 Self[lo] := Mid;
		 Self.Objects[lo] := MidObject;

		 MFQSortDown (min, lo - 1);
		 MFQSortDown (lo + 1, max);
	  end;
	end;

begin
	if FRemoveBlankLines then begin
		PRemoveBlankLines;
	end;
	if not FDescending then begin
		MFQSortUp (0, Self.Count -1);
	end
	else begin
		MFQSortDown (0, Self.Count -1);
	end;
end;



end.
