<?php defined('IN_PHPCMS') or exit('No permission resources.'); ?><?php include template("content","header"); ?>
<article>
    <?php echo $content;?>
    <!-- 留言表单 -->
    <?php include template("content","messbook"); ?>
<?php include template("content","footer"); ?>