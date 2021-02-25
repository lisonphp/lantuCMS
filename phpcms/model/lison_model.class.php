<?php
defined('IN_PHPCMS') or exit('No permission resources.');
if(!defined('CACHE_MODEL_PATH')) define('CACHE_MODEL_PATH',CACHE_PATH.'caches_model'.DIRECTORY_SEPARATOR.'caches_data'.DIRECTORY_SEPARATOR);
/**
 * 内容模型数据库操作类
 */
pc_base::load_sys_class('model', '', 0);
class lison_model extends model {
	public $table_name = '';
	public $category = '';
	public function __construct() {
		$this->db_config = pc_base::load_config('database');
		$this->db_setting = 'default';
		parent::__construct();
	}
	public function lison_tb($table_name) {
		$this->table_name = $this->db_tablepre.$table_name;
		$this->model_tablename = $table_name;
	}
	
}
?>