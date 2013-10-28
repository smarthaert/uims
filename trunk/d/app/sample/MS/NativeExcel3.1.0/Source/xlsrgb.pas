unit xlsrgb;
{$Q-}
{$R-}
interface

procedure RGBtoHLS(r,g,b: byte; var h,l,s: word);
//function RGBtoHLS(rgb: longword): longword;
procedure HLStoRGB(hue, lum, sat: word; var r,g,b: byte);
//function HLStoRGB(hls: longword): longword;

procedure RGBTint(inr, ing, inb: byte; tint: double; var outr, outg, outb: byte);
function GetRGBTint(rgb: longword; tint: double): longword;

implementation

const HLSMAX = 240;  {H,L, and S vary over 0-HLSMAX}
                     {HLSMAX BEST IF DIVISIBLE BY 6}
const RGBMAX = 255;  {R,G, and B vary over 0-RGBMAX}
                     {RGBMAX, HLSMAX must each fit in a byte}
                    
{Hue is undefined if Saturation is 0 (grey-scale) 
 This value determines where the Hue scrollbar is 
 initially set for achromatic colors}
const UNDEFINED = HLSMAX * 2 div 3;

{
function RGBtoHLS(rgb: longword): longword;
var r,g,b: byte;
    h,l,s: word;
begin
   r := rgb and 255;
   g := (rgb shr 8) and 255;
   b := (rgb shr 16) and 255;
   rgbtohls(r,g,b,h,l,s);
   Result := (h and 255) or 
             ((l and 255) shl 8) or
             ((s and 255) shl 16);
end;

function HLStoRGB(hls: longword): longword;
var r,g,b: byte;
    h,l,s: word;
begin
   h := hls and 255;
   l := (hls shr 8) and 255;
   s := (hls shr 16) and 255;
   hlstorgb(h,l,s,r,g,b);
   Result := (r and 255) or 
             ((g and 255) shl 8) or
             ((b and 255) shl 16);
end;
}

function GetRGBTint(rgb: longword; tint: double): longword;
var r,g,b: byte;
    nr, ng, nb: byte;
begin
   if tint = 0 then begin 
      Result := rgb;
   end else begin
      r := rgb and 255;
      g := (rgb shr 8) and 255;
      b := (rgb shr 16) and 255;
      RGBTint(r,g,b,tint,nr,ng,nb);
      Result := (nr and 255) or 
                ((ng and 255) shl 8) or
                ((nb and 255) shl 16);
   end;
end;

procedure RGBtoHLS(r,g,b: byte; var h,l,s: word);
var cMax, cMin: byte; {max and min RGB values}
    Rdelta, Gdelta, Bdelta: word; {intermediate value: % of spread from max}
    hue: integer;
begin
  {calculate lightness}
  cMax := R;
  if cMax < G then cMax := G;
  if cMax < B then cMax := B;
  cMin := R;
  if cMin > G then cMin := G;
  if cMin > B then cMin := B;

  L := (((cMax + cMin) * HLSMAX) + RGBMAX) div (2 * RGBMAX);

  if cMax = cMin then begin     { r=g=b --> achromatic case}
      S := 0;                   { saturation }
      H := UNDEFINED;           { hue }
  end else begin                { chromatic case }
      { saturation }
      if L <= (HLSMAX div 2) then begin
         S := (((cMax - cMin) * HLSMAX) + ((cMax + cMin) div 2)) div (cMax + cMin);
      end else begin
         S := (((cMax - cMin) * HLSMAX) + ((2 * RGBMAX - cMax - cMin) div 2)) div
              (2 * RGBMAX - cMax - cMin);
      end;

      { hue }
      Rdelta := (((cMax - R) * (HLSMAX div 6)) + ((cMax - cMin) div 2)) div (cMax - cMin);
      Gdelta := (((cMax - G) * (HLSMAX div 6)) + ((cMax - cMin) div 2)) div (cMax - cMin);
      Bdelta := (((cMax - B) * (HLSMAX div 6)) + ((cMax - cMin) div 2)) div (cMax - cMin);

      if R = cMax then begin
          hue := Bdelta - Gdelta;
      end else if G = cMax then begin
          hue := (HLSMAX div 3) + Rdelta - Bdelta;
      end else begin {B = cMax}
          hue := ((2 * HLSMAX) div 3) + Gdelta - Rdelta;
      end;

      if hue < 0 then hue := hue + HLSMAX;
      if hue > HLSMAX then hue := hue - HLSMAX;
      H := hue;
  end;
end;



{utility routine for HLStoRGB}
function HueToRGB(n1: word; n2: word; hue: word): word;
begin
//   if hue < 0 then hue := hue + HLSMAX;
   if hue > HLSMAX then hue := hue - HLSMAX;
   { return r,g, or b value from this tridrant}
   if hue < (HLSMAX div 6) then begin
      Result := (n1 + (((n2 - n1) * hue + (HLSMAX div 12)) div (HLSMAX div 6)));
   end else if hue < (HLSMAX div 2) then begin
      Result := n2;
   end else if hue < ((HLSMAX * 2) div 3) then begin
      Result := n1 + ((n2 - n1) * (((HLSMAX * 2) div 3) - hue) + (HLSMAX div 12)) div (HLSMAX div 6);
   end else begin
      Result := n1;
   end;
end;

procedure HLStoRGB(hue, lum, sat: word; var r,g,b: byte);
var Magic1, Magic2: word; {calculated magic numbers}
begin
  if sat = 0 then begin {achromatic case}
     R := (lum * RGBMAX) div HLSMAX;
     G := r;
     B := r;
  end else begin {chromatic case}
      {set up magic numbers}
      if lum <= (HLSMAX div 2) then begin
         Magic2 := (lum * (HLSMAX + sat) + (HLSMAX div 2)) div HLSMAX;
      end else begin
         Magic2 := lum + sat - ((lum * sat) + (HLSMAX div 2)) div HLSMAX;
      end;

      Magic1 := 2 * lum - Magic2;

      {get RGB, change units from HLSMAX to RGBMAX}
      R := (HueToRGB(Magic1, Magic2, hue + (HLSMAX div 3)) * RGBMAX + (HLSMAX div 2)) div HLSMAX;
      G := (HueToRGB(Magic1, Magic2, hue                 ) * RGBMAX + (HLSMAX div 2)) div HLSMAX;
      B := (HueToRGB(Magic1, Magic2, hue - (HLSMAX div 3)) * RGBMAX + (HLSMAX div 2)) div HLSMAX;
  end;
end;

procedure RGBTint(inr, ing, inb: byte; tint: double; var outr, outg, outb: byte);
var h,l,s: word;
begin
   if tint = 0 then begin
      outr := inr;
      outg := ing;
      outb := inb;   
   end else begin
      rgbtohls(inr, ing, inb, h, l, s);
      if tint < 0 then begin
         l := round(l * (1.0 + tint));
         //if l < 0 then l := 0;
      end else begin 
          l := round(l * (1.0 - tint) + (HLSMAX - HLSMAX * (1.0 - tint)));
          if l > HLSMAX then l := HLSMAX;
      end;  
      hlstorgb(h, l, s, outr, outg, outb);
   end;
end;

end.
