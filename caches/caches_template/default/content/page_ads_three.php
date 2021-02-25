<?php defined('IN_PHPCMS') or exit('No permission resources.'); ?><?php include template("content","header"); ?>
<article>
    <nav class="art-nav">
        <?php $n=1;if(is_array(subcat(44))) foreach(subcat(44) AS $m) { ?>
            <a <?php if($catid ==$m[catid]) { ?>class="hover"<?php } ?> href="<?php echo $m['url'];?>"><span><?php echo $m['catname'];?></span></a>
        <?php $n++;}unset($n); ?>
    </nav>
    <?php echo $content;?>
    <!-- 留言表单 -->
    <?php include template("content","messbook"); ?>
<?php include template("content","footer"); ?>