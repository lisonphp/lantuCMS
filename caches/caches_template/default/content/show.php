<?php defined('IN_PHPCMS') or exit('No permission resources.'); ?><?php include template("content","header"); ?>
<article>
    <section class="cases-content set-bg1">
        <div class="container">
            <div class="main">
                <div class="advantage-txt-hd">
                    <h1 class="advantage-txt-ti"><?php echo $title;?></h1>
                    <p class="advantage-txt-ms"><?php echo $newstype;?>|<?php echo $updatetime;?></p>
                </div>
                <div class="advantage-txt-ct">
                        <?php echo $content;?>
                    <div class="cases-fx">
                        <p>分享</p>
                        <div class="wx-wb">
                            <div class="ifx wx">
                                <div class="er">
                                    <div class="it">微信扫一扫：分享</div>
                                    <div class="code"></div>
                                    <div class="tips">微信里点“发现”，扫一下二维码便可将本文分享至朋友圈。</div>
                                </div>
                            </div>
                            <div class="ifx wb"></div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="page">
                <a class="ani btn btn-default" href="<?php echo $previous_page['url'];?>"><span><img src="/statics/pc/image/jt1.png" alt="" srcset=""><?php echo $previous_page['title'];?></span></a>
                <a class="ani btn btn-default" href="<?php echo $next_page['url'];?>"><span><?php echo $next_page['title'];?><img src="/statics/pc/image/jt2.png" alt="" srcset=""></span></a>
            </div>
        </div>
    </section>
</article>

<script language="JavaScript" src="<?php echo APP_PATH;?>api.php?op=count&id=<?php echo $id;?>&modelid=<?php echo $modelid;?>"></script>
<?php include template("content","footer"); ?>
<script src="/statics/pc/js/qrcode.min.js"></script>
<script>
    // $('.wx .code')
    var qrcode = new QRCode(document.querySelector('.wx .code'), {
        width : 400,//设置宽高
        height : 400
    });
    qrcode.makeCode(window.location.href);

    var ShareTip = function(){}    //分享到新浪微博
    ShareTip.prototype.sharetosina=function(title,url){
        var sharesinastring='http://v.t.sina.com.cn/share/share.php?title='+title+'&url='+url+'&content=utf-8&sourceUrl='+url;
        window.open(sharesinastring,'newwindow','height=400,width=400,top=100,left=100');
    }
    $('.ifx.wb').on('click', function () {
        var shareTitle = $('.advantage-txt-ti').text();
        var shareUrl = window.location.href;
        var share1 = new ShareTip();
        share1.sharetosina(shareTitle,shareUrl);
    })
</script>
