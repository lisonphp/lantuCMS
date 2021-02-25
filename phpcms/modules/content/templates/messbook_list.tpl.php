<?php
defined('IN_ADMIN') or exit('No permission resources.');
include $this->admin_tpl('header','admin');?>
<div id="closeParentTime" style="display:none"></div>
<SCRIPT LANGUAGE="JavaScript">
<!--
	if(window.top.$("#current_pos").data('clicknum')==1 || window.top.$("#current_pos").data('clicknum')==null) {
	parent.document.getElementById('display_center_id').style.display='';
	parent.document.getElementById('center_frame').src = '?m=content&c=content&a=public_categorys&type=add&menuid=<?php echo $_GET['menuid'];?>&pc_hash=<?php echo $_SESSION['pc_hash'];?>';
	window.top.$("#current_pos").data('clicknum',0);
}
//-->
</SCRIPT>
<div class="pad-10">
<div class="content-menu ib-a blue line-x">
<a class="add fb hideexcel" href="javascript:;" onclick=javascript:batchexcel('','')><em>导 出</em></a>

<?php if($category['ishtml']) {?>
<!-- <span>|</span><a href="?m=content&c=create_html&a=category&pagesize=30&dosubmit=1&modelid=0&catids[0]=<?php echo $catid;?>&pc_hash=<?php echo $pc_hash;?>&referer=<?php echo urlencode($_SERVER['QUERY_STRING']);?>"><em><?php echo L('update_htmls',array('catname'=>$category['catname']));?></em></a> -->
<?php }?>
</div>
<div id="searchid" style="display:<?php if(!isset($_GET['search'])) echo 'none';?>">
<form name="searchform" action="" method="get" >
<input type="hidden" value="content" name="m">
<input type="hidden" value="content" name="c">
<input type="hidden" value="init" name="a">
<input type="hidden" value="<?php echo $catid;?>" name="catid">
<input type="hidden" value="<?php echo $steps;?>" name="steps">
<input type="hidden" value="1" name="search">
<input type="hidden" value="<?php echo $pc_hash;?>" name="pc_hash">
<table width="100%" cellspacing="0" class="search-form">
    <tbody>
		<tr>
		<td>
		<div class="explain-col">
 
				<?php echo L('addtime');?>：
				<?php echo form::date('start_time',$_GET['start_time'],0,0,'false');?>- &nbsp;<?php echo form::date('end_time',$_GET['end_time'],0,0,'false');?>
				
				<select name="posids"><option value='' <?php if($_GET['posids']=='') echo 'selected';?>><?php echo L('all');?></option>
				<option value="1" <?php if($_GET['posids']==1) echo 'selected';?>><?php echo L('elite');?></option>
				<option value="2" <?php if($_GET['posids']==2) echo 'selected';?>><?php echo L('no_elite');?></option>
				</select>				
				<select name="searchtype">
					<option value='0' <?php if($_GET['searchtype']==0) echo 'selected';?>><?php echo L('title');?></option>
					<option value='1' <?php if($_GET['searchtype']==1) echo 'selected';?>><?php echo L('intro');?></option>
					<option value='2' <?php if($_GET['searchtype']==2) echo 'selected';?>><?php echo L('username');?></option>
					<option value='3' <?php if($_GET['searchtype']==3) echo 'selected';?>>ID</option>
				</select>
				
				<input name="keyword" type="text" value="<?php if(isset($keyword)) echo $keyword;?>" class="input-text" />
				<input type="submit" name="search" class="button" value="<?php echo L('search');?>" />
	</div>
		</td>
		</tr>
    </tbody>
</table>
</form>
</div>
<form name="myform" id="myform" action="" method="post" >
<div id="showexcel" style="display:none;padding:10px 0;">
<label for="">导出密码：</label>
<input type="text" name="excelpassword" id="link_name" size="16" class="input-text" />
<input type="button" class="button" value="确认导出" style="cursor:pointer" onclick="myform.action='?m=content&c=messbook&a=out_excel&dosubmit=1';myform.submit();" />
</div>
<div class="table-list">
    <table width="100%">
        <thead>
            <tr>
			 <th width="16"><input type="checkbox" value="" id="check_box" onclick="selectall('ids[]');"></th>
            <th width="50">姓名/内容</th>
            <th width="40">手机号码</th>
            <th width="40">URL</th>
            <th width="40">省市</th>
            <th width="40">IP</th>
            <th width="70">时间</th>
			<th width="72"><?php echo L('operations_manage');?></th>
            </tr>
        </thead>
<tbody>
    <?php
	// print_r($datas);exit;
	if(is_array($datas)) {
		$sitelist = getcache('sitelist','commons');
		$release_siteurl = $sitelist[$category['siteid']]['url'];
		$path_len = -strlen(WEB_PATH);
		$release_siteurl = substr($release_siteurl,0,$path_len);
		$this->hits_db = pc_base::load_model('hits_model');
		
		foreach ($datas as $r) {
			$hits_r = $this->hits_db->get_one(array('hitsid'=>'c-'.$modelid.'-'.$r['id']));
	?>
        <tr>
		<td align="center"><input class="inputcheckbox " name="ids[]" value="<?php echo $r['id'];?>" type="checkbox"></td>
		<td align='center' ><?php echo $r['title'] ? $r['title'] : $r['name'];?></td>
		<td >
			<span id="restel_<?php echo $r['id'];?>"><?php $tel=$r['tel'] / 864; echo substr_replace($tel, '****', 3,4);?></span>
			<span id="showetel_<?php echo $r['id'];?>" style="display:none;padding:10px 0;">
					<label style="margin-left:5px;">密码</label>
					<input type="text" id="tel_password_<?php echo $r['id'];?>" size="10" class="input-text" />
					<input type="button" class="button" value="确认" style="cursor:pointer" onclick="ajaxshowtel(<?php echo $r['id']?>);" />
			</span>
			<span class="stel" id="inittel_<?php echo $r['id'];?>" onclick='telshows("<?php echo $r['id'];?>")'>查看号码</span>
				
		</td>
		<td align='center'><?php echo str_cut($r['url'],60,'...');?></td>
		<td align='center'><?php echo $r['sheng'].$r['shi'];?></td>
		<td align='center'><?php echo $r['ip'];?></td>
		<td align='center'><?php echo date("Y-m-d H:i:s",$r['inputtime']);?></td>
		<td align='center'><a href="javascript:;" onclick="javascript:openwinx('?m=content&c=messbook&a=edit&catid=<?php echo $catid;?>&id=<?php echo $r['id']?>','')">查看或修改</a>

	</tr>
     <?php }
	}
	?>
</tbody>
     </table>
    <div class="btn"><label for="check_box"><?php echo L('selected_all');?>/<?php echo L('cancel');?></label>
		<input type="hidden" value="<?php echo $pc_hash;?>" name="pc_hash">
    	<input type="button" class="button" value="<?php echo L('listorder');?>" onclick="myform.action='?m=content&c=content&a=listorder&dosubmit=1&catid=<?php echo $catid;?>&steps=<?php echo $steps;?>';myform.submit();"/>
		<?php if($category['content_ishtml'] && $steps !=1) {?>
		<input type="button" class="button" value="<?php echo L('createhtml');?>" onclick="myform.action='?m=content&c=create_html&a=batch_show&dosubmit=1&catid=<?php echo $catid;?>&steps=<?php echo $steps;?>';myform.submit();"/>
		<?php }
		if($status!=99) {?>
		<input type="button" class="button" value="<?php echo L('passed_checked');?>" onclick="myform.action='?m=content&c=content&a=pass&catid=<?php echo $catid;?>&steps=<?php echo $steps;?>';myform.submit();"/>
		<?php }?>

		<input type="button" class="button" value="<?php echo L('delete');?>" onclick="javascript:$('#showdelete').show();$(this).hide();"/>
		<div id="showdelete" style="display:none;padding:10px 0;">
		<label for="">密码：</label>
		<input type="text" name="deletepassword" id="deletepassword" size="16" class="input-text" />
		<input type="button" class="button" value="确认" style="cursor:pointer" onclick="ajaxdelete();" />
		</div>

		<?php if(!isset($_GET['reject'])) { ?>
		<!-- <input type="button" class="button" value="<?php echo L('push');?>" onclick="push();"/> -->
		<?php if($workflow_menu) { ?>
		<!-- <input type="button" class="button" value="<?php echo L('reject');?>" onclick="reject_check()"/> -->
		<div id='reject_content' style='background-color: #fff;border:#006699 solid 1px;position:absolute;z-index:10;padding:1px;display:none;'>
		<table cellpadding='0' cellspacing='1' border='0'><tr><tr><td colspan='2'><textarea name='reject_c' id='reject_c' style='width:300px;height:46px;'  onfocus="if(this.value == this.defaultValue) this.value = ''" onblur="if(this.value.replace(' ','') == '') this.value = this.defaultValue;"><?php echo L('reject_msg');?></textarea></td><td><input type='button' value=' <?php echo L('submit');?> ' class="button" onclick="reject_check(1)"></td></tr>
		</table>
		</div>
		<?php }}?>
		<!-- <input type="button" class="button" value="<?php echo L('remove');?>" onclick="myform.action='?m=content&c=content&a=remove&catid=<?php echo $catid;?>';myform.submit();"/> -->
		<?php echo runhook('admin_content_init')?>
	</div>
    <div id="pages"><?php echo $pages;?></div>
</div>
</form>
</div>
<style>
	.stel{
		border:1px solid #999;
		padding:2px;
		cursor:pointer;
		font-size:12px;
		color:#fff;
		background:#33bbee;
	}
	.stel:hover{
		background:#1482ab;
	}
</style>
<script language="javascript" type="text/javascript" src="<?php echo JS_PATH?>cookie.js"></script>
<script>
	function batchexcel(id, name) {
		$('#showexcel').css('display','block');
		$('.hideexcel').css('display','none');
		// window.top.art.dialog({id:'edit'}).close();
		// window.top.art.dialog({title:'导出数据'+name+' ',id:'edit',iframe:'?m=content&c=messbook&a=out_excel',width:'500',height:'250'}, function(){var d = window.top.art.dialog({id:'edit'}).data.iframe;var form = d.document.getElementById('dosubmit');form.click();return false;}, function(){window.top.art.dialog({id:'edit'}).close()});
	}
	function telshows(id){
		$('#showetel_'+id).css('display','inline-block');
		$('#inittel_'+id).css('display','none');
	}
</script>
<script>
	function ajaxshowtel(id){
		var tel_password=$('#tel_password_'+id).val();
		$.ajax({
		url:'?m=content&c=messbook&a=ajaxshowtel&pc_hash=<?php echo $_GET['pc_hash'];?>',
		type:'post',
		data:{id:id,tel_password:tel_password},
		dataType: 'json',
		success:(data)=>{
			if(data.code == 1){
				$('#restel_'+id).html(data.txt);
			}else{
				alert(data.msg);
			}
		}
		});
	}
	function ajaxdelete(id){
		var deletepassword=$('#deletepassword').val();
		$.ajax({
		url:'?m=content&c=messbook&a=ajaxdelete&pc_hash=<?php echo $_GET['pc_hash'];?>',
		type:'post',
		data:{id:id,deletepassword:deletepassword},
		dataType: 'json',
		success:(data)=>{
			// console.log(data,'aa');
			if(data.code == 1){
				$("#myform").attr('action','?m=content&c=messbook&a=delete&dosubmit=1');
				$('#myform').submit();
			}else{
				alert(data.msg);
			}
		}
		});
	}
</script>
<script type="text/javascript"> 
<!--
function push() {
	var str = 0;
	var id = tag = '';
	$("input[name='ids[]']").each(function() {
		if($(this).attr('checked')=='checked') {
			str = 1;
			id += tag+$(this).val();
			tag = '|';
		}
	});
	if(str==0) {
		alert('<?php echo L('you_do_not_check');?>');
		return false;
	}
	window.top.art.dialog({id:'push'}).close();
	window.top.art.dialog({title:'<?php echo L('push');?>：',id:'push',iframe:'?m=content&c=push&action=position_list&catid=<?php echo $catid?>&modelid=<?php echo $modelid?>&id='+id,width:'800',height:'500'}, function(){var d = window.top.art.dialog({id:'push'}).data.iframe;// 使用内置接口获取iframe对象
	var form = d.document.getElementById('dosubmit');form.click();return false;}, function(){window.top.art.dialog({id:'push'}).close()});
}
function confirm_delete(){
	if(confirm('<?php echo L('confirm_delete', array('message' => L('selected')));?>')) $('#myform').submit();
}
function view_comment(id, name) {
	window.top.art.dialog({id:'view_comment'}).close();
	window.top.art.dialog({yesText:'<?php echo L('dialog_close');?>',title:'<?php echo L('view_comment');?>：'+name,id:'view_comment',iframe:'index.php?m=comment&c=comment_admin&a=lists&show_center_id=1&commentid='+id,width:'800',height:'500'}, function(){window.top.art.dialog({id:'edit'}).close()});
}
function reject_check(type) {
	if(type==1) {
		var str = 0;
		$("input[name='ids[]']").each(function() {
			if($(this).attr('checked')=='checked') {
				str = 1;
			}
		});
		if(str==0) {
			alert('<?php echo L('you_do_not_check');?>');
			return false;
		}
		document.getElementById('myform').action='?m=content&c=content&a=pass&catid=<?php echo $catid;?>&steps=<?php echo $steps;?>&reject=1';
		document.getElementById('myform').submit();
	} else {
		$('#reject_content').css('display','');
		return false;
	}	
}
setcookie('refersh_time', 0);
function refersh_window() {
	var refersh_time = getcookie('refersh_time');
	if(refersh_time==1) {
		window.location.reload();
	}
}
setInterval("refersh_window()", 3000);
//-->
</script>

</body>
</html>