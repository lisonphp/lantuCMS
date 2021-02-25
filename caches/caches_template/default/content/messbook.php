<?php defined('IN_PHPCMS') or exit('No permission resources.'); ?><section class="message mesbj1">
    <div class="container">
        <h3 class="sec-title wow slideInUp">请留下您的联系方式，我们将马上与您联系</h3>
        <form class="message-form wow slideInUp">
            <div class="input-inline">
                <div class="msg-ipt msg-ipt1">
                    <input type="text" placeholder="公司名称" id="qq">
                    <label class="msg-icon"></label>
                </div>
                <div class="msg-ipt msg-ipt2">
                    <input type="text" placeholder="姓名"  id="name">
                    <label class="msg-icon"></label>
                </div>
            </div>
            <div class="input-inline">
                <div class="msg-ipt msg-ipt3">
                    <input type="text" placeholder="手机" id="tel">
                    <label class="msg-icon"></label>
                </div>
                <div class="msg-ipt msg-ipt4">
                    <input type="text" placeholder="邮件" id="email">
                    <label class="msg-icon"></label>
                </div>
            </div>
            <div class="input-inline">
                <div class="msg-ipt msg-ipt5">
                    <select placeholder="我是从以下渠道了解到昱晟科技的"  id="selectops">
                        <option value="" disabled="" selected="" style="display:none;">我是从以下渠道了解到昱晟科技的</option>  
                        <option value="搜索引擎">搜索引擎</option>
                        <option value="行业资讯">行业资讯</option>
                        <option value="展会活动">展会活动</option>
                        <option value="商务人员">商务人员</option>
                        <option value="朋友推荐">朋友推荐</option>
                        <option value="其它渠道">其它渠道</option>
                    </select>
                    <label class="msg-icon"></label>
                </div>
                <div class="msg-ipt msg-ipt6">
                    <input type="text" placeholder="咨询业务" id="ziops">
                    <label class="msg-icon"></label>
                </div>
            </div>
            <div class="msg-ipt msg-ipt7">
                <textarea placeholder="内容" id="content"></textarea>
                <label class="msg-icon"></label>
            </div>
        </form>
        <a class="ani btn btn-default wow slideInUp" href="javascript:FromSubmit();"><span>预约咨询</span></a>
    </div>
</section>