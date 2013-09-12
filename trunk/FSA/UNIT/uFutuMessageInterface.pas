{/**********************************************************************
* 源程序名称: futu_message_interface.h
* 软件著作权: 恒生电子股份有限公司
* 系统名称  : 06版本期货系统
* 模块名称  : 恒生期货周边接口
* 功能说明  : 周边接口数据操作定义
* 作    者  : xdx
* 开发日期  : 20110315
* 备    注  : 数据类型定义
* 修改人员  ：
* 修改日期  ：
* 修改说明  ：20110315 创建
**********************************************************************/}

unit uFutuMessageInterface;

interface

uses
  Classes;

type

//各类接口统一的查询与引用接口 (参照COM标准)
  IHSKnown = class
  public
    {/**
    * 查询与当前接口相关的其他接口(本接口中一般不使用)
     *@param HS_SID  iid  接口全局唯一标识
     *@param IKnown **ppv 返回iid对应的接口指针
     *@return R_OK 成功，R_FAIL 未查到iid 相应接口
    */}
    function QueryInterface(const iid: PChar; ppv: Pointer): Integer; virtual; stdcall; abstract;

    {/**
     * 引用接口，引用计数加一
     *@return 当前引用计数
    */}
    function AddRef(): Integer; virtual; stdcall; abstract;

    {/**
     * 释放接口，引用计数减一，计数为0时释放接口的实现对象
     *@param R_OK表示成功,其他表示失败
    */}
    function Release(): Integer; virtual; stdcall; abstract;
  end;


{/*
  一条消息数据记录,包含了很多的tag=value,其中tag不重复
  重复插入相同的tag,则覆盖上次的数据
  为了使接口跨语言,仅支持以下数据类型:
          单字符型(char),如'A','1',
 整型(int),如123,-2343
 浮点型(float),如23.50,-34.34
 字符串型(C语言风格'\0'结尾的串)(char*),如"Hello World"
  注意其接口方法线程安全性
*/}
  IFuRecord = class(IHSKnown)
  public
    ///添加数据的方法,若存在field则覆盖其值
    {/**
      * 添加一个字符型值
      *@param sField   字段名称
      *@param cValue   一个字符值
      *@return R_OK添加成功,其他表示失败
      [非线程安全]
    */}
    function SetChar(const sField: PChar; cValue: Char): Integer; virtual; stdcall; abstract;

    {/**
      * 添加一个整型值
      *@param sField 字段名称
      *@param iValue 一个整型值
      *@return R_OK添加成功,其他表示失败
      [非线程安全]
    */}
    function SetInt(const sField: PChar; iValue: Integer): Integer; virtual; stdcall; abstract;

    {/**
      * 添加一个浮点值
      *@param sField 字段名称
      *@param cValue 一个浮点值
      *@return R_OK添加成功,其他表示失败
      [非线程安全]
    */}
    function SetDouble(const sField: PChar; dValue: Double): Integer; virtual; stdcall; abstract;

    {/**
      * 添加一个字符串(C语言格式'\0'结尾的字符串)
      *@param sField 字段名称
      *@param cValue 一个字符串值
      *@return R_OK添加成功,其他表示失败
      [非线程安全]
    */}
    function SetString(const sField: PChar; const strValue: PChar): Integer; virtual; stdcall; abstract;

    ///根据字段访问数据的方法

    {/**
      * 获取一个字符型值
      *@param sField 字段名称
      *@return 有效字符值;字段不存在则默认'\0'
      [线程安全]
    */}
    function GetChar(const sField: PChar): Char; virtual; stdcall; abstract;

    {/**
      * 获取一个整型值
      *@param sField 字段名称
      *@return 返回一个整型值;字段不存在则默认返回0
      [线程安全]
    */}
    function GetInt(const sField: PChar): Integer; virtual; stdcall; abstract;

    {/**
      * 获得一个浮点值
      *@param sField 字段名称
      *@return 返回一个整型值;字段不存在则默认返回0.0(注意浮点型的精度问题)
      [线程安全]
    */}
    function GetDouble(const sField: PChar): Double; virtual; stdcall; abstract;

    {/**
      * 获得一个字符串
      *@param sField 字段名称
      *@return 返回一个字符串,如不存在该字段则返回NULL(0)
      [线程安全]
    */}
    function GetString(const sField: Pchar): PChar; virtual; stdcall; abstract;

    ///遍历访问方法,通过此访问可遍历整个条记录
    {/**
      * 移动到记录头(第一个tag=value)
      *@return R_OK表示成功,其他表示失败
      [非线程安全]
    */}
    function MoveFirst(): Integer; virtual; stdcall; abstract;

    {/**
      * 下一条记录
      *@return R_OK表示成功,其他表示失败或已经到记录尾
      [非线程安全]
    */}
    function MoveNext(): Integer; virtual; stdcall; abstract;

    {/**
      * 判断是否移到了记录尾
      *@return 0表示未到记录尾,1表示已到记录尾
      [非线程安全]
    */}
    function IsEOF(): Integer; virtual; stdcall; abstract;

    {/**
      * 获取当前字段名(通过该名可以访问到值)
      *@return NULL表示已到结尾或无数据,非NULL表示字段名
      [线程安全]
    */}
    function GetFieldName(): PChar; virtual; stdcall; abstract;

    {/**
      * 删除一个字段
      *@param sField 要删除的字段名
      *@return R_OK表示删除成功,其他表示失败
      [非线程安全]
    */}
    function RemoveField(const sField: PChar): Integer; virtual; stdcall; abstract;

    {/**
      * 是否存在某和字段
      *@param sField 字段名
      *@return 0表示不存在,1表示存在
      [非线程安全]
    */}
    function IsExist(const sField: PChar): Integer; virtual; stdcall; abstract;

    {/**
      * 删除所有的字段
      *@return R_OK表示成功,其他表示失败
      [非线程安全]
    */}
    function Clear(): Integer; virtual; stdcall; abstract;

    {/**
      * 获取记录个数(Field=Value)
      *@return 表示记录的条数
      [线程安全]
    */}
    function GetCount(): Integer; virtual; stdcall; abstract;
  end;


///期货消息接口,一条消息表明了其消息的类型,并由一个或多这个IFuRecord组成
  IFuMessage = class(IHSKnown)
  public
    {/**
      * 设置消息类型
      *@param iType 参见FUTU_MSG_TYPE的定义
      *@param iMode 表示此消息是请求还是应答,0-请求,1-应答
      *@return R_OK表示成功,其他表示无效或不支持的消息类型
      [非线程安全]
    */}
    function SetMsgType(iType: Integer; iMode: Integer): Integer; virtual; stdcall; abstract;

    {/**
      * 获取消息类型
      *@param [int]消息类型.参考FUTU_MSG_TYPE的定义
      *@return 消息模式.参考FUTU_MSG_MODE的定义
      [线程安全]
    */}
    function GetMsgType(iMsgMode: PInteger = nil): Integer; virtual; stdcall; abstract;

    {/**
      * 获取记录条数
      *@param >=0表示记录条数,其他表示错误或失败
      [线程安全]
    */}
    function GetCount(): Integer; virtual; stdcall; abstract;

    {/**
      * 新增一条记录,操作返回的指针以操作其值
      *@return 非NULL表示一条有效的记录,NULL表示分配内存失败
      [非线程安全]
    */}
    function AddRecord(): IFuRecord; virtual; stdcall; abstract;

    {/**
      * 获取一条记录
      *@param iIndex 记录索引位置,从0开始计数
      *@return 非NULL表示一条有效的记录,NULL表示索引越界
      [非线程安全]
    */}
    function GetRecord(iIndex: Integer = 0): IFuRecord; virtual; stdcall; abstract;

    {/**
      * 删除一条记录
      *@param iIndex 记录索引位置,从0开始计数
      *@return R_OK表示删除功能,否则失败(可能是索引越界)
      [非线程安全]
    */}
    function DelRecord(iIndex: Integer = 0): Integer; virtual; stdcall; abstract;

    {/**
      * 删除所有的记录
      *@return R_OK表示成功,其他表示失败
      [非线程安全]
    */}
    function Clear(): Integer; virtual; stdcall; abstract;
  end;

implementation

end.
