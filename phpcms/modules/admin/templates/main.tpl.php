<?php
defined('IN_ADMIN') or exit('No permission resources.');
include PC_PATH.'modules'.DIRECTORY_SEPARATOR.'admin'.DIRECTORY_SEPARATOR.'templates'.DIRECTORY_SEPARATOR.'header.tpl.php';
?>
<div id="main_frameid" class="pad-10 display" style="_margin-right:-12px;_width:98.9%;">
<script type="text/javascript">
$(function(){if ($.browser.msie && parseInt($.browser.version) < 7) $('#browserVersionAlert').show();}); 
</script>
<div class="explain-col mb10" style="display:none" id="browserVersionAlert">
<?php echo L('ie8_tip')?></div>
<div class="col-2 lf mr10" style="width:48%">
	<h6><?php echo L('personal_information')?></h6>
	<div class="content">
	<?php echo L('main_hello')?><?php echo $admin_username?><br />
	<?php echo L('main_role')?><?php echo $rolename?> <br />
	<div class="bk20 hr"><hr /></div>
	<?php echo L('main_last_logintime')?><?php echo date('Y-m-d H:i:s',$logintime)?><br />
	<?php echo L('main_last_loginip')?><?php echo $loginip?> <br />
	</div>
</div>

<div class="col-2 col-auto" style="width:48%">
	<h6><?php echo L('main_sysinfo')?></h6>
	<div class="content">
	当前版本: LantuCMS <strong>V<?php echo $versionData['version'];?></strong>
	<?php echo $versionData['up_date'];echo $$update['versiontxt'];?><br />
	<?php echo L('main_os')?><?php echo $sysinfo['os']?> <br />
	<?php echo L('main_web_server')?><?php echo $sysinfo['web_server']?> <br />
	<?php echo L('main_sql_version')?><?php echo $sysinfo['mysqlv']?><br />
	<?php if($update['version']){?>	
	<a href="?m=admin&c=index&a=version_update&pc_hash=<?php echo $_SESSION['pc_hash'];?>" title="点击更新到最新版本" target="right">
	<span style="color:red;font-size:14px;"><br>【NEW】有版本更新 <?php echo 'V'.$update['version'].' ('.$update['up_date'].')';?></a>
	<span style="color:blue;font-size:12px;"><?php echo '<br>'.$update['versiontxt'];?></span>
	<?php }?>
	</div>
</div>

<div class="bk10"></div>
<div class="col-2 lf mr10" style="width:48%">
	<h6>开发团队</h6>
	<div class="content">
		陈凤森、韦克
	</div>
</div>
<div class="col-2 lf mr10" style="width:48%">
	<h6>当前版本日志</h6>
	<div class="content">
		<p>当前版本号：V<?php echo $versionData['version'];?><span style="margin-left: 15px;"></span>版本日期：<?php echo $versionData['up_date'];?></p>
		<?php 
			echo $reslisonstr;
		?>
	</div>
</div>
    <div class="bk10"></div>
</div>
</body></html>