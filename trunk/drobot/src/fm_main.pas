unit fm_main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, StdCtrls, ExtCtrls, Buttons, Grids;

type
  TMAINFORM = class(TForm)
    MainMenu1: TMainMenu;
    N3: TMenuItem;
    N16: TMenuItem;
    N17: TMenuItem;
    N20: TMenuItem;
    N18: TMenuItem;
    N19: TMenuItem;
    N14: TMenuItem;
    N15: TMenuItem;
    N27: TMenuItem;
    N33: TMenuItem;
    ShortOnly: TMenuItem;
    N35: TMenuItem;
    LongOnly: TMenuItem;
    N34: TMenuItem;
    Konly: TMenuItem;
    N21: TMenuItem;
    N22: TMenuItem;
    N23: TMenuItem;
    N26: TMenuItem;
    N24: TMenuItem;
    N25: TMenuItem;
    N28: TMenuItem;
    N29: TMenuItem;
    N30: TMenuItem;
    N31: TMenuItem;
    N32: TMenuItem;
    N36: TMenuItem;
    N38: TMenuItem;
    N37: TMenuItem;
    N39: TMenuItem;
    N40: TMenuItem;
    ClearShort11: TMenuItem;
    N41: TMenuItem;
    CancelOrder: TMenuItem;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Timer1: TTimer;
    N1: TMenuItem;
    NextFC: TMenuItem;
    Only1: TMenuItem;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    F7FC: TBitBtn;
    Label15: TLabel;
    Label16: TLabel;
    N2: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    Edit1: TEdit;
    Edit2: TEdit;
    BitBtn5: TBitBtn;
    Edit_long_stp: TEdit;
    Edit_short_stp: TEdit;
    Label_Vol: TLabel;
    Label_long_stp: TLabel;
    Label_short_stp: TLabel;
    N6: TMenuItem;
    Long_STP: TMenuItem;
    Short_STP: TMenuItem;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    BitBtn8: TBitBtn;
    BitBtn9: TBitBtn;
    BitBtn10: TBitBtn;
    BitBtn11: TBitBtn;
    Edit_vol_chk: TEdit;
    Label_up_power: TLabel;
    Label_down_power: TLabel;
    BitBtn12: TBitBtn;
    Edit_open_price: TEdit;
    Label_status: TLabel;
    ff_sg: TStringGrid;
    BitBtn13: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure LongOnlyClick(Sender: TObject);
    procedure ShortOnlyClick(Sender: TObject);
    procedure KonlyClick(Sender: TObject);
    procedure N15Click(Sender: TObject);
    procedure N27Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure N22Click(Sender: TObject);
    procedure N23Click(Sender: TObject);
    procedure N24Click(Sender: TObject);
    procedure N25Click(Sender: TObject);
    procedure N29Click(Sender: TObject);
    procedure N32Click(Sender: TObject);
    procedure N37Click(Sender: TObject);
    procedure ClearShort11Click(Sender: TObject);
    procedure CancelOrderClick(Sender: TObject);
    procedure NextFCClick(Sender: TObject);
    procedure Only1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure Long_STPClick(Sender: TObject);
    procedure Short_STPClick(Sender: TObject);
    procedure Edit_long_stpKeyPress(Sender: TObject; var Key: Char);
    procedure Edit_short_stpKeyPress(Sender: TObject; var Key: Char);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
    procedure BitBtn9Click(Sender: TObject);
    procedure BitBtn10Click(Sender: TObject);
    procedure BitBtn11Click(Sender: TObject);
    procedure BitBtn12Click(Sender: TObject);
    procedure Label_statusClick(Sender: TObject);
    procedure Edit_open_priceKeyPress(Sender: TObject; var Key: Char);
    procedure Edit_vol_chkKeyPress(Sender: TObject; var Key: Char);
    procedure BitBtn13Click(Sender: TObject);
    procedure ff_sgDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect;
      State: TGridDrawState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

//var
//  MAINFORM: TMAINFORM;

implementation

{$R *.dfm}

uses ff_hs_base,s_lib_pas_unit;

procedure TMAINFORM.BitBtn10Click(Sender: TObject);
begin
  if f_buy_1 <1.0 Then Exit;

  i_stp_long :=0;
  Long_STP.Checked :=False;

  i_set_stp_long_wk := Round(f_last_price_wk-0.49 + i_stp_delta);
  Edit_long_stp.Text:=IntToStr(i_set_stp_long_wk);

  Long_STPClick(Sender);

  i_BSK :=m_bsk_clear_long;
  s_caption_8:='    ';
  s_caption_9:='    ';
  s_caption_10:='    ';
  s_caption_11:='    ';
end;

procedure TMAINFORM.BitBtn11Click(Sender: TObject);
begin

  if f_buy_1 <1.0 Then Exit;

  i_stp_short :=0;
  Short_STP.Checked :=False;

  i_set_stp_short_wk := Round(f_last_price_wk+0.49 - i_stp_delta);
  Edit_short_stp.Text:=IntToStr(i_set_stp_short_wk);
  Short_STPClick(Sender);

  i_BSK :=m_bsk_clear_short;
  s_caption_8:='    ';
  s_caption_9:='    ';
  s_caption_10:='    ';
  s_caption_11:='    ';

end;

procedure TMAINFORM.BitBtn12Click(Sender: TObject);
begin
  if( i_vol_start =0 ) and ( i_vol_reset =0 ) Then
  begin
    i_vol_start :=888;
    i_vol_reset :=0;
    tdt_vol_0 :=Now;
  end;

  if( i_vol_start =999 ) and ( i_vol_reset =0 ) Then
  begin
    i_vol_start :=0;
    i_vol_reset :=0;
    tdt_vol_0 :=Now;
  end;

end;

procedure TMAINFORM.BitBtn13Click(Sender: TObject);
begin
  if i_show_string_grid <1 Then i_show_string_grid :=1 else i_show_string_grid :=0;
  if i_do_ff_qty_loop =0 Then i_do_ff_qty_loop :=888;
end;

procedure TMAINFORM.BitBtn1Click(Sender: TObject);
begin
  if f_buy_1 <1.0 Then Exit;
  i_BSK:=m_bsk_ask_long;
end;

procedure TMAINFORM.BitBtn2Click(Sender: TObject);
begin
  if f_buy_1 <1.0 Then Exit;
  i_BSK :=m_bsk_clear_long;
  s_caption_8:='    ';
  s_caption_9:='    ';
  s_caption_10:='    ';
  s_caption_11:='    ';
end;

procedure TMAINFORM.BitBtn3Click(Sender: TObject);
begin
  if f_buy_1 <1.0 Then Exit;
  i_BSK:=m_bsk_bid_short;
end;

procedure TMAINFORM.BitBtn4Click(Sender: TObject);
begin
  if f_buy_1 <1.0 Then Exit;
  i_BSK :=m_bsk_clear_short;
  s_caption_8:='    ';
  s_caption_9:='    ';
  s_caption_10:='    ';
  s_caption_11:='    ';
end;

procedure TMAINFORM.BitBtn6Click(Sender: TObject);
begin

  if f_buy_1 <1.0 Then Exit;

  i_clr_long_1_mark :=888;
  i_BSK :=m_bsk_clear_long;
  s_caption_8:='    ';
  s_caption_9:='    ';
  s_caption_10:='    ';
  s_caption_11:='    ';
end;

procedure TMAINFORM.BitBtn7Click(Sender: TObject);
begin
  if f_buy_1 <1.0 Then Exit;
  i_BSK :=m_bsk_clear_short;
  s_caption_8:='    ';
  s_caption_9:='    ';
  s_caption_10:='    ';
  s_caption_11:='    ';
  i_clr_short_1_mark:=888;
end;

procedure TMAINFORM.BitBtn8Click(Sender: TObject);
begin
  if f_buy_1 <1.0 Then Exit;
  i_BSK :=m_bsk_clear_short;
  s_caption_8:='    ';
  s_caption_9:='    ';
  s_caption_10:='    ';
  s_caption_11:='    ';
  i_clr_short_to_001_mark :=888;
end;

procedure TMAINFORM.BitBtn9Click(Sender: TObject);
begin
  if f_buy_1 <1.0 Then Exit;

  i_clr_long_to_001_mark :=888;
  i_BSK :=m_bsk_clear_long;
  s_caption_8:='    ';
  s_caption_9:='    ';
  s_caption_10:='    ';
  s_caption_11:='    ';
end;

procedure TMAINFORM.CancelOrderClick(Sender: TObject);
begin
  //ClearOrder
  i_BSK :=9;
end;

procedure TMAINFORM.ClearShort11Click(Sender: TObject);
begin
  //ClearShort -2
  if f_buy_1 <1.0 Then Exit;
  i_BSK :=8;
  //i_ff_get_qty_88 := 188;

end;

procedure TMAINFORM.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if Key in ['a'..'z'] + ['A'..'Z']then Key := #0;
  i_lock_long:=0;
end;

procedure TMAINFORM.Edit2KeyPress(Sender: TObject; var Key: Char);
begin
  if Key in ['a'..'z'] + ['A'..'Z']then Key := #0;
  i_lock_short :=0;
end;

procedure TMAINFORM.Edit_long_stpKeyPress(Sender: TObject; var Key: Char);
begin
  if Key in ['a'..'z'] + ['A'..'Z']then Key := #0;
  i_stp_long:=0;
end;

procedure TMAINFORM.Edit_open_priceKeyPress(Sender: TObject; var Key: Char);
begin
  if Key in ['a'..'z'] + ['A'..'Z']then Key := #0;
end;

procedure TMAINFORM.Edit_short_stpKeyPress(Sender: TObject; var Key: Char);
begin
  if Key in ['a'..'z'] + ['A'..'Z']then Key := #0;
  i_stp_short:=0;
end;

procedure TMAINFORM.Edit_vol_chkKeyPress(Sender: TObject; var Key: Char);
begin
  if Key in ['a'..'z'] + ['A'..'Z']then Key := #0;
end;

procedure TMAINFORM.ff_sgDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
  iBackColor,iFrontColor:Integer;
begin
  case ( ACol ) of
  0: iFrontColor :=clYellow;
  1: iFrontColor :=$00FF00;
  2: iFrontColor :=clRed;
  3: iFrontColor :=$ff00ff;
  4: iFrontColor :=$00FF00;
  5: iFrontColor :=$ff00ff;
  6: iFrontColor := clYellow;
  end;

  with TStringGrid(Sender) do
  begin
    Canvas.Font.Color := iFrontColor;
    Canvas.FillRect(Rect);
    Canvas.TextRect(Rect,Rect.Left+2,Rect.Top+2,Cells[ACol,ARow]);
  end;

end;

procedure TMAINFORM.FormCreate(Sender: TObject);
begin
  FillChar(c_open_price,SizeOf(c_open_price),0);

  FF_creat_comm_obj();

  //DoubleBuffered:=True;
  if(i_make_k_only >0) then
  begin
    Konly.Checked:=True;
  end
  else
    Konly.Checked:=false;


  if(i_only_long=0) then
  begin
    LongOnly.Checked:=False;
  end
  else  if(i_only_long=1) then
  begin
    LongOnly.Checked:=True;
  end;

  if(i_only_short=0) then
  begin
    ShortOnly.Checked:=False;
  end
  else  if(i_only_short=1) then
  begin
    ShortOnly.Checked:=True;
  end;

  if(i_only_long=0) and (i_only_short=0) then  i_long_short_ctrl :=0;
  if(i_only_long=1) or (i_only_short=1) then  i_long_short_ctrl :=1;

  Edit_vol_chk.Text:=IntToStr(i_chk_power_vol_set);


  //ff_sg.Options := Header.Options - [goVertLine, goHorzLine];
  ff_sg.ColCount:=7;
  ff_sg.RowCount:=i_fc_count+1;

  ff_sg.Color := clBlack;
  ff_sg.Cells[0,0] := '账      号';
  ff_sg.Cells[1,0] := '名      称';
  ff_sg.Cells[2,0] := '多  成  本';
  ff_sg.Cells[3,0] := '多数量';
  ff_sg.Cells[4,0] := '空  成  本';
  ff_sg.Cells[5,0] := '空数量';
  ff_sg.Cells[6,0] := '总  资  产';

  ff_sg.ColWidths[0]:=100;
  ff_sg.ColWidths[1]:=100;
  ff_sg.ColWidths[2]:=100;
  ff_sg.ColWidths[3]:=70;
  ff_sg.ColWidths[4]:=100;
  ff_sg.ColWidths[5]:=70;
  ff_sg.ColWidths[6]:=120;

end;

procedure TMAINFORM.FormDestroy(Sender: TObject);
begin
  FF_release_comm_obj();
end;

procedure TMAINFORM.KonlyClick(Sender: TObject);
begin
  if(i_make_k_only =0) and (Konly.Checked = false) then
  begin
    Konly.Checked:=True;
    i_make_k_only :=128;
  end
  else if(i_make_k_only >0) and (Konly.Checked = true) then
  begin
    Konly.Checked:=false;
    i_make_k_only :=0;
  end;
end;

procedure TMAINFORM.Label_statusClick(Sender: TObject);
begin
  s_caption_status :=' ';
end;

procedure TMAINFORM.LongOnlyClick(Sender: TObject);
begin
  if(i_only_long=0) and (LongOnly.Checked = false) then
  begin
    LongOnly.Checked:=True;
    i_only_long:=1;
    i_only_short:=0;
  end
  else  if(i_only_long=1) and (LongOnly.Checked = true) then
  begin
    LongOnly.Checked:=false;
    i_only_long:=0;
  end;

  if(i_only_short=0) then
  begin
    ShortOnly.Checked:=False;
  end
  else  if(i_only_short=1) then
  begin
    ShortOnly.Checked:=True;
  end;

  if(i_only_long=0) and (i_only_short=0) then  i_long_short_ctrl :=0;
  if(i_only_long=1) or (i_only_short=1) then  i_long_short_ctrl :=1;

end;

procedure TMAINFORM.Long_STPClick(Sender: TObject);
begin
  if Long_STP.Checked =True Then  Long_STP.Checked :=False else Long_STP.Checked :=True;
  if Long_STP.Checked =True Then  s_caption_long_stp :='+' else s_caption_long_stp :=' ';
  if Long_STP.Checked =True Then  i_stp_long :=888 else i_stp_long :=0;
  if Long_STP.Checked =True Then  i_act_stp_long_mark :=0;

  if i_stp_long =888 Then  Long_STP.Checked :=True;

  if( StrLen(PChar(Edit_long_stp.Text)) >0 ) Then i_set_stp_long := StrToInt(Edit_long_stp.Text)
  else i_set_stp_long :=0;

  if( i_set_stp_long > 9 ) Then
  begin
    i_set_stp_long_wk := i_set_stp_long;
  end
  else i_set_stp_long_wk :=0;
end;


procedure TMAINFORM.N15Click(Sender: TObject);
begin
  i_no_trade:=888;

end;

procedure TMAINFORM.N22Click(Sender: TObject);
begin
  if f_sale_1 <1.0 Then Exit;
  i_BSK :=1;
  i_ff_get_qty_88 := 88;
end;

procedure TMAINFORM.N23Click(Sender: TObject);
begin
  if f_buy_1 <1.0 Then Exit;
  i_BSK :=2;
  i_ff_get_qty_88 := 88;
end;

procedure TMAINFORM.N24Click(Sender: TObject);
begin
  if f_buy_1 <1.0 Then Exit;
  i_BSK :=3;
  i_ff_get_qty_88 := 88;
end;

procedure TMAINFORM.N25Click(Sender: TObject);
begin
  if f_sale_1 <1.0 Then Exit;
  i_BSK :=4;
  i_ff_get_qty_88 := 88;

end;

procedure TMAINFORM.N27Click(Sender: TObject);
begin
  i_no_trade:=0;
end;

procedure TMAINFORM.N29Click(Sender: TObject);
begin
  if f_buy_1 <1.0 Then Exit;
  i_BSK :=5;
  s_caption_8:='    ';
  s_caption_9:='    ';
  s_caption_10:='    ';
  s_caption_11:='    ';

end;

procedure TMAINFORM.N32Click(Sender: TObject);
begin
  if f_buy_1 <1.0 Then Exit;
  i_BSK :=6;

  s_caption_8:='    ';
  s_caption_9:='    ';
  s_caption_10:='    ';
  s_caption_11:='    ';

end;

procedure TMAINFORM.N37Click(Sender: TObject);
begin
  //ClearLong +2
  if f_buy_1 <1.0 Then Exit;
  i_BSK :=7;
  //i_ff_get_qty_88 := 188;

end;

procedure TMAINFORM.N4Click(Sender: TObject);
begin
  i_cut_lock_long :=0;

  if N4.Checked =True Then  N4.Checked :=False else N4.Checked :=True;
  if N4.Checked =True Then  s_caption_15 :='锁' else s_caption_15 :=' ';
  if N4.Checked =True Then  i_lock_long :=888 else i_lock_long :=0;
  if N4.Checked =True Then  i_cut_lock_long_mark :=0;

  if i_lock_long =888 Then  N4.Checked :=True;

  if( StrLen(PChar(Edit1.Text)) >0 ) Then i_set_lock_long := StrToInt(Edit1.Text)
  else i_set_lock_long :=0;

  if( i_set_lock_long > 9 ) Then
  begin
    i_set_lock_long_wk := i_set_lock_long;
  end
  else i_set_lock_long_wk :=0;

end;

procedure TMAINFORM.N5Click(Sender: TObject);
begin
  i_cut_lock_short :=0;

  if N5.Checked =True Then  N5.Checked :=False else N5.Checked :=True;
  if N5.Checked =True Then  s_caption_16 :='锁' else s_caption_16 :=' ';
  if N5.Checked =True Then  i_lock_short :=888 else i_lock_short :=0;
  if N5.Checked =True Then  i_cut_lock_short_mark :=0;

  if i_lock_short =888 Then  N5.Checked :=True;

  if( StrLen(PChar(Edit2.Text)) >0 ) Then i_set_lock_short := StrToInt(Edit2.Text)
  else i_set_lock_short :=0;

  if( i_set_lock_short > 9 ) Then
  begin
    i_set_lock_short_wk := i_set_lock_short;
  end
  else i_set_lock_short_wk :=0;

end;

procedure TMAINFORM.NextFCClick(Sender: TObject);
begin

  i_fc_wk_index := i_fc_wk_index +1;
  if(i_fc_wk_index >i_fc_count -1 ) Then i_fc_wk_index := 0;

  s_caption_8:='    ';
  s_caption_9:='    ';
  s_caption_10:='    ';
  s_caption_11:='    ';

  i_got_it_mark :=0;
  i_short_mark :=0;
  i_ff_get_qty_88 := 8;
end;

procedure TMAINFORM.Only1Click(Sender: TObject);
begin
  if Only1.Checked =True Then  Only1.Checked :=False else Only1.Checked :=True;
  if Only1.Checked =True Then  i_only_1 := 1 else i_only_1 := 0;

  if Only1.Checked =True Then  s_caption_14 :='单发' else s_caption_14 :='群发';

end;

procedure TMAINFORM.ShortOnlyClick(Sender: TObject);
begin
  if(i_only_short=0) and (ShortOnly.Checked = false) then
  begin
    ShortOnly.Checked:=True;
    i_only_short:=1;
    i_only_long:=0;
  end
  else  if(i_only_short=1) and (ShortOnly.Checked = true) then
  begin
    ShortOnly.Checked:=false;
    i_only_short:=0;
  end;

  if(i_only_long=0) then
  begin
    LongOnly.Checked:=False;
  end
  else  if(i_only_long=1) then
  begin
    LongOnly.Checked:=True;
  end;

  if(i_only_long=0) and (i_only_short=0) then  i_long_short_ctrl :=0;
  if(i_only_long=1) or (i_only_short=1) then  i_long_short_ctrl :=1;

end;

procedure TMAINFORM.Short_STPClick(Sender: TObject);
begin
  if Short_STP.Checked =True Then  Short_STP.Checked :=False else Short_STP.Checked :=True;
  if Short_STP.Checked =True Then  s_caption_short_stp :='+' else s_caption_short_stp :=' ';
  if Short_STP.Checked =True Then  i_stp_short :=888 else i_stp_short :=0;
  if Short_STP.Checked =True Then  i_act_stp_short_mark :=0;

  if i_stp_short =888 Then  Short_STP.Checked :=True;

  if( StrLen(PChar(Edit_short_stp.Text)) >0 ) Then i_set_stp_short := StrToInt(Edit_short_stp.Text)
  else i_set_stp_short :=0;

  if( i_set_stp_short > 9 ) Then
  begin
    i_set_stp_short_wk := i_set_stp_short;
  end
  else i_set_stp_short_wk :=0;
end;

procedure TMAINFORM.Timer1Timer(Sender: TObject);
begin
  ff_set_caption();
end;

end.
