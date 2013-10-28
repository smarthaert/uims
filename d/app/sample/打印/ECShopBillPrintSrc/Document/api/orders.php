<?php
/**
 *  提供订单中心的远程调用接口
 *
**/
define('IN_ECS', true);
define('TUNNELVERSION', '1.00');
require('./init.php');
require_once(ROOT_PATH . 'includes/cls_json.php');
include_once(ROOT_PATH . 'includes/lib_order.php');
require_once(ROOT_PATH. "api/phprpc/phprpc_server.php");

$_LANG['ps'][PS_UNPAYED] = '未付款';
$_LANG['ps'][PS_PAYING] = '付款中';
$_LANG['ps'][PS_PAYED] = '已付款';

$_LANG['ss'][SS_UNSHIPPED] = '未发货';
$_LANG['ss'][SS_PREPARING] = '配货中';
$_LANG['ss'][SS_SHIPPED]   = '已发货';
$_LANG['ss'][SS_RECEIVED]  = '收货确认';

$funlist = array(
                 'get_version',           //获取程序版本信息
                 'server_info',           //获取服务器信息
                 'get_goods_list',        //获取商品列表
                 'get_orders_list',       //获取订单列表
                 'get_order_info',        //获取订单信息
                 'pos_order_info',        //提交订单信息
                 'pos_order_shipping',    //变更订单发货状态
                 'shipping_list',         //获取已安装的配送方式
                 'get_order_print_info',  //获取订单打印信息
                 'admin_signin',          //管理员登陆验证
                 'get_table_count',       //获取数据表记录数
                 );

$server = new PHPRPC_Server();
$server->add($funlist);
$server->start();

/**
 * 获取程序版本信息
 *
 * @access  private
 * @param   
 * @return  array
 */
function get_version()
{
    return TUNNELVERSION;
}

/**
 * 检查帐号权限
 *
 * @access  private
 * @param   
 * @return  array
 */
function check_priviege()
{
    return true;
    global $sess;
    $sess->load_session();

    if ((!isset($_SESSION['admin_id']) || intval($_SESSION['admin_id']) <= 0))
    {
        //session 不存在，检查cookie
        if (!empty($_COOKIE['ECSCP']['admin_id']) && !empty($_COOKIE['ECSCP']['admin_pass']))
        {
            // 找到了cookie, 验证cookie信息
            $sql = 'SELECT user_id, user_name, password, action_list, last_login ' .
                ' FROM ' .$ecs->table('admin_user') .
                " WHERE user_id = '" . intval($_COOKIE['ECSCP']['admin_id']) . "'";
            $row = $db->GetRow($sql);
            
            if (!$row)
            {
                // 没有找到这个记录
                setcookie($_COOKIE['ECSCP']['admin_id'],   '', 1);
                setcookie($_COOKIE['ECSCP']['admin_pass'], '', 1);                
                return false;
            }
            else
            {
                // 检查密码是否正确
                if (md5($row['password'] . $_CFG['hash_code']) == $_COOKIE['ECSCP']['admin_pass'])
                {
                    !isset($row['last_time']) && $row['last_time'] = '';
                    set_admin_session($row['user_id'], $row['user_name'], $row['action_list'], $row['last_time']);
                    // 更新最后登录时间和IP
                    $db->query('UPDATE ' . $ecs->table('admin_user') .
                            " SET last_login = '" . gmtime() . "', last_ip = '" . real_ip() . "'" .
                            " WHERE user_id = '" . $_SESSION['admin_id'] . "'");
                    return true;
                }
                else
                {
                    setcookie($_COOKIE['ECSCP']['admin_id'],   '', 1);
                    setcookie($_COOKIE['ECSCP']['admin_pass'], '', 1);
                    return false;
                }
            }
        }
        else
        {
            return false;
        }        
    }
    else
    {
        return true;
    }
}

/**
 * 获得订单列表信息
 *
 * @access  private
 * @param   
 * @return  array
 */
function get_orders_list($page, $pagesize, $where='1')
{
    if (!check_priviege())
    {
        exit;
    }
    $order = '';
    if ($where =='order_status=1 and shipping_status=1')
    {
        $today      = strtotime(local_date('Y-m-d'));
        $start_date = $today;
        $end_date   = $today + 86399;
        $where .= " and (shipping_time >= '$start_date' and shipping_time <= '$end_date')";
        $order = "shipping_time DESC, shipping_name, shipping_time DESC";
    }
	else
	{
		$order = "order_id ASC, shipping_time DESC, shipping_name ";
	}
    
    $sql = "SELECT order_id, order_sn, consignee, address, invoice_no, shipping_name, pay_name, pay_status, shipping_status, add_time ".
           " FROM ". $GLOBALS['ecs']->table('order_info') .
           " WHERE $where and ( address<>'' ) " .
           " ORDER BY $order  LIMIT " . $page * $pagesize . ",$pagesize";
    $res = $GLOBALS['db']->getAll($sql);

    foreach($res as $key => $val)
    {
        $res[$key]['order_id']      = $val['order_id'];
        $res[$key]['order_sn']      = $val['order_sn'];
        $res[$key]['consignee']     = $val['consignee'];
        $res[$key]['address']       = $val['address'];
        $res[$key]['goods_amount']  = $val['goods_amount'];
        $res[$key]['shipping_name'] = $val['shipping_name'];
        $res[$key]['pay_name']      = $val['pay_name'];
        $res[$key]['shipping_status'] = $GLOBALS['_LANG']['ps'][$val['pay_status']].','.$GLOBALS['_LANG']['ss'][$val['shipping_status']]; 
        $res[$key]['add_time']      = local_date($GLOBALS['_CFG']['time_format'], $val['add_time']);
    }
    return $res;
}   

/**
 * 获得订单详细信息
 *
 * @access  private
 * @param   
 * @return  array
 */
function get_order_info($order_id)
{
    if (!check_priviege())
    {
        exit;
    }
    
    $sql = "SELECT order_id, order_sn, consignee, address, invoice_no, shipping_name, pay_name, add_time, zipcode, best_time, postscript, to_buyer ".
           " FROM ". $GLOBALS['ecs']->table('order_info') .
           " WHERE order_id = '$order_id' LIMIT 1 ";
    $res = $GLOBALS['db']->getRow($sql);
    
	if ($res['pay_name'] == '网银支付')
	{
		$res['pay_name'] = '网银在线';
	}
	
	$res['best_time'] = $res['best_time'] == '' ? '客户没有填写': $res['best_time'];
	$res['postscript'] = $res['postscript'] == '' ? '客户没有填写': $res['postscript'];
    $res['add_time'] = local_date($GLOBALS['_CFG']['time_format'], $res['add_time']);
    return $res;
}

function get_table_count($table_name, $where=' 1')
{
    if (!check_priviege())
    {
        exit;
    }

    if ($where =='order_status=1 and shipping_status=1')
    {
        $today      = strtotime(local_date('Y-m-d'));
        $start_date = $today;
        $end_date   = $today + 86399;
        $where .= " and (shipping_time >= '$start_date' and shipping_time <= '$end_date')";
        $order_ext = 'shipping_time DESC,';
    }

    return $GLOBALS['db']->getOne('SELECT COUNT(*) FROM ' . $GLOBALS['ecs']->table($table_name) . " WHERE $where");
}

/**
 * 获得订单打印的详细信息
 *
 * @access  private
 * @param   
 * @return  array
 */
function get_order_print_info($order_id)
{
    if (!check_priviege())
    {
        exit;
    }
    
    $sql = "SELECT consignee, address, tel, mobile, order_amount, shipping_id, shipping_name, pay_name, zipcode, to_buyer ".
           " FROM ". $GLOBALS['ecs']->table('order_info') .
           " WHERE order_id = '$order_id' LIMIT 1 ";
    $res = $GLOBALS['db']->getRow($sql);
    
    $shipping_id = $res['shipping_id'];
    $res['consignee'] = str_replace("[", "['[", $res['consignee']);
    $res['consignee'] = str_replace("]", "]']", $res['consignee']);

    $sql = "SELECT g.goods_brief, og.goods_number FROM " . $GLOBALS['ecs']->table('order_goods') . " AS og, ".
           $GLOBALS['ecs']->table('goods') . " AS g ".
           " WHERE og.order_id = '$order_id' AND og.goods_id = g.goods_id ";  
    $goods = $GLOBALS['db']->getAll($sql);

    $contentname = '';
    $CRLF = '';
    foreach($goods AS $key => $value)
    {
        if ($key > 0) $CRLF= "，";
        $contentname .= $CRLF.$goods[$key]['goods_brief']. ($goods[$key]['goods_number']>1 ? "(数量:". $goods[$key]['goods_number'] .")" : '');
    }
    
    $sql = "SELECT shipping_code FROM ". $GLOBALS['ecs']->table('shipping').
           " WHERE shipping_id = '$shipping_id' ";
    $shipping_code = $GLOBALS['db']->getOne($sql);
    
    $arr = array();
    
    //寄件人信息
    $arr['sendername']       = '广州';
    $arr['senderaddress']    = '广州市东风东路xxxx';
    $arr['senderphone']      = '4008-888-888';
    $arr['senderzipcode']    = '510000';

    //收件人信息    
    $arr['recipientname']    = $res['consignee'];
    $arr['recipientaddress'] = $res['address'];
    $arr['recipientzipcode'] = $res['zipcode'];
    $arr['recipientphone']   = make_semiangle($res['tel']);
    $arr['recipientmobile']  = $res['tel'] == $res['mobile'] ? '': make_semiangle($res['mobile']);
    $arr['payamount_small']  = price_format($res['order_amount']);
    $arr['payamount_big']    = $res['order_amount']; 
    $arr['contentname']      = $contentname;
    $arr['payment']          = '√月结';
    $arr['shipping_code']    = $shipping_code;
    $arr['to_buyer']         = $res['to_buyer'];

    return $arr;
}

/**
 * 提交订单信息
 *
 * @access  private
 * @param   string $brand_name
 * @return  array
 */
function pos_order_info($arr)
{
    if (!check_priviege())
    {
        exit;
    }
    
    $order_id      = $arr[0];
    $order_sn      = $arr[1];
    $consignee     = $arr[2];
    $address       = $arr[3];
    $invoice_no    = $arr[4];
    $shipping_id   = $arr[5];
    $shipping_name = $arr[6];
    $pay_name      = $arr[7];
    $add_time      = $arr[8];
    $zipcode       = $arr[9];
    $best_time     = $arr[10];
    $postscript    = $arr[11];
    $to_buyer      = $arr[12];

    $operation = 'ship';
    
    /* 查询订单信息 */
    $order = order_info($order_id);
    
    /* 检查能否操作 */
//    $operable_list = operable_list($order);
//    if (!isset($operable_list[$operation]))
//    {
//        die('Hacking attempt');
//    }
    
    //提交订单信息
    $post['shipping_id']    = $shipping_id;
    $post['shipping_name']  = ecs_iconv('gbk', EC_CHARSET, $shipping_name);
    $post['invoice_no']     = $invoice_no;
    $post['zipcode']        = $zipcode;
    //$post['to_buyer']       = $to_buyer;
    update_order($order_id, $post);
	
	if ($invoice_no != $order['invoice_no'])
	{
            if ($order['invoice_no'] != '')
            {
                $action_note = '[OrderHelper '. TUNNELVERSION .'] 更新快递单号 ' .$invoice_no;
            }
            else
            {
                $action_note = '[OrderHelper '. TUNNELVERSION .'] 提交快递单号 '. $invoice_no;
            }
            /* 记录log */
            order_action($order['order_sn'], $order['order_status'], $order['shipping_status'], $order['pay_status'], $action_note);
	}
}

/**
 * 变更订单的发货状态
 *
 * @access  private
 * @param   string $brand_name
 * @return  array
 */
function pos_order_shipping($order_id)
{
    if (!check_priviege())
    {
        exit;
    }

    $operation = 'ship';
    
    /* 查询订单信息 */
    $order = order_info($order_id);
    
    /* 检查能否操作 */
    $operable_list = operable_list($order);
    if (!isset($operable_list[$operation]))
    {
        die('Hacking attempt');
    }

    if ($order['order_status'] != OS_CONFIRMED)
    {
        $post['order_status']        = OS_CONFIRMED;
        $post['confirm_time']        = gmtime();
    }
    
    $post['shipping_status']     = SS_SHIPPED;
    $post['shipping_time']       = gmtime();
    update_order($order_id, $post);
    $action_note = '[OrderHelper '. TUNNELVERSION .'] 打印快递单';
    
    /* 记录log */
    order_action($order['order_sn'], OS_CONFIRMED, SS_SHIPPED, $order['pay_status'], $action_note);
}

function WriteLog ( $loginfo )
{
   $fp = fopen ( "rpc_ecshop.log", "aw" );
   if ( $fp == FALSE ) return;
   fwrite ( $fp, $loginfo. "\r\n" );
   fclose ( $fp );
}

/* 管理员登陆 */
function admin_signin($username, $password)
{
    $sql = "SELECT user_id, user_name, password, last_login, action_list, last_login, last_ip".
            " FROM " . $GLOBALS['ecs']->table('admin_user') .
            " WHERE user_name = '$username' AND password = '$password'" . " AND manager_id in ('0','4','40','99')";
    $row = $GLOBALS['db']->getRow($sql);
    
    $arr = array();
    if ($row)
    {
        //登陆成功
        set_admin_session($row['user_id'], $row['user_name'], $row['action_list'], $row['last_login']);
        if($row['action_list'] == 'all' && empty($row['last_login']))
        {
            //打开向导
        }
        // 更新最后登录时间和IP
        $GLOBALS['db']->query("UPDATE " .$GLOBALS['ecs']->table('admin_user').
                 " SET last_login='" . gmtime() . "', last_ip='" . real_ip() . "'".
                 " WHERE user_id='$_SESSION[admin_id]'");
        //保存登陆信息
        if (isset($_POST['remember']))
        {
            $time = gmtime() + 3600 * 24 * 365;
            setcookie('ECSCP[admin_id]',   $row['user_id'],                            $time);
            setcookie('ECSCP[admin_pass]', md5($row['password'] . $_CFG['hash_code']), $time);
        }
        //返回结果
        $arr['login_status']    = true;
        $arr['user_id']         = $row['user_id'];
        $arr['user_name']       = $row['user_name'];
        $arr['password']        = $row['password'];
        $arr['last_login']      = local_date($GLOBALS['_CFG']['time_format'], $row['last_login']);
        $arr['last_ip']         = $row['last_ip'];
        $arr['action_list']     = $row['action_list'];
    }
    else
    {
        //登陆失败
        $arr['login_status']    = false;
        $arr['user_id']         = 0;
        $arr['user_name']       = 'guest';
        $arr['password']        = '';
        $arr['last_login']      = '0000-00-00 00:00:00';
        $arr['last_ip']         = '0.0.0.0';
        $arr['action_list']     = '';
    }
    return $arr;
}

/**
 * 设置管理员的session内容
 *
 * @access  public
 * @param   integer $user_id        管理员编号
 * @param   string  $username       管理员姓名
 * @param   string  $action_list    权限列表
 * @param   string  $last_time      最后登录时间
 * @return  void
 */
function set_admin_session($user_id, $username, $action_list, $last_time)
{
    $_SESSION['admin_id']    = $user_id;
    $_SESSION['admin_name']  = $username;
    $_SESSION['action_list'] = $action_list;
    $_SESSION['last_check']  = $last_time; // 用于保存最后一次检查订单的时间
}

/* 系统函数 */
/**
 * 返回某个订单可执行的操作列表，包括权限判断
 * @param   array   $order      订单信息 order_status, shipping_status, pay_status
 * @param   bool    $is_cod     支付方式是否货到付款
 * @return  array   可执行的操作  confirm, pay, unpay, settle, unsettle, prepare, ship, unship, receive, cancel, invalid, return, drop
 * 格式 array('confirm' => true, 'pay' => true)
 */
function operable_list($order)
{
    /* 取得订单状态、发货状态、付款状态、结算状态 */
    $os = $order['order_status'];
    $ss = $order['shipping_status'];
    $ps = $order['pay_status'];
    $es = $order['settle_status'];

    /* 取得订单操作权限 */
    $actions = $_SESSION['action_list'];
    if ($actions == 'all')
    {
        $priv_list  = array('os' => true, 'ss' => true, 'ps' => true, 'es' => true, 'edit' => true);
    }
    else
    {
        $actions    = ',' . $actions . ',';
        $priv_list  = array(
            'os'    => strpos($actions, ',order_os_edit,') !== false,
            'ss'    => strpos($actions, ',order_ss_edit,') !== false,
            'ps'    => strpos($actions, ',order_ps_edit,') !== false,
            'es'    => strpos($actions, ',order_ps_edit,') !== false,
            'edit'  => strpos($actions, ',order_edit,') !== false
        );
    }

    /* 取得订单支付方式是否货到付款 */
    $payment = payment_info($order['pay_id']);
    $is_cod  = $payment['is_cod'] == 1;

    /* 根据状态返回可执行操作 */
    $list = array();
    if (OS_UNCONFIRMED == $os)
    {
        /* 状态：未确认 => 未付款、未发货 */
        if ($priv_list['os'])
        {
            $list['confirm']    = true; // 确认
            $list['invalid']    = true; // 无效
            $list['cancel']     = true; // 取消
            if ($is_cod)
            {
                /* 货到付款 */
                if ($priv_list['ss'])
                {
                    $list['prepare'] = true; // 配货
                    $list['ship'] = true; // 发货
                }
            }
            else
            {
                /* 不是货到付款 */
                if ($priv_list['ps'])
                {
                    $list['pay'] = true;  // 付款
                }
            }
        }
    }
    elseif (OS_CONFIRMED == $os)
    {
        /* 状态：已确认 */
        if (PS_UNPAYED == $ps)
        {
            /* 状态：已确认、未付款 */
            if (SS_UNSHIPPED == $ss || SS_PREPARING == $ss)
            {
                /* 状态：已确认、未付款、未发货（或配货中） */
                if ($priv_list['os'])
                {
                    $list['cancel'] = true; // 取消
                    $list['invalid'] = true; // 无效
                }
                if ($is_cod)
                {
                    /* 货到付款 */
                    if ($priv_list['ss'])
                    {
                        if (SS_UNSHIPPED == $ss)
                        {
                            $list['prepare'] = true; // 配货
                        }
                        $list['ship'] = true; // 发货
                    }
                }
                else
                {
                    /* 不是货到付款 */
                    if ($priv_list['ps'])
                    {
                        $list['pay'] = true; // 付款
                    }
                }
            }
            else
            {
                /* 状态：已确认、未付款、已发货或已收货 => 货到付款 */
                if ($priv_list['ps'])
                {
                    $list['pay'] = true; // 付款
                }
                if ($priv_list['ss'])
                {
                    if (SS_SHIPPED == $ss)
                    {
                        $list['receive'] = true; // 收货确认
                    }
                    $list['unship'] = true; // 设为未发货                    
                    if ($priv_list['os'])
                    {
                        $list['return'] = true; // 退货
                    }
                }
            }
        }
        else
        {
            /* 状态：已确认、已付款和付款中 */
            if (SS_UNSHIPPED == $ss || SS_PREPARING == $ss)
            {
                /* 状态：已确认、已付款和付款中、未发货（配货中） => 不是货到付款 */
                if ($priv_list['ss'])
                {
                    if (SS_UNSHIPPED == $ss)
                    {
                        $list['prepare'] = true; // 配货
                    }
                    $list['ship'] = true; // 发货
                }
                if ($priv_list['ps'])
                {
                    $list['unpay'] = true; // 设为未付款
                    
                    if (SE_SETTLED == $es)
                    {
                        $list['unsettle'] = true; // 设为未结算
                    }
                    
                    if ($priv_list['os'])
                    {
                        $list['cancel'] = true; // 取消
                    }
                }
            }
            else
            {
                /* 状态：已确认、已付款和付款中、已发货或已收货 */
                if ($priv_list['ss'])
                {
                    if (SS_SHIPPED == $ss)
                    {
                        $list['receive'] = true; // 收货确认
                    }
                    if (!$is_cod)
                    {
                        $list['unship'] = true; // 设为未发货                        
                    }
                    if (SE_UNSETTLE == $es)
                    {
                        $list['settle'] = true; // 设为已结算
                    }
                }
                if ($priv_list['ps'] && $is_cod)
                {
                    $list['unpay']  = true; // 设为未付款    
                }
                if ($priv_list['os'] && $priv_list['ss'] && $priv_list['ps'])
                {
                    $list['return'] = true; // 退货（包括退款）
                }
            }
        }
    }
    elseif (OS_CANCELED == $os)
    {
        /* 状态：取消 */
        if ($priv_list['os'])
        {
            $list['confirm'] = true;
        }
        if ($priv_list['edit'])
        {
            $list['remove'] = true;
        }
    }
    elseif (OS_INVALID == $os)
    {
        /* 状态：无效 */
        if ($priv_list['os'])
        {
            $list['confirm'] = true;
        }
        if ($priv_list['edit'])
        {
            $list['remove'] = true;
        }
    }
    elseif (OS_RETURNED == $os)
    {
        /* 状态：退货 */
        if ($priv_list['os'])
        {
            $list['confirm'] = true;
        }
    }

    /* 修正发货操作 */
    if (!empty($list['ship']))
    {
        /* 如果是团购活动且未处理成功，不能发货 */
        if ($order['extension_code'] == 'group_buy')
        {
            include_once(ROOT_PATH . 'includes/lib_goods.php');
            $group_buy = group_buy_info(intval($order['extension_id']));
            if ($group_buy['status'] != GBS_SUCCEED)
            {
                unset($list['ship']);
            }
        }
    }

    /* 售后 */
    $list['after_service'] = true;

    return $list;
}

?>