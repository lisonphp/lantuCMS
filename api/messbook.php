<?php
defined('IN_PHPCMS') or exit('No permission resources.'); 
if($_GET['tel']) {
	if(!preg_match("/^1\d{10}$/",$_GET['tel'])){
		$arr['res']=false;
        $arr['msg']='手机号码格式不对';
		echo json_encode($arr);exit;
	}
	$tel=$_GET['tel'];
	$telyes=$tel * 864;//简单加密
	$db = pc_base::load_model('messbook_model');
    $db->set_model(14);
    
    $content=htmlspecialchars(strip_tags(trim($_GET['content'])));
    $name=htmlspecialchars(strip_tags(trim($_GET['name'])));
    $email=htmlspecialchars(strip_tags(trim($_GET['email'])));
    $channel=htmlspecialchars(strip_tags(trim($_GET['channel'])));
    $ziops=htmlspecialchars(strip_tags(trim($_GET['ziops'])));
    $qq=htmlspecialchars(strip_tags(trim($_GET['qq'])));
    $url=htmlspecialchars(strip_tags(trim($_GET['url'])));
	if(empty($name)){
		if(strlen($content) > 60){//汉字占用3个字符
			$title=substr($content,0,60) . '...';
		}else{
			$title=$content;
		}
	}else{
		$title=trim($name);
		if(strlen($title) > 12){//汉字占用3个字符
			$title=substr(trim($title),0,12) . '...';
		}
	}
	$ip=ip();
    // $ip='119.130.242.44';

    //同一IP控制多少分钟内提交一次
    $db_lison = pc_base::load_model('lison_model');
    $db_lison->lison_tb('ipfilters');
    $res_ip=$db_lison->get_one();
    if($res_ip){
        $whreiptime=time() -$res_ip['loops'];
        $whreip="`ip`='$ip' and `inputtime` > $whreiptime";
        $db_lison_b = pc_base::load_model('lison_model');
        $db_lison_b->lison_tb('messbook');
        $res_is=$db_lison_b->get_one($whreip);
        if($res_is){
            $arr['res']=false;
            $arr['msg']='同一IP频率控制';
            echo json_encode($arr);exit;
        }
    }
    //控制同一手机号码 重复提交
    $whreteltime=time() - 86400*30;
    $whretel="`tel`='$telyes' and `inputtime` > $whreteltime";
    $db_lison_c = pc_base::load_model('lison_model');
    $db_lison_c->lison_tb('messbook');
    $res_telis=$db_lison_c->get_one($whretel);
    if($res_telis){
        $arr['res']=false;
        $arr['msg']='同一手机号码重复控制';
        echo json_encode($arr);exit;
    }

	require PC_PATH.'libs/classes/ip/src/ipip/db/City.php';
	require PC_PATH.'libs/classes/ip/src/ipip/db/Reader.php';
	$files=PC_PATH.'libs/classes/ip/ipipfree.ipdb';
	$city = new ipip\db\City($files);
	$res_city=$city->find($ip, 'CN');
	if($res_city[1]){
		$sheng=$res_city[1];
		$shi=$res_city[2] ?  $res_city[2] : get_provincial_capital_by_province($sheng);
	}else{
		$telarr=selephone($tel);
		$sheng=$telarr['sheng'];
		$shi=$telarr['shi'];
	}

	$data = array(
		'name'=>$title,
		'title'=>$title,
		'tel'=>$telyes,
		'email'=>trim($email),
		'channel'=>trim($channel),
		'ziops'=>trim($ziops),
		'qq'=>trim($qq),
		'catid'=>999999,
		'status'=>99,
		'inputtime'=>SYS_TIME,
		'updatetime'=>SYS_TIME,
		'ip'=>$ip,
		'url'=>$url,
		'sheng'=>$sheng,
		'shi'=>$shi,
	);
	$res_id=$db->insert($data,true);
	if(!$res_id){
		$arr->res=false;
		echo json_encode($arr);exit;
	}
	$db->table_name = 'lt_messbook_data';
	$res_data=$db->insert(array('id'=>$res_id,'content'=>$content));
	if(!$res_data){
        $arr['res']=false;
        $arr['msg']='写入失败捏';
		echo json_encode($arr);exit;
	}
	$arr['res']=true;
	echo json_encode($arr);exit;
}else{
	$arr->res=false;
	echo json_encode($arr);exit;
}

/**
 * 根据省份获取省会
 * */
function get_provincial_capital_by_province($province = '')
{
    $area_array = [
        '山东'  => '济南',
        '河北'  => '石家庄',
        '吉林'  => '长春',
        '黑龙江' => '哈尔滨',
        '辽宁'  => '沈阳',
        '内蒙古' => '呼和浩特',
        '新疆'  => '乌鲁木齐',
        '甘肃'  => '兰州',
        '宁夏'  => '银川',
        '山西'  => '太原',
        '陕西'  => '西安',
        '河南'  => '郑州',
        '安徽'  => '合肥',
        '江苏'  => '南京',
        '浙江'  => '杭州',
        '福建'  => '福州',
        '广东'  => '广州',
        '江西'  => '南昌',
        '海南'  => '海口',
        '广西'  => '南宁',
        '贵州'  => '贵阳',
        '湖南'  => '长沙',
        '湖北'  => '武汉',
        '四川'  => '成都',
        '云南'  => '昆明',
        '西藏'  => '拉萨',
        '青海'  => '西宁',
        '天津'  => '天津',
        '上海'  => '上海',
        '重庆'  => '重庆',
        '北京'  => '北京',
        '台湾'  => '台北',
        '香港'  => '香港',
        '澳门'  => '澳门'
    ];
    if ($province && isset($area_array[$province])) {
        return $area_array[$province];
    } else {
        return '-';
    }
}

//查询手机号归属地
function selephone($tel){
	//验证来源域名
    // $urlcomplete=$this->geturlcomplete();
    // echo 22;exit;
    $url='http://www.baidu.com/s?wd='.$_REQUEST['tel'];
    $str=httpsRequestlison($url,'');
    $getinfo=explode('手机号码&quot;'.$_REQUEST['tel'],$str);
    $getinfo=substr($getinfo[1],72,80);
    // var_dump($getinfo);exit;
    if(!$getinfo){
        $getinfo='';
    }elseif(strpos($getinfo,'天津')){
        $getinfo='天津市';
    }elseif(strpos($getinfo,'北京')){
        $getinfo='北京市';
    }elseif(strpos($getinfo,'重庆')){
        $getinfo='重庆市';
    }elseif(strpos($getinfo,'上海')){
        $getinfo='上海市';
    }else{
        $getinfo=substr_replace($getinfo,"省",strpos($getinfo,'&nbsp;'),strlen('&nbsp;'));//只替换第一个字符
        $getinfo=substr_replace($getinfo,"市",strpos($getinfo,'&nbsp;'),strlen('&nbsp;'));//只替换第一个字符
        $getinfo=str_replace('&nbsp;', '', $getinfo);
        $getinfo=str_replace("\n", '', $getinfo);
        $getinfo=str_replace(" ", '', $getinfo);
        $getinfo=str_replace('中国移动', '', $getinfo);
        $getinfo=str_replace('中国电信', '', $getinfo);
        $getinfo=str_replace('中国联通', '', $getinfo);
    }
    $getinfo=str_replace('</span></div>', '', $getinfo);
    // var_dump($getinfo);exit;
    if(empty($getinfo)){
        // echo 77;exit;
        $url='https://shouji.supfree.net/fish.asp?cat='.$_REQUEST['tel'];
        $str=httpsRequestlison($url,'');
        $str=iconv("GB2312","UTF-8",$str);//GB2312转换为utf-8
        preg_match('/<p><span class="bgreen">归属地：<(.*?)>(.*?)<\/p>/i', $str, $mach);
        // var_dump($mach[2]);exit;
        $getinfo=$mach[2];
    }
    if(empty($getinfo)){
        echo '';exit;
    }
 
    //过滤自治区
    if(strpos($getinfo,'新疆') !== false){
        $sheng='新疆';
        $shi=mb_substr($getinfo,mb_strpos($getinfo,"省")+1);
        $shi=$shi ? $shi : mb_substr($getinfo,mb_strpos($getinfo,"区")+1);
    }elseif(strpos($getinfo,'西藏') !== false){
        $sheng='西藏';
        $shi=mb_substr($getinfo,mb_strpos($getinfo,"省")+1);
        $shi=$shi ? $shi : mb_substr($getinfo,mb_strpos($getinfo,"区")+1);
    }elseif(strpos($getinfo,'宁夏') !== false){
        $sheng='宁夏';
        $shi=mb_substr($getinfo,mb_strpos($getinfo,"省")+1);
        $shi=$shi ? $shi : mb_substr($getinfo,mb_strpos($getinfo,"区")+1);
    }elseif(strpos($getinfo,'内蒙古') !== false){
        $sheng='内蒙古';
        $shi=mb_substr($getinfo,mb_strpos($getinfo,"省")+1);
        $shi=$shi ? $shi : mb_substr($getinfo,mb_strpos($getinfo,"区")+1);
    }
    //过滤直辖市
    if(strpos($getinfo,'北京') !== false){
        $sheng='北京';
        $shi='北京';
    }elseif(strpos($getinfo,'天津') !== false){
        $sheng='天津';
        $shi='天津';
    }elseif(strpos($getinfo,'上海') !== false){
        $sheng='上海';
        $shi='上海';
    }elseif(strpos($getinfo,'重庆') !== false){
        $sheng='重庆';
        $shi='重庆';
    }
    //过滤普通市
    if(strpos($getinfo,'省') !== false){
        $sheng=substr($getinfo,0,strpos($getinfo,"省"));
        $shi=mb_substr($getinfo,mb_strpos($getinfo,"省")+1);
        $shi=$shi ? $shi : mb_substr($getinfo,mb_strpos($getinfo,"区")+1);
    }
    $arrs=array('sheng'=>$sheng,'shi'=>$shi);
    $type=$_REQUEST['type'] ? 1 : '';
    if($type){
        echo $sheng.'省'.$shi;exit;
    }
    // dump($arrs);exit;
	// echo json_encode($arrs);
	return $arrs;
}

function httpsRequestlison($url, $data = null){
    $ch = curl_init();
    //设置url
    curl_setopt($ch, CURLOPT_URL, $url);
    //设置curl_exec方法的返回值,结果返回,不自动输出任何内容
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    if(!empty($data)){
        //发送post请求,
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $data);
    }
    //跳过ssl检查项
    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
    curl_setopt($ch, CURLOPT_TIMEOUT, 8);
    //发送请求
    $result = curl_exec($ch);
    curl_close($ch);
    return $result;
}
?>
