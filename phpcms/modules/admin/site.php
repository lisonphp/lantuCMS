<?php
defined('IN_PHPCMS') or exit('No permission resources.');
pc_base::load_app_class('admin', 'admin', 0);
class site extends admin {
	private $db;
	public function __construct() {
		$this->db = pc_base::load_model('site_model');
		parent::__construct();
	}
	
	public function init() {
		$total = $this->db->count();
		$page = isset($_GET['page']) && intval($_GET['page']) ? intval($_GET['page']) : 1;
		$pagesize = 20;
		$offset = ($page - 1) * $pagesize;
		$list = $this->db->select('', '*', $offset.','.$pagesize);
		$olddomain_status=$list[0]['olddomain_status'];//未更新域名,0为未更新，1为已更新
		$cache_status=$list[0]['cache_status'];//是否更新缓存,0为未更新，1为已更新
		$pages = pages($total, $page, $pagesize);
		$show_dialog = true;
		$big_menu = array('javascript:window.top.art.dialog({id:\'add\',iframe:\'?m=admin&c=site&a=add\', title:\''.L('add_site').'\', width:\'700\', height:\'500\', lock:true}, function(){var d = window.top.art.dialog({id:\'add\'}).data.iframe;var form = d.document.getElementById(\'dosubmit\');form.click();return false;}, function(){window.top.art.dialog({id:\'add\'}).close()});void(0);', L('add_site'));
		include $this->admin_tpl('site_list');
	}
	
	public function add() {
		exit('lison-暂时不支持添加网站');
		header("Cache-control: private"); 
		if (isset($_GET['show_header'])) $show_header = 1;
		if (isset($_POST['dosubmit'])) {
			$name = isset($_POST['name']) && trim($_POST['name']) ? trim($_POST['name']) : showmessage(L('site_name').L('empty'));
			$dirname = isset($_POST['dirname']) && trim($_POST['dirname']) ? strtolower(trim($_POST['dirname'])) : showmessage(L('site_dirname').L('empty'));
			$domain = isset($_POST['domain']) && trim($_POST['domain']) ? trim($_POST['domain']) : '';
			$site_title = isset($_POST['site_title']) && trim($_POST['site_title']) ? trim($_POST['site_title']) : '';
			$keywords = isset($_POST['keywords']) && trim($_POST['keywords']) ? trim($_POST['keywords']) : '';
			$description = isset($_POST['description']) && trim($_POST['description']) ? trim($_POST['description']) : '';
			$release_point = isset($_POST['release_point']) ? $_POST['release_point'] : '';
			$template = isset($_POST['template']) && !empty($_POST['template']) ? $_POST['template'] : showmessage(L('please_select_a_style'));
			$default_style = isset($_POST['default_style']) && !empty($_POST['default_style']) ? $_POST['default_style'] : showmessage(L('please_choose_the_default_style'));			   
			if ($this->db->get_one(array('name'=>$name), 'siteid')) {
				showmessage(L('site_name').L('exists'));
			} 
			if (!preg_match('/^\\w+$/i', $dirname)) {
				showmessage(L('site_dirname').L('site_dirname_err_msg'));
			}
			if ($this->db->get_one(array('dirname'=>$dirname), 'siteid')) {
				showmessage(L('site_dirname').L('exists'));
			}
			if (!empty($domain) && !preg_match('/http:\/\/(.+)\/$/i', $domain)) {
				showmessage(L('site_domain').L('site_domain_ex2'));
			}
			if (!empty($domain) && $this->db->get_one(array('domain'=>$domain), 'siteid')) {
				showmessage(L('site_domain').L('exists'));
			}
			if (!empty($release_point) && is_array($release_point)) {
				if (count($release_point) > 4) {
					showmessage(L('release_point_configuration').L('most_choose_four'));
				}
				$s = '';
				foreach ($release_point as $key=>$val) {
					if($val) $s.= $s ? ",$val" : $val;
				}
				$release_point = $s;
				unset($s);
			} else {
				$release_point = '';
			}
			if (!empty($template) && is_array($template)) {
				$template = implode(',', $template);
			} else {
				$template = '';
			}
			$_POST['setting']['watermark_img'] = IMG_PATH.'water/'.$_POST['setting']['watermark_img'];
			$setting = trim(array2string($_POST['setting']));
			if ($this->db->insert(array('name'=>$name,'dirname'=>$dirname, 'domain'=>$domain, 'site_title'=>$site_title, 'keywords'=>$keywords, 'description'=>$description, 'release_point'=>$release_point, 'template'=>$template,'setting'=>$setting, 'default_style'=>$default_style))) {
				$class_site = pc_base::load_app_class('sites');
				$class_site->set_cache();
				showmessage(L('operation_success'), '?m=admin&c=site&a=init', '', 'add');
			} else {
				showmessage(L('operation_failure'));
			}
		} else {
			$release_point_db = pc_base::load_model('release_point_model');
			$release_point_list = $release_point_db->select('', 'id, name');
			$show_validator = $show_scroll = $show_header = true;
			$template_list = template_list();
			include $this->admin_tpl('site_add');
		}
	}
	
	public function del() {
		exit('lison-暂时不支持删除网站，只可修改哈');
		$siteid = isset($_GET['siteid']) && intval($_GET['siteid']) ? intval($_GET['siteid']) : showmessage(L('illegal_parameters'), HTTP_REFERER);
		if($siteid==1) showmessage(L('operation_failure'), HTTP_REFERER);
		if ($this->db->get_one(array('siteid'=>$siteid))) {
			if ($this->db->delete(array('siteid'=>$siteid))) {
				$class_site = pc_base::load_app_class('sites');
				$class_site->set_cache();
				showmessage(L('operation_success'), HTTP_REFERER);
			} else {
				showmessage(L('operation_failure'), HTTP_REFERER);
			}
		} else {
			showmessage(L('notfound'), HTTP_REFERER);
		}
	}
	
	public function edit() {
		$siteid = isset($_GET['siteid']) && intval($_GET['siteid']) ? intval($_GET['siteid']) : showmessage(L('illegal_parameters'), HTTP_REFERER);
		if ($data = $this->db->get_one(array('siteid'=>$siteid))) {
			if (isset($_POST['dosubmit'])) {
				$name = isset($_POST['name']) && trim($_POST['name']) ? trim($_POST['name']) : showmessage(L('site_name').L('empty'));
				$dirname = isset($_POST['dirname']) && trim($_POST['dirname']) ? strtolower(trim($_POST['dirname'])) : ($siteid == 1 ? '' :showmessage(L('site_dirname').L('empty')));
				$domain = isset($_POST['domain']) && trim($_POST['domain']) ? trim($_POST['domain']) : '';
				$site_title = isset($_POST['site_title']) && trim($_POST['site_title']) ? trim($_POST['site_title']) : '';
				$keywords = isset($_POST['keywords']) && trim($_POST['keywords']) ? trim($_POST['keywords']) : '';
				$description = isset($_POST['description']) && trim($_POST['description']) ? trim($_POST['description']) : '';
				$release_point = isset($_POST['release_point']) ? $_POST['release_point'] : '';
				$template = isset($_POST['template']) && !empty($_POST['template']) ? $_POST['template'] : showmessage(L('please_select_a_style'));
				$default_style = isset($_POST['default_style']) && !empty($_POST['default_style']) ? $_POST['default_style'] : showmessage(L('please_choose_the_default_style'));	
				if ($data['name'] != $name && $this->db->get_one(array('name'=>$name), 'siteid')) {
					showmessage(L('site_name').L('exists'));
				}
				if ($siteid != 1) {
					if (!preg_match('/^\\w+$/i', $dirname)) {
						showmessage(L('site_dirname').L('site_dirname_err_msg'));
					}
					if ($data['dirname'] != $dirname && $this->db->get_one(array('dirname'=>$dirname), 'siteid')) {
						showmessage(L('site_dirname').L('exists'));
					}
				} 
				
				if (!empty($domain) && !preg_match('/http:\/\/(.+)\/$/i', $domain)) {
					showmessage(L('site_domain').L('site_domain_ex2'));
				}
				if (!empty($domain) && $data['domain'] != $domain && $this->db->get_one(array('domain'=>$domain), 'siteid')) {
					showmessage(L('site_domain').L('exists'));
				}
				if (!empty($release_point) && is_array($release_point)) {
					if (count($release_point) > 4) {
						showmessage(L('release_point_configuration').L('most_choose_four'));
					}
					$s = '';
					foreach ($release_point as $key=>$val) {
						if($val) $s.= $s ? ",$val" : $val;
					}
					$release_point = $s;
					unset($s);
				} else {
					$release_point = '';
				}
				if (!empty($template) && is_array($template)) {
					$template = implode(',', $template);
				} else {
					$template = '';
				}
				//lison start
				$default_style_radio=$_POST['default_style_radio'];
				$this->category_db = pc_base::load_model('category_model');
				$res_sites=$this->db->get_one(array('siteid'=>1));
				if($default_style_radio != $res_sites['default_style']){
					$category_res = $this->category_db->select(array('siteid'=>1, 'module'=>'content'),'*',10000,'listorder ASC');
					foreach($category_res as $r) {
						$setting = string2array($r['setting']);
						$setting['template_list']=$default_style_radio;
						$push_setting=array2string($setting);
						// var_dump($push_setting);exit;
						$this->category_db->update(array('setting'=>$push_setting),array('catid'=>$r['catid']));
					}

				}
				//lison end
				$_POST['setting']['watermark_img'] = 'statics/images/water/'.$_POST['setting']['watermark_img'];
				$setting = trim(array2string($_POST['setting']));
				$sql = array('name'=>$name,'dirname'=>$dirname, 'domain'=>$domain, 'site_title'=>$site_title, 'keywords'=>$keywords, 'description'=>$description, 'release_point'=>$release_point, 'template'=>$template, 'setting'=>$setting, 'default_style'=>$default_style,'olddomain_status'=>0,'cache_status'=>0);
				if ($siteid == 1) unset($sql['dirname']);
				if ($this->db->update($sql, array('siteid'=>$siteid))) {
				// if (trim($_POST['domain']) !='') {
					$class_site = pc_base::load_app_class('sites');
					$class_site->set_cache();
					if($res_sites['domain'] !=trim($_POST['domain'])){//域名有变化
						$new_d=get_domain_url2(trim($_POST['domain']));
						$old_d=get_domain_url2($res_sites['domain']);
						// var_dump($new_d);exit;
						$route=file_get_contents(CACHE_PATH.'configs/route.php');
						$str=str_replace($old_d['wap_url'], $new_d['wap_url'], $route);
						$res_is=file_put_contents(CACHE_PATH.'configs/route.php',$str);
						$_SESSION['updatedomian']=1;
$str_htaccess_url=PHPCMS_PATH.'.htaccess';
$str_htaccess='RewriteEngine on
RewriteRule ^statics - [L,NC]
RewriteRule ^uploadfile - [L,NC]
RewriteRule ^wap - [L,NC]
#RewriteCond %{HTTP_HOST} ^'.$new_d['wap_url'].'$ [NC]
#DirectoryIndex index.php index.html
RewriteCond %{HTTP_HOST} ^'.$new_d['wap_url'].'$ [NC]
RewriteRule ^([A-Za-z0-9_]+)/([A-Za-z0-9_]+).html$ index.php?m=wap&c=index&a=index&dir=$1&id=$2
RewriteCond %{HTTP_HOST} ^'.$new_d['wap_url'].'$ [NC]
RewriteRule ^([A-Za-z0-9_]+)/_([A-Za-z0-9_]+).html index.php?m=wap&c=index&a=index&dir=$1&page=$2
RewriteCond %{HTTP_HOST} ^'.$new_d['wap_url'].'$ [NC]
RewriteRule ^([A-Za-z0-9_]+)/ index.php?m=wap&c=index&a=index&dir=$1
RewriteCond %{HTTP_HOST} ^'.$new_d['nohttp_pc_url'].' [NC]
RewriteRule ^(.*)$ http://www.'.$new_d['nohttp_pc_url'].'/$1 [L,R=301]
ErrorDocument 404 /404.html';
$str_htaccess_is=file_put_contents($str_htaccess_url,$str_htaccess);

$str_conf_url=PHPCMS_PATH.'LantuCMS.conf';
$str_conf='location / {
	try_files $uri $uri/ /index.php;
if ($http_host ~* "^'.$new_d['wap_url'].'$"){
	set $rule_0 1$rule_0;
}
if ($rule_0 = "1"){
	rewrite ^/([A-Za-z0-9_]+)/([A-Za-z0-9_]+).html$ /index.php?m=wap&c=index&a=index&dir=$1&id=$2;
}
if ($http_host ~* "^'.$new_d['wap_url'].'$"){
	set $rule_1 1$rule_1;
}
if ($rule_1 = "1"){
	rewrite ^/([A-Za-z0-9_]+)/_([A-Za-z0-9_]+).html /index.php?m=wap&c=index&a=index&dir=$1&page=$2;
}
if ($http_host ~* "^'.$new_d['wap_url'].'$"){
	set $rule_2 1$rule_2;
}
if ($rule_2 = "1"){
	rewrite ^/([A-Za-z0-9_]+)/ /index.php?m=wap&c=index&a=index&dir=$1;
}
if ($http_host ~ "^'.$new_d['nohttp_pc_url'].'$"){
	rewrite ^/(.*)$ http://www.'.$new_d['nohttp_pc_url'].'/$1 permanent;
}
}';
$str_conf_is=file_put_contents($str_conf_url,$str_conf);
//默认添加"statics/pc/css"下的样式文件至后台
$all_css_pc = glob(PHPCMS_PATH.'statics/pc/css/*.css');
$pcss_str ='';
foreach($all_css_pc as $filename){
	$pcss_str .= '@import url("/statics/pc/css/'.basename($filename).'");'."\n";
}
$all_css_pc_save = PHPCMS_PATH.'statics/js/ueditor1433/themes/iframe.css';
$str_css_pc_save=file_put_contents($all_css_pc_save,$pcss_str);
					}
					showmessage('成功', '','','edit');
				} else {
					showmessage(L('operation_failure'));
				}
			} else {
				$show_validator = true;
				$show_header = true;
				$show_scroll = true;
				$template_list = template_list();
				$setting = string2array($data['setting']);
				$setting['watermark_img'] = str_replace('statics/images/water/','',$setting['watermark_img']);
				$release_point_db = pc_base::load_model('release_point_model');
				$release_point_list = $release_point_db->select('', 'id, name');
				include $this->admin_tpl('site_edit');
			}
		} else {
			showmessage(L('notfound'), HTTP_REFERER);
		}
	}
	
	public function public_name() {
		$name = isset($_GET['name']) && trim($_GET['name']) ? (pc_base::load_config('system', 'charset') == 'gbk' ? iconv('utf-8', 'gbk', trim($_GET['name'])) : trim($_GET['name'])) : exit('0');
		$siteid = isset($_GET['siteid']) && intval($_GET['siteid']) ? intval($_GET['siteid']) : '';
 		$data = array();
		if ($siteid) {
			
			$data = $this->db->get_one(array('siteid'=>$siteid), 'name');
			if (!empty($data) && $data['name'] == $name) {
				exit('1');
			}
		}
		if ($this->db->get_one(array('name'=>$name), 'siteid')) {
			exit('0');
		} else {
			exit('1');
		}
	}
	
	public function public_dirname() {
		$dirname = isset($_GET['dirname']) && trim($_GET['dirname']) ? (pc_base::load_config('system', 'charset') == 'gbk' ? iconv('utf-8', 'gbk', trim($_GET['dirname'])) : trim($_GET['dirname'])) : exit('0');
		$siteid = isset($_GET['siteid']) && intval($_GET['siteid']) ? intval($_GET['siteid']) : '';
		$data = array();
		if ($siteid) {
			$data = $this->db->get_one(array('siteid'=>$siteid), 'dirname');
			if (!empty($data) && $data['dirname'] == $dirname) {
				exit('1');
			}
		}
		if ($this->db->get_one(array('dirname'=>$dirname), 'siteid')) {
			exit('0');
		} else {
			exit('1');
		}
	}

	private function check_gd() {
		if(!function_exists('imagepng') && !function_exists('imagejpeg') && !function_exists('imagegif')) {
			$gd = L('gd_unsupport');
		} else {
			$gd = L('gd_support');
		}
		return $gd;
	}
}