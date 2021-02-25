<?php
defined('IN_PHPCMS') or exit('No permission resources.');
pc_base::load_sys_class('model', '', 0);
class domain_model extends model {
	public function __construct() {
		$this->db_config = pc_base::load_config('database');
		$this->db_setting = 'default';
		$this->table_name = 'domain';
		parent::__construct();
		if(!$this->db->table_exists($this->table_name)) {
			$this->create_table();
		}
	}

	
	/**
	 * 按月份创建表
	 */
	private function create_table() {
		$data_info = pc_base::load_config('database', $this->db_setting);
		$charset = $data_info['charset'];
		$sql = "CREATE TABLE IF NOT EXISTS `".$this->table_name."` (
  			`id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  			`url` varchar(255) DEFAULT NULL COMMENT '发送请求过来的站点域名',
  			`status` tinyint(1) unsigned DEFAULT 0 COMMENT '0别人请求过来的,1发送过去的请求',
  			PRIMARY KEY (`id`)
		) ENGINE=MyISAM DEFAULT CHARSET=".$charset." ;";
		$this->db->query($sql);
		$insertSql = "INSERT INTO `".$this->table_name."` VALUES ('1', 'versioncms.blueto.net','1');";
		$this->db->query($insertSql);
	}

}
?>