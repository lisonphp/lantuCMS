<?php
defined('IN_PHPCMS') or exit('No permission resources.');

//定义在后台
define('IN_ADMIN',true);
class admin_op {
	public function __construct() {
		$this->db = pc_base::load_model('admin_model');
	}
	/*
	 * 修改密码
	 */
	public function edit_password($userid, $password,$excel_out_password=''){
		$userid = intval($userid);
		if($userid < 1) return false;
		if(!is_password($password))
		{
			showmessage(L('pwd_incorrect'));
			return false;
		}
		$passwordinfo = password($password);
		$passwordinfo['excel_out_password']=$excel_out_password;//修改excel密码
		// print_r($passwordinfo);exit;
		return $this->db->update($passwordinfo,array('userid'=>$userid));
	}
	/*
	 * 修改excel密码
	 */
	public function edit_password_excel($userid,$excel_out_password=''){
		$userid = intval($userid);
		if($userid < 1) return false;
		$passwordinfo['excel_out_password']=$excel_out_password;
		return $this->db->update($passwordinfo,array('userid'=>$userid));
	}
	/*
	 * 检查用户名重名
	 */	
	public function checkname($username) {
		$username =  trim($username);
		if ($this->db->get_one(array('username'=>$username),'userid')){
			return false;
		}
		return true;
	}	
}
?>