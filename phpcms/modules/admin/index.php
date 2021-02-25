<?php
defined('IN_PHPCMS') or exit('No permission resources.');
pc_base::load_app_class('admin','admin',0);

class index extends admin {
	public function __construct() {
		parent::__construct();
		$this->db = pc_base::load_model('admin_model');
		$this->menu_db = pc_base::load_model('menu_model');
		$this->panel_db = pc_base::load_model('admin_panel_model');
		$this->version_update = pc_base::load_model('version_update_model');
		$this->domain_model = pc_base::load_model('domain_model');
	}
	
	public function init () {
		$userid = $_SESSION['userid'];
		$admin_username = param::get_cookie('admin_username');
		$roles = getcache('role','commons');
		$rolename = $roles[$_SESSION['roleid']];
		$site = pc_base::load_app_class('sites');
		$sitelist = $site->get_list($_SESSION['roleid']);
		$currentsite = $this->get_siteinfo(param::get_cookie('siteid'));
		/*管理员收藏栏*/
		$adminpanel = $this->panel_db->select(array('userid'=>$userid), "*",20 , 'datetime');
		$site_model = param::get_cookie('site_model');
		include $this->admin_tpl('index');
	}
	
	public function login() {
		if(isset($_GET['dosubmit'])) {
			
			//不为口令卡验证
			if (!isset($_GET['card'])) {
				$username = isset($_POST['username']) ? trim($_POST['username']) : showmessage(L('nameerror'),HTTP_REFERER);
				$code = isset($_POST['code']) && trim($_POST['code']) ? trim($_POST['code']) : showmessage(L('input_code'), HTTP_REFERER);
				if ($_SESSION['code'] != strtolower($code)) {
					$_SESSION['code'] = '';
					showmessage(L('code_error'), HTTP_REFERER);
				}
				$_SESSION['code'] = '';
			} else { //口令卡验证
				if (!isset($_SESSION['card_verif']) || $_SESSION['card_verif'] != 1) {
					showmessage(L('your_password_card_is_not_validate'), '?m=admin&c=index&a=public_card');
				}
				$username = $_SESSION['card_username'] ? $_SESSION['card_username'] :  showmessage(L('nameerror'),HTTP_REFERER);
			}
			if(!is_username($username)){
				showmessage(L('username_illegal'), HTTP_REFERER);
			}
			//密码错误剩余重试次数
			$this->times_db = pc_base::load_model('times_model');
			$rtime = $this->times_db->get_one(array('username'=>$username,'isadmin'=>1));
			$maxloginfailedtimes = getcache('common','commons');
			$maxloginfailedtimes = (int)$maxloginfailedtimes['maxloginfailedtimes'];

			if($rtime['times'] >= $maxloginfailedtimes) {
				$minute = 60-floor((SYS_TIME-$rtime['logintime'])/60);
				if($minute>0) showmessage(L('wait_1_hour',array('minute'=>$minute)));
			}
			//查询帐号
			$r = $this->db->get_one(array('username'=>$username));
			if(!$r) showmessage(L('user_not_exist'),'?m=admin&c=index&a=login');
			$password = md5(md5(trim((!isset($_GET['card']) ? $_POST['password'] : $_SESSION['card_password']))).$r['encrypt']);
			
			if($r['password'] != $password) {
				$ip = ip();
				if($rtime && $rtime['times'] < $maxloginfailedtimes) {
					$times = $maxloginfailedtimes-intval($rtime['times']);
					$this->times_db->update(array('ip'=>$ip,'isadmin'=>1,'times'=>'+=1'),array('username'=>$username));
				} else {
					$this->times_db->delete(array('username'=>$username,'isadmin'=>1));
					$this->times_db->insert(array('username'=>$username,'ip'=>$ip,'isadmin'=>1,'logintime'=>SYS_TIME,'times'=>1));
					$times = $maxloginfailedtimes;
				}
				showmessage(L('password_error',array('times'=>$times)),'?m=admin&c=index&a=login',3000);
			}
			$this->times_db->delete(array('username'=>$username));
			
			//查看是否使用口令卡
			if (!isset($_GET['card']) && $r['card'] && pc_base::load_config('system', 'safe_card') == 1) {
				$_SESSION['card_username'] = $username;
				$_SESSION['card_password'] = $_POST['password'];
				header("location:?m=admin&c=index&a=public_card");
				exit;
			} elseif (isset($_GET['card']) && pc_base::load_config('system', 'safe_card') == 1 && $r['card']) {//对口令卡进行验证
				isset($_SESSION['card_username']) ? $_SESSION['card_username'] = '' : '';
				isset($_SESSION['card_password']) ? $_SESSION['card_password'] = '' : '';
				isset($_SESSION['card_password']) ? $_SESSION['card_verif'] = '' : '';
			}
			
			$this->db->update(array('lastloginip'=>ip(),'lastlogintime'=>SYS_TIME),array('userid'=>$r['userid']));
			$_SESSION['userid'] = $r['userid'];
			$_SESSION['roleid'] = $r['roleid'];
			$_SESSION['pc_hash'] = random(6,'abcdefghigklmnopqrstuvwxwyABCDEFGHIGKLMNOPQRSTUVWXWY0123456789');
			$_SESSION['lock_screen'] = 0;
			$default_siteid = self::return_siteid();
			$cookie_time = SYS_TIME+86400*30;
			if(!$r['lang']) $r['lang'] = 'zh-cn';
			param::set_cookie('admin_username',$username,$cookie_time);
			param::set_cookie('siteid', $default_siteid,$cookie_time);
			param::set_cookie('userid', $r['userid'],$cookie_time);
			param::set_cookie('admin_email', $r['email'],$cookie_time);
			param::set_cookie('sys_lang', $r['lang'],$cookie_time);
			showmessage(L('login_success'),'?m=admin&c=index');
			//同步登陆vms,先检查是否启用了vms
			$video_setting = getcache('video', 'video');
			if ($video_setting['sn'] && $video_setting['skey']) {
				$vmsapi = pc_base::load_app_class('ku6api', 'video');
				$vmsapi->member_login_vms();
			}
		} else {
			$versionData = $this->version_update->get_one('','*','id desc');
			$str='<p style="text-align: center;">当前版本号：<strong>'.$versionData['version'].'<strong></p>';
			/*if(!$versionData){
				$str.='<p style="text-align: center;font-size: 22px;">连接数据库出错！</p>';
			}*/
			pc_base::load_sys_class('form', '', 0);
			include $this->admin_tpl('login');
		}
	}
	
	public function public_card() {
		$username = $_SESSION['card_username'] ? $_SESSION['card_username'] :  showmessage(L('nameerror'),HTTP_REFERER);
		$r = $this->db->get_one(array('username'=>$username));
		if(!$r) showmessage(L('user_not_exist'),'?m=admin&c=index&a=login');
		if (isset($_GET['dosubmit'])) {
			pc_base::load_app_class('card', 'admin', 0);
			$result = card::verification($r['card'], $_POST['code'], $_POST['rand']);
			$_SESSION['card_verif'] = 1;
			header("location:?m=admin&c=index&a=login&dosubmit=1&card=1");
			exit;
		}
		pc_base::load_app_class('card', 'admin', 0);
		$rand = card::authe_rand($r['card']);
		include $this->admin_tpl('login_card');
	}
	
	public function public_logout() {
		$_SESSION['userid'] = 0;
		$_SESSION['roleid'] = 0;
		param::set_cookie('admin_username','');
		param::set_cookie('userid',0);
		
		//退出phpsso
		$phpsso_api_url = pc_base::load_config('system', 'phpsso_api_url');
		$phpsso_logout = '<script type="text/javascript" src="'.$phpsso_api_url.'/api.php?op=logout" reload="1"></script>';
		
		showmessage(L('logout_success').$phpsso_logout,'?m=admin&c=index&a=login');
	}
	
	//左侧菜单
	public function public_menu_left() {
		$menuid = intval($_GET['menuid']);
		$datas = admin::admin_menu($menuid);
		if (isset($_GET['parentid']) && $parentid = intval($_GET['parentid']) ? intval($_GET['parentid']) : 10) {
			foreach($datas as $_value) {
	        	if($parentid==$_value['id']) {
	        		echo '<li id="_M'.$_value['id'].'" class="on top_menu"><a href="javascript:_M('.$_value['id'].',\'?m='.$_value['m'].'&c='.$_value['c'].'&a='.$_value['a'].'\')" hidefocus="true" style="outline:none;">'.L($_value['name']).'</a></li>';
	        		
	        	} else {
	        		echo '<li id="_M'.$_value['id'].'" class="top_menu"><a href="javascript:_M('.$_value['id'].',\'?m='.$_value['m'].'&c='.$_value['c'].'&a='.$_value['a'].'\')"  hidefocus="true" style="outline:none;">'.L($_value['name']).'</a></li>';
	        	}      	
	        }
		} else {
			include $this->admin_tpl('left');
		}
		
	}
	//当前位置
	public function public_current_pos() {
		echo admin::current_pos($_GET['menuid']);
		exit;
	}
	
	/**
	 * 设置站点ID COOKIE
	 */
	public function public_set_siteid() {
		$siteid = isset($_GET['siteid']) && intval($_GET['siteid']) ? intval($_GET['siteid']) : exit('0'); 
		param::set_cookie('siteid', $siteid);
		exit('1');
	}
	
	public function public_ajax_add_panel() {
		$menuid = isset($_POST['menuid']) ? $_POST['menuid'] : exit('0');
		$menuarr = $this->menu_db->get_one(array('id'=>$menuid));
		$url = '?m='.$menuarr['m'].'&c='.$menuarr['c'].'&a='.$menuarr['a'].'&'.$menuarr['data'];
		$data = array('menuid'=>$menuid, 'userid'=>$_SESSION['userid'], 'name'=>$menuarr['name'], 'url'=>$url, 'datetime'=>SYS_TIME);
		$this->panel_db->insert($data, '', 1);
		$panelarr = $this->panel_db->listinfo(array('userid'=>$_SESSION['userid']), "datetime");
		foreach($panelarr as $v) {
			echo "<span><a onclick='paneladdclass(this);' target='right' href='".$v['url'].'&menuid='.$v['menuid']."&pc_hash=".$_SESSION['pc_hash']."'>".L($v['name'])."</a>  <a class='panel-delete' href='javascript:delete_panel(".$v['menuid'].");'></a></span>";
		}
		exit;
	}
	
	public function public_ajax_delete_panel() {
		$menuid = isset($_POST['menuid']) ? $_POST['menuid'] : exit('0');
		$this->panel_db->delete(array('menuid'=>$menuid, 'userid'=>$_SESSION['userid']));

		$panelarr = $this->panel_db->listinfo(array('userid'=>$_SESSION['userid']), "datetime");
		foreach($panelarr as $v) {
			echo "<span><a onclick='paneladdclass(this);' target='right' href='".$v['url']."&pc_hash=".$_SESSION['pc_hash']."'>".L($v['name'])."</a> <a class='panel-delete' href='javascript:delete_panel(".$v['menuid'].");'></a></span>";
		}
		exit;
	}

	/**
	 * 维持 session 登陆状态
	 */
	public function public_session_life() {
		$userid = $_SESSION['userid'];
		return true;
	}
	/**
	 * 锁屏
	 */
	public function public_lock_screen() {
		$_SESSION['lock_screen'] = 1;
	}
	public function public_login_screenlock() {
		if(empty($_GET['lock_password'])) showmessage(L('password_can_not_be_empty'));
		//密码错误剩余重试次数
		$this->times_db = pc_base::load_model('times_model');
		$username = param::get_cookie('admin_username');
		$maxloginfailedtimes = getcache('common','commons');
		$maxloginfailedtimes = (int)$maxloginfailedtimes['maxloginfailedtimes'];
		
		$rtime = $this->times_db->get_one(array('username'=>$username,'isadmin'=>1));
		if($rtime['times'] > $maxloginfailedtimes-1) {
			$minute = 60-floor((SYS_TIME-$rtime['logintime'])/60);
			exit('3');
		}
		//查询帐号
		$r = $this->db->get_one(array('userid'=>$_SESSION['userid']));
		$password = md5(md5($_GET['lock_password']).$r['encrypt']);
		if($r['password'] != $password) {
			$ip = ip();
			if($rtime && $rtime['times']<$maxloginfailedtimes) {
				$times = $maxloginfailedtimes-intval($rtime['times']);
				$this->times_db->update(array('ip'=>$ip,'isadmin'=>1,'times'=>'+=1'),array('username'=>$username));
			} else {
				$this->times_db->insert(array('username'=>$username,'ip'=>$ip,'isadmin'=>1,'logintime'=>SYS_TIME,'times'=>1));
				$times = $maxloginfailedtimes;
			}
			exit('2|'.$times);//密码错误
		}
		$this->times_db->delete(array('username'=>$username));
		$_SESSION['lock_screen'] = 0;
		exit('1');
	}
	
	//后台站点地图
	public function public_map() {
		 $array = admin::admin_menu(0);
		 $menu = array();
		 foreach ($array as $k=>$v) {
		 	$menu[$v['id']] = $v;
		 	$menu[$v['id']]['childmenus'] = admin::admin_menu($v['id']);
		 }
		 $show_header = true;
		 include $this->admin_tpl('map');
	}
	
	/**
	 * 
	 * 读取盛大接扣获取appid和secretkey
	 */
	public function public_snda_status() {
		//引入盛大接口
		if(!strstr(pc_base::load_config('snda','snda_status'), '|')) {
			$this->site_db = pc_base::load_model('site_model');
			$uuid_arr = $this->site_db->get_one(array('siteid'=>1), 'uuid');
			$uuid = $uuid_arr['uuid'];
			$snda_check_url = "http://open.sdo.com/phpcms?cmsid=".$uuid."&sitedomain=".$_SERVER['SERVER_NAME'];

			$snda_res_json = @file_get_contents($snda_check_url);
			$snda_res = json_decode($snda_res_json, 1);

			if(!isset($snda_res[err]) && !empty($snda_res['appid'])) {
				$appid = $snda_res['appid'];
				$secretkey = $snda_res['secretkey'];
				set_config(array('snda_status'=>$appid.'|'.$secretkey), 'snda');
			}
		}
	}

	/**
	 * @设置网站模式 设置了模式后，后台仅出现在此模式中的菜单
	 */
	public function public_set_model() {
		$model = $_GET['site_model'];
		if (!$model) {
			param::set_cookie('site_model','');
		} else {
			$models = pc_base::load_config('model_config');
			if (in_array($model, array_keys($models))) {
				param::set_cookie('site_model', $model);
			} else {
				param::set_cookie('site_model','');
			}
		}
		$menudb = pc_base::load_model('menu_model');
		$where = array('parentid'=>0,'display'=>1);
		if ($model) {
			$where[$model] = 1;
 		}
		$result =$menudb->select($where,'id',1000,'listorder ASC');
		$menuids = array();
		if (is_array($result)) {
			foreach ($result as $r) {
				$menuids[] = $r['id'];
			}
		}
		exit(json_encode($menuids));
	}

	//后台登录后显示的主页面
	public function public_main() {
		pc_base::load_app_func('global');
		pc_base::load_app_func('admin');
		define('PC_VERSION', pc_base::load_config('version','pc_version'));
		define('PC_RELEASE', pc_base::load_config('version','pc_release'));	
	
		$admin_username = param::get_cookie('admin_username');
		$roles = getcache('role','commons');
		$userid = $_SESSION['userid'];
		$rolename = $roles[$_SESSION['roleid']];
		$r = $this->db->get_one(array('userid'=>$userid));
		$logintime = $r['lastlogintime'];
		$loginip = $r['lastloginip'];
		$sysinfo = get_sysinfo();
		$sysinfo['mysqlv'] = $this->db->version();
		$show_header = $show_pc_hash = 1;
		/*检测框架目录可写性*/
		$pc_writeable = is_writable(PC_PATH.'base.php');
		$common_cache = getcache('common','commons');
		$logsize_warning = errorlog_size() > $common_cache['errorlog_size'] ? '1' : '0';
		$adminpanel = $this->panel_db->select(array('userid'=>$userid), '*',20 , 'datetime');

 		$versionData = $this->version_update->get_one('','*','id desc');
 		$version=$versionData['version'];
 		if($version){
	 		$reslison = $this->version_update->select('','versiontxt');//前台显示到当前版本日志里
	 		$i=1; 
	 		foreach ($reslison as $key => $v) {
				$reslisonstr .= '<p>'.$i.'、'.$v['versiontxt'].'</p>';
				$i++;
			}
 		}
 		// var_dump($reslison);exit;
		$data['version'] = $version;//客户端当前版本
		$data['url'] = $_SERVER['SERVER_NAME'];//推送客户端站点URL到远程版本服务器上
		$urlData = $this->domain_model->get_one(array('id'=>1),'url,tplcode,tplname');
		$data['tplcode'] =$urlData['tplcode'];//模板识别码，因为每套模板不一样导致
		$data['tplname'] =$urlData['tplname'];//这套模板的名称
		$url = 'http://'.$urlData['url'].'/index.php?m=content&c=index&a=check_version';
	    // 返回：array(3) { ["up_date"]=> string(10) "2019-02-26" ["version"]=> string(4) "1.52" ["versiontxt"]=> string(99) "1、修复由于HP5.3和PHP5.6版本的data=[]数组命名不兼容的问题。2、其他问题" }

		$postdata = http_build_query($data);
		$options = array(
		    'http' => array(
				'method' => 'POST',
				'header' => 'Content-type:application/x-www-form-urlencoded',
				'content' => $postdata,
				'timeout' => 20,
		    )
		);
		$context = stream_context_create($options);
		$res_update = file_get_contents($url, false, $context);

		$update =json_decode($res_update,true);
		//前台 以if($update['version']){}判断是否显示“更新”按钮
		include $this->admin_tpl('main');
	}

	//此客户端，前台点击“版本更新”按钮触发此方法
	public function version_update(){
		$res_client = $this->version_update->get_one('','*','id desc');
		if(!$res_client) $res_client['version'] = '';
		$urlData = $this->domain_model->get_one(array('id'=>1),'url,tplcode');
		$data['version'] = $res_client['version'];
		$data['tplcode'] =$urlData['tplcode'];
		$url = 'http://'.$urlData['url'].'/index.php?m=content&c=index&a=check_version_update';//版本服务器接口地址
		$postdata = http_build_query($data);//发送客户端版本号
		$options = array(
		    'http' => array(
				'method' => 'POST',
				'header' => 'Content-type:application/x-www-form-urlencoded',
				'content' => $postdata,
				'timeout' => 20
		    )
		);
		$context = stream_context_create($options);
		$update = file_get_contents($url, false, $context);
		$res_update = json_decode($update,true);
		// var_dump($res_update);exit;
		if($res_update){
			if(isset($res_update['message'])){
				showmessage($res_update['message']); 
			}else{
				$errurl=array();
				foreach($res_update['file'] as $key=>$value){
			  		/*
			  		自主创建目录/文件等暂时不开放
			  		$keyData = explode('/',$key);
				    if(count($keyData)>1){
				    	$dir_name = str_replace(end($keyData),'',$key);
				    	if(!is_dir($dir_name)) mkdir($dir_name,755);
				    }*/
				    if(file_exists($key)){
				  		file_put_contents($key,$value);
				  		echo '更新 '.$key.'成功<br />';
				    }else{
				  		$errurl[]=$key;
				    	echo '失败：文件路径为<span style="color:red;">'.$key.'</span>，不存在！<br />';
				    }
			  	}
			  	foreach($res_update['data'] as $value){
			  		if(!in_array($value['url'], $errurl)){
			  			unset($value['serverurl']);
				  		$this->version_update->insert($value);
			  		}
			  	}
		    }		
			// showmessage('已更新到最新版本'); 	
		}	
	}

}
?>