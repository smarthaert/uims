unit untConsts;

interface

const
  STR_APPNAME = 'OrderHelper 1.0';
  STR_APPTITLE = 'Order System Manager';
  STR_TUNNELVERSION = '1.00';
  STR_WHERE = 'order_status=1 and shipping_status=3'; //查询已确认，配货中的订单
  STR_SEARCH_FMT = 'order_status=1 and (consignee LIKE %s OR tel LIKE %s OR mobile LIKE %s OR invoice_no LIKE %s OR order_sn LIKE %s)';
resourcestring
  RSTR_CHECK_VERSION = '软件版本过低，请升级程序后运行！';
  RSTR_LOGIN_USRPWINPUT = '用户名/密码错误，请重新输入。';
  RSTR_INPUT_SEARCHKEYWORD = '查找关键字不允许为空，请输入后查找。';
  RSTR_EMPTY_INVOICE_NO = '快递单号不允许为空，请输入后提交。';
  RSTR_EMPTY_PAYMENT = '配送方式未选择，请选择后提交。';
  RSTR_EMPTY_PRINT = '请选择要操作的记录。';
  RSTR_POST_ORDERINFOFAILMSG = '订单修改提交失败，请咨询相关人员。';
  RSTR_NOTFOUND_INVOICE_NO = '快递单号不存在，请编辑订单';
  RSTR_NOTFOUND_SHIPPING = '配置送方式不存在，请编辑订单';
  RSTR_NOTFOUND_MODFILE = '配送方式的打印模板文件不存在。';
  RSTR_MAIN_MSG = ' 本软件针对网站后台发货订单进行快递单的快速打印。';
  RSTR_MAIN_TITLE = '快递单打印正式版';
  RSTR_MAIN_MSG2 = '内容已复制到剪贴板中';
var
  PServerName:string;
  PAdminName:string;
  PServiceURL:string;
  PSearchKeyWord:string;
  PWhere:string;
  PReportFile:string; //批量打印保存第一次所选择的模板
  PPrintName:string;
  PIsPrint:Boolean;
  
implementation

end.
 