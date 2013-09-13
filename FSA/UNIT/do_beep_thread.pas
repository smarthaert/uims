unit do_beep_thread;

interface

uses
  Windows, Messages, SysUtils, Classes, s_lib_pas_unit;

type
  Tth_beep = class(TThread)
    i_do_main_loop_mark: Integer;
  private
    { Private declarations }
  protected
    procedure Execute; override;
  end;

implementation
uses ff_hs_base, ff_ib_dm;

procedure Tth_beep.Execute;
var
  i_tmp, iRet, i_loop_count: Integer;
  s_tmp_log: string;
  s_tmp: string;
  s_tmp1: string;
  f_tmp: Single;
begin
  { Place thread code here }
  //1.check time,loop,wait
  //2.main loop

  try

    i_loop_count := 888;

    Sleep(18000);

  //frmMain2.GRID_S001.Cells[0,0]:=pc_what_wk;

    if (i_comm_ok = 0) then
    begin
      frmMain2.Header.Cells[14, 0] := '断开';
    end
    else
    begin
      frmMain2.Header.Cells[14, 0] := '联机';
    end;

    Sleep(15000);

    s_tmp := FormatDateTime('hhnn', Now);
    s_tmp1 := FormatDateTime('hhnn', Now);
    f_tmp := 0.0;

    while not Terminated do
    begin
   //Beep();
    //s_sleep_us(2000000);

      if i_do_main_loop_mark = 0 then
      begin

        iRet := 888;

        if (not g_bStop) then
        begin
          if (WAIT_OBJECT_0 = WaitForSingleObject(g_hEvent, INFINITE)) then
     //if(WAIT_OBJECT_0 = WaitForSingleObject(g_hEvent,1000) ) then
          begin

            if (i_comm_ok = 0) then
            begin
              frmMain2.Header.Cells[14, 0] := '断开';
            end
            else
            begin
              frmMain2.Header.Cells[14, 0] := '联机';
            end;

       //退出
            if g_bStop then
            begin
              Exit;
            end;

            while (iRet <> 0) do
            begin
              try
                W_Log('Call Start', 8, 999, 'check lpComm_Start here!');
         //Sleep(1000);
                iRet := m_lpComm.Start(g_iType);
                if (iRet = 0) then
                begin
                  i_comm_ok := 888;
                  ResetEvent(g_hEvent);
                  break;
                end;
                Sleep(1000);

              except
                W_Log('try_except', 9, 999, 'lpComm_Start exception');
              end;
            end;

          end;
        end;
      end
      else
      begin
    //s_sleep_us(300000);
        s_sleep_us(200000);

        s_tmp := FormatDateTime('hhnn', Now);

        if (StrToInt(s_tmp) > StrToInt(s_tmp1)) then
        begin
          s_tmp1 := s_tmp;
          i_tmp := ff_dm.GetSszjToday(f_tmp);
          if i_tmp = 0 then
          begin
            W_Log('GetSszjToday', i_tmp, 8, PChar(FloatToStrF(f_tmp, ffFixed, 8, 2)));
            as_k_chg[i_s_k_chg_index_wk].f_amount := f_tmp;
          end;
        end;

        try

          if (i_loop_count mod 100 = 0) then ff_get_qty();

          if (i_ff_get_qty_88 > 0) then
          begin
            i_ff_get_qty_88 := i_ff_get_qty_88 - 2;
            ff_get_qty();
          end;

        except
          on E: Exception do
          begin
            Assert(false, s_tmp_log);
            W_Log('ff_get_qty', 19, 999, PChar(s_tmp_log));
            W_Log('ff_get_qty', 19, 999, PChar(E.Message));
            ExitProcess(999);
          end;
        end;

        try
          ff_main_wk_loop();
        except
          on E: Exception do
          begin
            Assert(false, s_tmp_log);
            W_Log('ff_main_wk_loop', i_line_no_001, 999, PChar(s_tmp_log));
            W_Log('ff_main_wk_loop', i_line_no_001, 999, PChar(E.Message));
            ExitProcess(999);
          end;
        end;

  //if( i_loop_count mod 18 =0 )	then ff_get_qty();
  //if( i_loop_count mod 2 =0 ) then ff_main_wk_loop();
        i_loop_count := i_loop_count + 1;
        if (i_loop_count > 88888888) then i_loop_count := 0;
      end;
    end;

  finally
    ExitProcess(999);
  end;

end;

end.
