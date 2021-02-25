<?php
defined('IN_ADMIN') or exit('No permission resources.'); 
include $this->admin_tpl('header', 'admin');
?>
<style type="text/css">
	html{_overflow:hidden}
	.frmaa{float:left;width:80%; min-width: 870px; _width:870px;}
	.rraa{float: right; width:230px;}
	.pt{margin-top: 4px;}
	
</style>
<body style="overflow:hidden">
<div class="pad-10" style="padding-bottom:0px">

<div class="col-auto">
<form action="?m=template&c=file&a=edit_file&style=<?php echo $this->style?>&dir=<?php echo $dir?>&file=<?php echo $file?>" method="post" name="myform" id="myform" onsubmit="return check_form();">
<textarea name="code" id="code" style="height: 280px;width:96%; visibility:inherit"><?php echo $data?></textarea>
<div class="bk10"></div>
<input type="text" id="text" value="" /><input type="button" class="button" onClick="fnSearch()" value="模糊搜索" /> 
<?php if ($is_write==0){echo '<font color="red">'.L("file_does_not_writable").'</font>';}?> 
<?php if (module_exists('tag')) {?><input type="button" class="button" onClick="create_tag()" value="<?php echo L('create_tag')?>" /> 
<input type="button" class="button" onClick="select_tag()" value="<?php echo L('select_tag')?>" /> <?php }?>
<BR>
<input type="button" onclick="reback()" value="返回上一级" style="margin-left: 20px;">
<input type="submit" id="dosubmit" class="button pt" name="dosubmit" value="<?php echo L('submit')?>" style="margin-left: 30%"/>
</form>
</div>
</div>

以下为搜索结果预览：
<div id="dvPop"><div>
<div></div>
<script type="text/javascript" src="http://apps.bdimg.com/libs/jquery/1.11.1/jquery.min.js"></script>

<?php $reback=base64_decode($_GET['reback']);
$reback=str_replace('.\\', '', $reback);
$_SESSION['reback']=$reback ? $reback : $_SESSION['reback'];
?>
<style type="text/css">
 .kw{background:#f00;color:#fff;} 
#dvPop{
	/*position:absolute;*/
	margin-top: 10px;
	display:none;
	border:solid 0px #000;
	background:#fff;
	overflow:auto;
	font-size:13px;
}
#dvPop .close{text-align:right;color:blue} 
</style>

<script type="text/javascript">
function reback(){
	window.location.href="<?php  echo $_SESSION['reback'].'&pc_hash='.$_SESSION['pc_hash'];?>";
	return false;
}

var oRange; 
var intCount = 0;  
var intTotalCount = 100;

function fnSearch() { 
	var strBeReplaced; 
	var strReplace; 
	// console.log(strBeReplaced);
	strBeReplaced = $('#text').val(); 
	// findInPage(strBeReplaced);
	check(strBeReplaced);
} 

 function check(strBeReplaced) {		
 	var key=strBeReplaced;
 	if(key==''){
 		$("#dvPop").hide();		
	}else{
		var rx=new RegExp(key,"g");
		var t = $('#code');
		if(rx.test(t.val())){
			var pop=$('#dvPop');
			if(!pop.attr('init'))pop.css({
				left:t.offset().left,top:t.offset().top,width:t.width(),height:t.height()
			});
			pop.find('div:last').html(t.val().replace(rx,'<span class="kw">'+key+'</span>')).end().show();
		}
	}
}
function dohide(){
	$("#dvPop").hide();
}



function create_tag() {
	window.top.art.dialog({id:'add',iframe:'?m=tag&c=tag&a=add&ac=js', title:"<?php echo L('create_tag')?>", width:'700', height:'500', lock:true}, function(){var d = window.top.art.dialog({id:'add'}).data.iframe;var form = d.document.getElementById('dosubmit');form.click();return false;}, function(){window.top.art.dialog({id:'add'}).close()});
}

// function insertText(text)
// {
// 	$('#code').focus();
//     var str = document.selection.createRange();
// 	str.text = text;
// }

function call(text) {
	$('#code').focus();
    var str = document.selection.createRange();
	var text_lenght = parseInt($('#text_lenght').val());
	str.moveStart("character", text_lenght);
	str.select();
	str.text = text;
}

function GetPoint() {
	if ($.browser.msie) {
		rng = event.srcElement.createTextRange();
		rng.moveToPoint(event.x,event.y);
		rng.moveStart("character",-event.srcElement.value.length);
		var text_lenght = rng.text.length;
	} else {
		//alert($('#code').selectionStart);
	}
	$('#text_lenght').val(text_lenght);
}

function select_tag() {
	window.top.art.dialog({id:'list',iframe:'?m=tag&c=tag&a=lists', title:"<?php echo L('tag_list')?>", width:'700', height:'500', lock:true}, function(){var d = window.top.art.dialog({id:'add'}).data.iframe;var form = d.document.getElementById('dosubmit');form.click();return false;}, function(){window.top.art.dialog({id:'list'}).close()});
}

function fnNext(){ 
	if (intCount > 0 && intCount < intTotalCount){ 
		intCount = intCount + 1; 
	} else { 
		intCount = 1 ; 
	} 
} 

function check_form() {
	if(findInPage("{php")) {
		alert("在线模板编辑禁止提交含有{php 的标签。");
		return false;
	} else if(findInPage("<\?php")) {
		alert('在线模板编辑禁止提交含有<\?php 的标签。');
		return false;
	} else {
		myform.submit();
	}
}
var isie = false;
if(navigator.userAgent.indexOf("MSIE")>0) { 
   isie = true;
}
   
var win = window;    // window to search. 
var n   = 0; 

function findInPage(str) { 
  var txt, i, found;
  if (str == "") 
    return false; 
  if (!isie) { console.log(str,11);
	 txt = win.document.body.createTextRange();
		for (i = 0; i <= n && (found = txt.findText(str)) != false; i++) { 
		  txt.moveStart("character", 1); 
		  txt.moveEnd("textedit"); 
		} 
		if (found) {
		  txt.moveStart("character", -1); 
		  txt.findText(str); 
		  txt.select(); 
		  txt.scrollIntoView();
		  n++;
		  return true;
		} else {
		  if (n > 0) {
			n = 0; 
			findInPage(str);
			return true;
		  }
	  }
	  return false; 
  } else {console.log(str,22);
		 if (!win.find(str)) 
      while(win.find(str, true)) 
        n++; 
    else
      n++;
    if (n == 0) {
      return false
	 } else {
		 return true;
	 }
  }
}
//--> 
</script>

</body>
</html>