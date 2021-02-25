<?php defined('IN_PHPCMS') or exit('No permission resources.'); ?><footer id="footer">
    <div class="container">
        <div class="logo">
            <?php if(defined('IN_ADMIN')  && !defined('HTML')) {echo "<div class=\"admin_piao\" pc_action=\"block\" data=\"op=block&tag_md5=a3cea9198721a93e49d58fb78d2c2e3d&pos=downlogo\"><a href=\"javascript:void(0)\" class=\"admin_piao_edit\">添加碎片</a>";}$block_tag = pc_base::load_app_class('block_tag', 'block');echo $block_tag->pc_tag(array('pos'=>'downlogo',));?><?php if(defined('IN_ADMIN') && !defined('HTML')) {echo '</div>';}?>
            <?php if(defined('IN_ADMIN')  && !defined('HTML')) {echo "<div class=\"admin_piao\" pc_action=\"block\" data=\"op=block&tag_md5=6aee71218636386ce6d11d05ea982d38&pos=rphone\"><a href=\"javascript:void(0)\" class=\"admin_piao_edit\">添加碎片</a>";}$block_tag = pc_base::load_app_class('block_tag', 'block');echo $block_tag->pc_tag(array('pos'=>'rphone',));?><?php if(defined('IN_ADMIN') && !defined('HTML')) {echo '</div>';}?>
        </div>
        <div class="nav">
            <ul>
                <li><a href="/">首页</a></li>
            </ul>
            <?php if(defined('IN_ADMIN')  && !defined('HTML')) {echo "<div class=\"admin_piao\" pc_action=\"content\" data=\"op=content&tag_md5=a00bf54152c16cfc1df5a5507d4c5605&action=category&order=listorder+ASC&catid=0\"><a href=\"javascript:void(0)\" class=\"admin_piao_edit\">编辑</a>";}$content_tag = pc_base::load_app_class("content_tag", "content");if (method_exists($content_tag, 'category')) {$data = $content_tag->category(array('order'=>'listorder ASC','catid'=>'0','limit'=>'20',));}?>
            <?php $n=1; if(is_array($data)) foreach($data AS $k => $r) { ?>
            <ul>
                <li><a href="<?php if($r[catid]==39) { ?><?php echo $CATEGORYS['56']['url'];?><?php } elseif ($r[catid]==28) { ?><?php echo $CATEGORYS['45']['url'];?><?php } elseif ($r[catid]==30) { ?><?php echo $CATEGORYS['51']['url'];?><?php } else { ?><?php echo $r['url'];?><?php } ?>"><?php echo $r['catname'];?></a></li>
                <?php if(defined('IN_ADMIN')  && !defined('HTML')) {echo "<div class=\"admin_piao\" pc_action=\"content\" data=\"op=content&tag_md5=68b60a4e12dc4b01a36d06e138a7ecbf&action=category&catid=%24r%5Bcatid%5D&order=listorder+ASC&return=data2\"><a href=\"javascript:void(0)\" class=\"admin_piao_edit\">编辑</a>";}$content_tag = pc_base::load_app_class("content_tag", "content");if (method_exists($content_tag, 'category')) {$data2 = $content_tag->category(array('catid'=>$r[catid],'order'=>'listorder ASC','limit'=>'20',));}?>
                <?php $n=1; if(is_array($data2)) foreach($data2 AS $e => $v) { ?>
                    <li><a href="<?php if($v[catid]==43) { ?><?php echo $CATEGORYS['56']['url'];?><?php } elseif ($v[catid]==44) { ?><?php echo $CATEGORYS['58']['url'];?><?php } elseif ($v[catid]==53) { ?><?php echo $CATEGORYS['65']['url'];?><?php } else { ?><?php echo $v['url'];?><?php } ?>"><?php echo $v['catname'];?></a></li>
                <?php $n++;}unset($n); ?>
                <?php if(defined('IN_ADMIN') && !defined('HTML')) {echo '</div>';}?>
            </ul>
            <?php $n++;}unset($n); ?>
            <?php if(defined('IN_ADMIN') && !defined('HTML')) {echo '</div>';}?>
        </div>
        <div class="er"><?php if(defined('IN_ADMIN')  && !defined('HTML')) {echo "<div class=\"admin_piao\" pc_action=\"block\" data=\"op=block&tag_md5=7eff86a7ab4984591b2689d45250e103&pos=ercode\"><a href=\"javascript:void(0)\" class=\"admin_piao_edit\">添加碎片</a>";}$block_tag = pc_base::load_app_class('block_tag', 'block');echo $block_tag->pc_tag(array('pos'=>'ercode',));?><?php if(defined('IN_ADMIN') && !defined('HTML')) {echo '</div>';}?></div>
    </div>
    <p class="tips"><?php if(defined('IN_ADMIN')  && !defined('HTML')) {echo "<div class=\"admin_piao\" pc_action=\"block\" data=\"op=block&tag_md5=0f2545b3d0a448e13a98738a465512ab&pos=copyright\"><a href=\"javascript:void(0)\" class=\"admin_piao_edit\">添加碎片</a>";}$block_tag = pc_base::load_app_class('block_tag', 'block');echo $block_tag->pc_tag(array('pos'=>'copyright',));?><?php if(defined('IN_ADMIN') && !defined('HTML')) {echo '</div>';}?></p>
</footer>
<script src="https://cdn.bootcss.com/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdn.bootcss.com/wow/1.1.2/wow.min.js"></script>
<script src="https://cdn.bootcss.com/Swiper/4.5.0/js/swiper.min.js"></script>
<script src="/statics/pc/js/swiper.animate1.0.3.min.js"></script>
<script src="https://cdn.bootcss.com/jquery-nice-select/1.1.0/js/jquery.nice-select.min.js"></script>
<script src="/statics/pc/js/style.js"></script>
<script>
    var mySwiper = new Swiper('.swiper-container1', {
        loop : true,
        autoplay:true,
        pagination: {
            el: '.swiper-pagination1',
        },
        on:{
            init: function(){
                swiperAnimateCache(this); //隐藏动画元素 
                swiperAnimate(this); //初始化完成开始动画
            }, 
            slideChangeTransitionEnd: function(){ 
                swiperAnimate(this); //每个slide切换结束时也运行当前slide动画
            } 
        }
    })
    var swiper = new Swiper('.swiper-container-dt', {
        slidesPerView: 3,
        spaceBetween: 30,
        slidesPerGroup: 3,
        autoplay:true,
        loop: true,
        loopFillGroupWithBlank: true,
        pagination: {
            el: '.swiper-pagination-dt',
            clickable: true,
        }
    });
    $('select').niceSelect();
</script>
<script>
    function FromSubmit(){
        var username=document.getElementById("name").value,tel=document.getElementById("tel").value,email=document.getElementById("email").value,content=document.getElementById("content").value,qq=document.getElementById("qq").value,channel=document.getElementById("selectops").value,ziops=document.getElementById("ziops").value,utm_source  ="60",utm_term = "在线留言",urlesp=window.location.href;
        if (tel == "") {alert("请填写手机号码");return false;}
        if(!(/^1\d{10}$/.test(tel))){alert("不是完整的11位手机号或者正确的手机号!");return false;}
        var api = "/api.php?op=messbook&name=" + username + "&tel=" + tel+ "&email=" + email +"&qq=" +qq+ "&content=" + content+ "&channel=" + channel+ "&ziops=" + ziops + "&url=" + escape(urlesp) + "&utm_source=" + utm_source + "&utm_term=" + utm_term + "&prevurl="+ document.referrer;
        $.ajax({
            dataType: "json",
            url: api,
            success: function (data) {
                console.log(data,'aa');
                if (data.res == true) {
                    alert("留言成功！我们的客服经理将会尽快和您联系！");
                    $("input[type='text']").val("");
                    $("#content").val("");
                } else {
                    alert("留言不成功！请重新留言！");
                }
            }, error: function () {
                alert("服务器正忙,请稍后再试！")
            }
        });
    }
</script>
</body>
<?php if(defined('IN_ADMIN')  && !defined('HTML')) {echo "<div class=\"admin_piao\" pc_action=\"block\" data=\"op=block&tag_md5=0c84071d19892db78a03276be187b8f1&pos=pc_kf\"><a href=\"javascript:void(0)\" class=\"admin_piao_edit\">添加碎片</a>";}$block_tag = pc_base::load_app_class('block_tag', 'block');echo $block_tag->pc_tag(array('pos'=>'pc_kf',));?><?php if(defined('IN_ADMIN') && !defined('HTML')) {echo '</div>';}?>
<?php if(defined('IN_ADMIN')  && !defined('HTML')) {echo "<div class=\"admin_piao\" pc_action=\"block\" data=\"op=block&tag_md5=22620addb4828a15ba773b300e316409&pos=otherjs\"><a href=\"javascript:void(0)\" class=\"admin_piao_edit\">添加碎片</a>";}$block_tag = pc_base::load_app_class('block_tag', 'block');echo $block_tag->pc_tag(array('pos'=>'otherjs',));?><?php if(defined('IN_ADMIN') && !defined('HTML')) {echo '</div>';}?>
</html>
