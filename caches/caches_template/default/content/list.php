<?php defined('IN_PHPCMS') or exit('No permission resources.'); ?>
<?php include template("content","header"); ?>
<article>
    <nav class="art-nav">
        <a <?php if($catid =='65') { ?>class="hover"<?php } ?> href="<?php echo $CATEGORYS['65']['url'];?>"><span><?php echo $CATEGORYS['65']['catname'];?></span></a>
        <a <?php if($catid =='66') { ?>class="hover"<?php } ?> href="<?php echo $CATEGORYS['66']['url'];?>"><span><?php echo $CATEGORYS['66']['catname'];?></span></a>
    </nav>
    <section class="news-main">
        <h3 class="sec-title wow slideInUp"><?php echo $CATEGORYS[$catid]['catname'];?></h3>
        <div class="news-main-list">
            <?php if(defined('IN_ADMIN')  && !defined('HTML')) {echo "<div class=\"admin_piao\" pc_action=\"get\" data=\"op=get&tag_md5=bfc1d0c44019505e0565a29949ff8f5d&sql=select+url%2Cthumb%2Ctitle%2Cupdatetime%2Cdescription%2Cnewstype+from+lt_news+where+catid%3D%24catid+and+status%3D99+order+by+id+desc&num=6&return=infopage&page=%24page\"><a href=\"javascript:void(0)\" class=\"admin_piao_edit\">修改</a>";}pc_base::load_sys_class("get_model", "model", 0);$get_db = new get_model();$pagesize = 6;$page = intval($page) ? intval($page) : 1;if($page<=0){$page=1;}$offset = ($page - 1) * $pagesize;$r = $get_db->sql_query("SELECT COUNT(*) as count FROM (select url,thumb,title,updatetime,description,newstype from lt_news where catid=$catid and status=99 order by id desc) T");$s = $get_db->fetch_next();$pages=pages($s['count'], $page, $pagesize, $urlrule);$r = $get_db->sql_query("select url,thumb,title,updatetime,description,newstype from lt_news where catid=$catid and status=99 order by id desc LIMIT $offset,$pagesize");while(($s = $get_db->fetch_next()) != false) {$a[] = $s;}$infopage = $a;unset($a);?>
            <?php $n=1;if(is_array($infopage)) foreach($infopage AS $r) { ?>
            <a href="<?php echo $r['url'];?>" class="item item1 wow slideInUp">
                <div class="img"><img src="<?php echo $r['thumb'];?>" alt="<?php echo str_cut($r[title],'60','...');?>" srcset=""></div>
                <div class="txt">
                    <h3 class="news-ti"><?php echo $r['title'];?></h3>
                    <p class="news-ms"><span><?php echo $r['newstype'];?></span><?php echo date("Y-m-d",$r[updatetime]);?></p>
                    <p class="news-jj"><?php echo str_cut($r[description],'210','...');?></p>
                </div>
            </a>
            <?php $n++;}unset($n); ?>
            <?php if(defined('IN_ADMIN') && !defined('HTML')) {echo '</div>';}?>
            <div class="pages_02 pages_01_ul page">
                <div class="pages_01"><?php echo $pages;?></div>
            </div>
        </div>
    </section>
</article>     
<?php include template("content","footer"); ?>
