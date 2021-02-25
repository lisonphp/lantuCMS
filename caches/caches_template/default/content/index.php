<?php defined('IN_PHPCMS') or exit('No permission resources.'); ?><?php include template("content","header"); ?>
<article>
        <!-- 资源 -->
        <section class="resources">
            <div class="container">
                <?php if($CATEGORYS[48]['ismenu']) { ?>
                <?php if(defined('IN_ADMIN')  && !defined('HTML')) {echo "<div class=\"admin_piao\" pc_action=\"get\" data=\"op=get&tag_md5=8601fb70b3a5d43fbb644fcc6889b95b&sql=select+content+from+lt_page+where+catid%3D48&return=infopage\"><a href=\"javascript:void(0)\" class=\"admin_piao_edit\">编辑</a>";}pc_base::load_sys_class("get_model", "model", 0);$get_db = new get_model();$r = $get_db->sql_query("select content from lt_page where catid=48 LIMIT 20");while(($s = $get_db->fetch_next()) != false) {$a[] = $s;}$infopage = $a;unset($a);?>
                <?php $n=1;if(is_array($infopage)) foreach($infopage AS $r) { ?>
                <?php echo $r['content'];?>
                <?php $n++;}unset($n); ?>
                <?php if(defined('IN_ADMIN') && !defined('HTML')) {echo '</div>';}?>
                <?php } ?>
                <a class="ani btn btn-default wow fadeInUp" href="/contact/"><span>我要合作</span></a>
            </div>
        </section>
        <!-- 优势 -->
        <section class="advantage">
            <div class="container">
                <?php if($CATEGORYS[18]['ismenu']) { ?>
                <?php if(defined('IN_ADMIN')  && !defined('HTML')) {echo "<div class=\"admin_piao\" pc_action=\"get\" data=\"op=get&tag_md5=752cf7ac51ab70e502aada3e754e7f44&sql=select+content+from+lt_page+where+catid%3D18&return=infopage\"><a href=\"javascript:void(0)\" class=\"admin_piao_edit\">编辑</a>";}pc_base::load_sys_class("get_model", "model", 0);$get_db = new get_model();$r = $get_db->sql_query("select content from lt_page where catid=18 LIMIT 20");while(($s = $get_db->fetch_next()) != false) {$a[] = $s;}$infopage = $a;unset($a);?>
                <?php $n=1;if(is_array($infopage)) foreach($infopage AS $r) { ?>
                <?php echo $r['content'];?>
                <?php $n++;}unset($n); ?>
                <?php if(defined('IN_ADMIN') && !defined('HTML')) {echo '</div>';}?>
                <?php } ?>
            </div>
        </section>
        <!-- 案例 -->
        <section class="case">
            <div class="container">
                <?php if($CATEGORYS[36]['ismenu']) { ?>
                <?php if(defined('IN_ADMIN')  && !defined('HTML')) {echo "<div class=\"admin_piao\" pc_action=\"get\" data=\"op=get&tag_md5=5bbd82e1160a967f6f4ed4d69be58c3b&sql=select+content+from+lt_page+where+catid%3D36&return=infopage\"><a href=\"javascript:void(0)\" class=\"admin_piao_edit\">编辑</a>";}pc_base::load_sys_class("get_model", "model", 0);$get_db = new get_model();$r = $get_db->sql_query("select content from lt_page where catid=36 LIMIT 20");while(($s = $get_db->fetch_next()) != false) {$a[] = $s;}$infopage = $a;unset($a);?>
                <?php $n=1;if(is_array($infopage)) foreach($infopage AS $r) { ?>
                <?php echo $r['content'];?>
                <?php $n++;}unset($n); ?>
                <?php if(defined('IN_ADMIN') && !defined('HTML')) {echo '</div>';}?>
                <?php } ?>
            </div>
        </section>
        <!-- 动态 -->
        <section class="dynamic">
            <div class="container">
                <h3 class="sec-title wow fadeInUp">最新动态</h3>
                <div class="ys-list wow fadeInUp">
                    <div class="swiper-container swiper-container-dt">
                        <div class="swiper-wrapper">
                            <?php if(defined('IN_ADMIN')  && !defined('HTML')) {echo "<div class=\"admin_piao\" pc_action=\"get\" data=\"op=get&tag_md5=70ab609eff1d4a4ba91bc01f67f9c1b5&sql=select+url%2Cthumb%2Ctitle+from+lt_news+where+status%3D99+order+by+id+desc&num=9&return=infopage&page=%24page\"><a href=\"javascript:void(0)\" class=\"admin_piao_edit\">编辑</a>";}pc_base::load_sys_class("get_model", "model", 0);$get_db = new get_model();$pagesize = 9;$page = intval($page) ? intval($page) : 1;if($page<=0){$page=1;}$offset = ($page - 1) * $pagesize;$r = $get_db->sql_query("SELECT COUNT(*) as count FROM (select url,thumb,title from lt_news where status=99 order by id desc) T");$s = $get_db->fetch_next();$pages=pages($s['count'], $page, $pagesize, $urlrule);$r = $get_db->sql_query("select url,thumb,title from lt_news where status=99 order by id desc LIMIT $offset,$pagesize");while(($s = $get_db->fetch_next()) != false) {$a[] = $s;}$infopage = $a;unset($a);?>
                            <?php $n=1;if(is_array($infopage)) foreach($infopage AS $r) { ?>
                            <div class="swiper-slide">
                                <a class="ys-list-it" href="<?php echo $r['url'];?>">
                                    <div class="advantage-img"><img src="<?php echo $r['thumb'];?>" alt="<?php echo str_cut($r[title],'60','...');?>" srcset=""></div>
                                    <div class="advantage-txt"><?php echo str_cut($r[title],'50','...');?></div>
                                </a>
                            </div>
                            <?php $n++;}unset($n); ?>
                            <?php if(defined('IN_ADMIN') && !defined('HTML')) {echo '</div>';}?>
                        </div>
                    </div>
                    <div class="swiper-pagination swiper-pagination-dt"></div>
                    <a class="ani btn btn-default" swiper-animate-effect="fadeInUp" swiper-animate-duration="1.5s" swiper-animate-delay="0.4s" href="<?php echo $CATEGORYS['65']['url'];?>"><span>更多动态</span></a>
                </div>
            </div>
        </section>
        <!-- 焦点图 -->
        <section class="focus-map" style="background: url(/statics/pc/image/jdt-bg.jpg) no-repeat center;">
            <div class="focus-bx">
                <p>开启合作  精准获客</p>
            </div>
        </section>
        <!-- 留言表单 -->
        <?php include template("content","messbook"); ?>
    </article>

<?php include template("content","footer"); ?>