<?php defined('IN_PHPCMS') or exit('No permission resources.'); ?><!DOCTYPE html>
<html lang="cn">

<head>
    <meta name="baidu-site-verification" content="iu78mdbIAL" />
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <?php if($catid) { ?>
    <?php $strtitle=substr($SEO[title],0,strlen($SEO[title])-2);?>
    <title><?php echo $strtitle;?></title>
    <meta name="description" content="<?php echo $SEO['description'];?>"/>
    <meta name="keywords" content="<?php echo $SEO['keyword'];?>"/>
    <?php } else { ?>
        <?php if(defined('IN_ADMIN')  && !defined('HTML')) {echo "<div class=\"admin_piao\" pc_action=\"get\" data=\"op=get&tag_md5=f1fa5bb3f3a3fcfff7f62d7d5fa853c5&sql=select+setting+from+lt_category+where+catid%3D35\"><a href=\"javascript:void(0)\" class=\"admin_piao_edit\">编辑</a>";}pc_base::load_sys_class("get_model", "model", 0);$get_db = new get_model();$r = $get_db->sql_query("select setting from lt_category where catid=35 LIMIT 20");while(($s = $get_db->fetch_next()) != false) {$a[] = $s;}$data = $a;unset($a);?>
            <?php $setting = string2array($data[0]['setting'])?>
            <title><?php echo $setting['meta_title'];?>-<?php echo $SEO['site_title'];?></title>
            <meta name="keywords" content="<?php echo $setting['meta_keywords'];?>"/>
            <meta name="description" content="<?php echo $setting['meta_description'];?>"/>            
        <?php if(defined('IN_ADMIN') && !defined('HTML')) {echo '</div>';}?>
    <?php } ?>  
    <link href="https://cdn.bootcss.com/animate.css/3.7.2/animate.min.css" rel="stylesheet">
    <link href="https://cdn.bootcss.com/Swiper/4.5.0/css/swiper.min.css" rel="stylesheet">
    <link href="https://cdn.bootcss.com/jquery-nice-select/1.1.0/css/nice-select.min.css" rel="stylesheet">
    <link rel="stylesheet" href="/statics/pc/css/style.css">

</head>
<style>
.pages_01 li a {
    color: #333333;
}
.pages_01_ul {
    margin: 0 auto;
    padding: 20px 0;
    text-align: center;
    clear: both;
}
.pages_01 a {
    border: 1px solid #e3e3e3;
    color: #333;
    display: inline-block;
    padding: 0 10px;
}
.pages_01 li {
    list-style: none;
    display: inline;
    padding: 3px 10px;
}
.gy {
    width: 100%;
    background: #FFF;
    float: left;
    margin-top: 2em;
}
</style>

<body>
<header id="header">
    <div class="header_nav">
        <div class="container">
            <div class="logo"><a href="/"><img src="/statics/pc/image/logo.png" alt="" srcset=""></a></div>
            <ul class="one_nav">
                
                <?php if(defined('IN_ADMIN')  && !defined('HTML')) {echo "<div class=\"admin_piao\" pc_action=\"content\" data=\"op=content&tag_md5=a00bf54152c16cfc1df5a5507d4c5605&action=category&order=listorder+ASC&catid=0\"><a href=\"javascript:void(0)\" class=\"admin_piao_edit\">编辑</a>";}$content_tag = pc_base::load_app_class("content_tag", "content");if (method_exists($content_tag, 'category')) {$data = $content_tag->category(array('order'=>'listorder ASC','catid'=>'0','limit'=>'20',));}?>
                <?php $n=1; if(is_array($data)) foreach($data AS $k => $r) { ?>
                <li class="one_list">
                    <?php if($r[catid] ==27 || $r[catid] ==34) { ?>
                    <a class="one_list_a" href="<?php echo $r['url'];?>"><?php echo $r['catname'];?></a>
                    <?php } else { ?>
                    <a class="one_list_a one_list_a_x" href="javascript:void(0)"><?php echo $r['catname'];?></a>
                    <?php } ?>
                    <ul class="two_nav">
                        <?php if(defined('IN_ADMIN')  && !defined('HTML')) {echo "<div class=\"admin_piao\" pc_action=\"content\" data=\"op=content&tag_md5=68b60a4e12dc4b01a36d06e138a7ecbf&action=category&catid=%24r%5Bcatid%5D&order=listorder+ASC&return=data2\"><a href=\"javascript:void(0)\" class=\"admin_piao_edit\">编辑</a>";}$content_tag = pc_base::load_app_class("content_tag", "content");if (method_exists($content_tag, 'category')) {$data2 = $content_tag->category(array('catid'=>$r[catid],'order'=>'listorder ASC','limit'=>'20',));}?>
                        <?php $n=1; if(is_array($data2)) foreach($data2 AS $e => $v) { ?>
                        <?php if($v[catid] ==43 || $v[catid] ==44) { ?>
                        <li class="two_list">
                            <a class="two_list_a two_list_a_ti" href="javascript:void(0)"><?php echo $v['catname'];?></a>
                            <?php if(defined('IN_ADMIN')  && !defined('HTML')) {echo "<div class=\"admin_piao\" pc_action=\"content\" data=\"op=content&tag_md5=8e31438ac0ad2236cf68627387932923&action=category&catid=%24v%5Bcatid%5D&order=listorder+ASC&return=data3\"><a href=\"javascript:void(0)\" class=\"admin_piao_edit\">编辑</a>";}$content_tag = pc_base::load_app_class("content_tag", "content");if (method_exists($content_tag, 'category')) {$data3 = $content_tag->category(array('catid'=>$v[catid],'order'=>'listorder ASC','limit'=>'20',));}?>
                            <?php $n=1;if(is_array($data3)) foreach($data3 AS $h) { ?>
                                <a class="two_list_a" href="<?php echo $h['url'];?>"><?php echo $h['catname'];?></a>
                            <?php $n++;}unset($n); ?>
                            <?php if(defined('IN_ADMIN') && !defined('HTML')) {echo '</div>';}?>
                        </li>
                        <?php } else { ?>
                        <li class="two_list two_list_tz">
                            <a class="two_list_a two_list_a_ti" href="<?php if($v[catid]==53) { ?><?php echo $CATEGORYS['65']['url'];?><?php } elseif ($v[catid]==52) { ?><?php echo $CATEGORYS['67']['url'];?><?php } else { ?><?php echo $v['url'];?><?php } ?>"><?php echo $v['catname'];?></a>
                            <?php if(defined('IN_ADMIN')  && !defined('HTML')) {echo "<div class=\"admin_piao\" pc_action=\"content\" data=\"op=content&tag_md5=8e31438ac0ad2236cf68627387932923&action=category&catid=%24v%5Bcatid%5D&order=listorder+ASC&return=data3\"><a href=\"javascript:void(0)\" class=\"admin_piao_edit\">编辑</a>";}$content_tag = pc_base::load_app_class("content_tag", "content");if (method_exists($content_tag, 'category')) {$data3 = $content_tag->category(array('catid'=>$v[catid],'order'=>'listorder ASC','limit'=>'20',));}?>
                            <?php $n=1;if(is_array($data3)) foreach($data3 AS $h) { ?>
                                <a class="two_list_a" href="<?php echo $h['url'];?>"><?php echo $h['catname'];?></a>
                            <?php $n++;}unset($n); ?>
                            <?php if(defined('IN_ADMIN') && !defined('HTML')) {echo '</div>';}?>
                        </li>
                        <?php } ?>
                        <?php $n++;}unset($n); ?>
                        <?php if(defined('IN_ADMIN') && !defined('HTML')) {echo '</div>';}?>
                    </ul>
                </li>
                <?php $n++;}unset($n); ?>
                <?php if(defined('IN_ADMIN') && !defined('HTML')) {echo '</div>';}?>
            </ul>
            <div class="hamburger-box"><div class="hamburger-inner"></div></div>
        </div>
    </div>
    <?php if($catid == '' ) { ?>
    <?php if($CATEGORYS[41]['ismenu']) { ?>
    <div class="banner home_banner">
        <img class="gun" src="/statics/pc/image/gun.gif" alt="" srcset="">
        <div class="swiper-container swiper-container1">
            <div class="swiper-wrapper">
                    <?php if(defined('IN_ADMIN')  && !defined('HTML')) {echo "<div class=\"admin_piao\" pc_action=\"get\" data=\"op=get&tag_md5=ab3cc3a1556db2a7bba3252253de5ee8&sql=select+links%2Cthumb%2Ctitle%2Cfutitle+from+lt_picture+where+status%3D99+order+by+id+desc&num=3&return=infopage\"><a href=\"javascript:void(0)\" class=\"admin_piao_edit\">编辑</a>";}pc_base::load_sys_class("get_model", "model", 0);$get_db = new get_model();$r = $get_db->sql_query("select links,thumb,title,futitle from lt_picture where status=99 order by id desc LIMIT 3");while(($s = $get_db->fetch_next()) != false) {$a[] = $s;}$infopage = $a;unset($a);?>
                    <?php $n=1;if(is_array($infopage)) foreach($infopage AS $r) { ?>
                <div class="swiper-slide" style="background:url('<?php echo $r['thumb'];?>') no-repeat center;">
                    <div class="tips">
                        <div class="ani home-banner-slogan" swiper-animate-effect="fadeInUp" swiper-animate-duration="1.5s" swiper-animate-delay="0s" ><?php echo $r['title'];?></div>
                        <div class="ani home-banner-slogan" swiper-animate-effect="fadeInUp" swiper-animate-duration="1.5s" swiper-animate-delay="0.2s"><?php echo $r['futitle'];?></div>
                        <a class="ani btn btn-default" swiper-animate-effect="fadeInUp" swiper-animate-duration="1.5s" swiper-animate-delay="0.4s" href="<?php if($r[links]) { ?><?php echo $r['links'];?><?php } else { ?>javascript:;<?php } ?>"><span>我要合作</span></a>
                    </div>
                </div>
                <?php $n++;}unset($n); ?>
                <?php if(defined('IN_ADMIN') && !defined('HTML')) {echo '</div>';}?>
            </div>
            <div class="swiper-pagination swiper-pagination1"></div>
        </div>
    </div>
    <?php } ?>
    <?php } else { ?>
        <?php $lisoncatids=array(56,57,58,59,60,53,65,66,52,34);?>
        <?php if(in_array($catid,$lisoncatids)) { ?>
        <div class="banner">
        <?php } else { ?> 
        <div class="banner c_banner">
        <?php } ?>
            <div class="swiper-slide" style='background:url("<?php echo $CATEGORYS[$catid]['image'];?>") no-repeat center;'>
                <div class="tips tips1">
                    <div class="home-banner-slogan wow fadeInUp" data-wow-duration="1.5s" ><?php echo $CATEGORYS[$catid]['description'];?></div>
                    <div class="home-banner-slogan wow fadeInUp" data-wow-duration="1.5s" ><?php echo $CATEGORYS[$catid]['subtitle'];?></div>
                    <div class="home-banner-slogan wow fadeInUp" data-wow-duration="1.5s" ><?php echo $CATEGORYS[$catid]['descriptions'];?></div>
                </div>
            </div>
        </div>
    <?php } ?>
</header>


