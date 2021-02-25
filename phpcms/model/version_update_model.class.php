<?php
defined('IN_PHPCMS') or exit('No permission resources.');
pc_base::load_sys_class('model', '', 0);
class version_update_model extends model {
	public function __construct() {
		$this->db_config = pc_base::load_config('database');
		$this->db_setting = 'default';
		$this->table_name = 'version_update';
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
  			`version` float NOT NULL COMMENT '版本号',
  			`url` varchar(255) DEFAULT NULL COMMENT '更新路径',
  			PRIMARY KEY (`id`)
		) ENGINE=MyISAM DEFAULT CHARSET=".$charset." ;";
		// $sql = "CREATE TABLE IF NOT EXISTS `".$this->table_name."` (
  // 		`id` int(10) unsigned NOT NULL auto_increment,
  // 		`pid` smallint(5) unsigned NOT NULL default '0',
  // 		`siteid` smallint(5) unsigned NOT NULL default '0',
  // 		`spaceid` smallint(5) unsigned NOT NULL default '0',
  // 		`username` char(20) NOT NULL,
  // 		`area` char(40) NOT NULL,
  // 		`ip` char(15) NOT NULL,
  // 		`referer` char(120) NOT NULL,
  // 		`clicktime` int(10) unsigned NOT NULL default '0',
  // 		`type` tinyint(1) unsigned NOT NULL default '1',
  // 		PRIMARY KEY  (`id`),
  // 		KEY `pid` (`pid`,`type`,`ip`)
		// ) ENGINE=MyISAM DEFAULT CHARSET=".$charset." ;";
		$this->db->query($sql);
	}

}
?>