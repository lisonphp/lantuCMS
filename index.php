<?php
/**
 *  index.php lantuCMS 入口
 *
 * @copyright			(C) 2018-2020 lantuCMS
 * @lastmodify			2019-02-25
 * @author              lison
 */
 //lantuCMS根目录
define('PHPCMS_PATH', dirname(__FILE__).DIRECTORY_SEPARATOR);

include PHPCMS_PATH.'/phpcms/base.php';

pc_base::creat_app();

?>