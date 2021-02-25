<?php
defined('IN_ADMIN') or exit('No permission resources.');
?>

<?php defined('IN_ADMIN') or exit('No permission resources.'); ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"<?php if(isset($addbg)) { ?> class="addbg"<?php } ?>>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=<?php echo CHARSET;?>" />
<meta http-equiv="X-UA-Compatible" content="IE=7" />
<title><?php echo L('website_manage');?></title>
<link href="<?php echo CSS_PATH?>reset.css" rel="stylesheet" type="text/css" />
<link href="<?php echo CSS_PATH.SYS_STYLE;?>-system.css" rel="stylesheet" type="text/css" />
<link href="<?php echo CSS_PATH?>table_form.css" rel="stylesheet" type="text/css" />
<?php
if(!$this->get_siteid()) showmessage(L('admin_login'),'?m=admin&c=index&a=login');
if(isset($show_dialog)) {
?>
<link href="<?php echo CSS_PATH?>dialog.css" rel="stylesheet" type="text/css" />
<script language="javascript" type="text/javascript" src="<?php echo JS_PATH?>dialog.js"></script>
<?php } ?>
  <link rel="stylesheet" type="text/css" href="<?php echo CSS_PATH?>style/<?php echo SYS_STYLE;?>-styles1.css" title="styles1" media="screen" />
  <link rel="alternate stylesheet" type="text/css" href="<?php echo CSS_PATH?>style/<?php echo SYS_STYLE;?>-styles2.css" title="styles2" media="screen" />
  <link rel="alternate stylesheet" type="text/css" href="<?php echo CSS_PATH?>style/<?php echo SYS_STYLE;?>-styles3.css" title="styles3" media="screen" />
    <link rel="alternate stylesheet" type="text/css" href="<?php echo CSS_PATH?>style/<?php echo SYS_STYLE;?>-styles4.css" title="styles4" media="screen" />
<script language="javascript" type="text/javascript" src="<?php echo JS_PATH?>jquery.min.js"></script>
<script language="javascript" type="text/javascript" src="<?php echo JS_PATH?>admin_common.js"></script>
<script language="javascript" type="text/javascript" src="<?php echo JS_PATH?>styleswitch.js"></script>
<?php if(isset($show_validator)) { ?>
<script language="javascript" type="text/javascript" src="<?php echo JS_PATH?>formvalidator.js" charset="UTF-8"></script>
<script language="javascript" type="text/javascript" src="<?php echo JS_PATH?>formvalidatorregex.js" charset="UTF-8"></script>
<?php } ?>
<script type="text/javascript">
  window.focus();
  var pc_hash = '<?php echo $_SESSION['pc_hash'];?>';
  <?php if(!isset($show_pc_hash)) { ?>
    window.onload = function(){
    var html_a = document.getElementsByTagName('a');
    var num = html_a.length;
    for(var i=0;i<num;i++) {
      var href = html_a[i].href;
      if(href && href.indexOf('javascript:') == -1) {
        if(href.indexOf('?') != -1) {
          html_a[i].href = href+'&pc_hash='+pc_hash;
        } else {
          html_a[i].href = href+'?pc_hash='+pc_hash;
        }
      }
    }

    var html_form = document.forms;
    var num = html_form.length;
    for(var i=0;i<num;i++) {
      var newNode = document.createElement("input");
      newNode.name = 'pc_hash';
      newNode.type = 'hidden';
      newNode.value = pc_hash;
      html_form[i].appendChild(newNode);
    }
  }
<?php } ?>
</script>
</head>
<body>

<style type="text/css">
  html{_overflow-y:scroll}
</style>

<div class="pad_10">
<div class="table-list">
    <table width="100%" cellspacing="0">
        <thead>
		<tr>
		<th width="80">Siteid</th>
		<th><?php echo L('site_name')?></th>
		<th><?php echo L('site_dirname')?></th>
		<th><?php echo L('site_domain')?></th>
		<th align="center"><?php echo L('godaddy')?></th>
		<th width="150"><?php echo L('operations_manage')?></th>
		</tr>
        </thead>
        <tbody>
<?php 
if(is_array($list)):
	foreach($list as $v):
?>
<tr>
<td width="80" align="center"><?php echo $v['siteid']?></td>
<td align="center"><?php echo $v['name']?></td>
<td align="center"><?php echo $v['dirname']?></td>
<td align="center"><?php echo $v['domain']?></td>
<td align="center"><?php if ($v['siteid']!=1){?><?php echo pc_base::load_config('system', 'html_root')?>/<?php echo $v['dirname'];} else{echo '/';}?></td>
<td align="center"><a href="javascript:edit(<?php echo $v['siteid']?>, '<?php echo  new_addslashes(new_html_special_chars($v['name']))?>')"><?php echo L('edit')?></a> | 
<?php if($v['siteid']!=1) { ?><a href="?m=admin&c=site&a=del&siteid=<?php echo $v['siteid']?>" onclick="return confirm('<?php echo new_addslashes(new_html_special_chars(L('confirm', array('message'=>$v['name']))))?>')"><?php echo L('delete')?></a><?php } else { ?><font color="#cccccc"><?php echo L('delete')?></font><?php } ?></td>
</tr>
<?php 
	endforeach;
endif;
?>
</tbody>
</table>
</div>
	<div style="text-align: center;margin-top: 20px;">
    <strong style="color: #b02;font-size: 20px;">若域名已更改，请按以下步骤操作：</strong><br>
    <?php 
    if(empty($cache_status)){
      echo '<h1>(未完成) 第1步：点击右上角的“更新缓存”。</h1><br>';
    }else{
      echo '<h1 style="color: #ccc;">(已完成) 第1步：点击右上角的“更新缓存”。</h1><br>';
    }
    if(empty($olddomain_status)){
      echo '<h1>(未完成) 第2步：<input type="button" onclick="urlupdate()" style="cursor: pointer;" value="更新域名URL" /></h1>';
      echo '<br>更新完，刷新本页面查看结果！';
    }else{
      echo '<h1 style="color: #ccc;">(已完成) 第2步：<input type="button" disabled="disabled" onclick="urlupdate()" value="更新域名URL" /></h1>';
    }

    ?>
    
	</div>
</div>
<div id="pages"><?php echo $pages?></div>
<script type="text/javascript">
<!--
function edit(id, name) {
	window.top.art.dialog({id:'edit'}).close();
	window.top.art.dialog({title:'<?php echo L('edit_site')?>《'+name+'》',id:'edit',iframe:'?m=admin&c=site&a=edit&siteid='+id,width:'700',height:'500'}, function(){var d = window.top.art.dialog({id:'edit'}).data.iframe;d.document.getElementById('dosubmit').click();return false;}, function(){window.top.art.dialog({id:'edit'}).close()});
}
//-->
</script>
<script>
  function urlupdate() {
  window.top.art.dialog({id:'urlupdate'}).close();
  window.top.art.dialog({title:'更新域名URL',id:'urlupdate',iframe:'?m=content&c=create_html&a=urlupdate',width:'700',height:'500'}, function(){
    //var d = window.top.art.dialog({id:'urlupdate'}).data.iframe;d.document.getElementById('dosubmit').click();
    window.top.art.dialog({id:'urlupdate'}).close();
    return false;
  }, 
    function(){
	    // window.localtion.href="?m=admin&amp;c=site&amp;a=init";
    	window.top.art.dialog({id:'urlupdate'}).close();
    });
  return false;
}
</script>
</body>
</html>