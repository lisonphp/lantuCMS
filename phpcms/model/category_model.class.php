<?php
defined('IN_PHPCMS') or exit('No permission resources.');
pc_base::load_sys_class('model', '', 0);
class category_model extends model {
	public $table_name = '';
	public function __construct() {
		$this->db_config = pc_base::load_config('database');
		$this->db_setting = 'default';
		$this->table_name = 'category';
		parent::__construct();
		$this->update_field();
	}

	//更新字段功能
	private function update_field(){
	
		if(!$this->db->field_exists($this->table_name,'subtitle')){
			$sql = "ALTER TABLE `".$this->table_name."` add column `subtitle` mediumtext";
			$this->db->query($sql);
		}

		if(!$this->db->field_exists($this->table_name,'descriptions')){
			$sql = "ALTER TABLE `".$this->table_name."` add column `descriptions` mediumtext";
			$this->db->query($sql);
		}		

	}
}
?>