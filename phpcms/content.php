<?php
set_time_limit(300);
defined('IN_PHPCMS') or exit('No permission resources.');
//模型缓存路径
define('CACHE_MODEL_PATH', CACHE_PATH . 'caches_model' . DIRECTORY_SEPARATOR . 'caches_data' . DIRECTORY_SEPARATOR);
//定义在单独操作内容的时候，同时更新相关栏目页面
define('RELATION_HTML', true);

pc_base::load_app_class('admin', 'admin', 0);
pc_base::load_sys_class('form', '', 0);
pc_base::load_app_func('util');
pc_base::load_sys_class('format', '', 0);

class content extends admin
{
    private $db, $priv_db;
    public $siteid, $categorys, $categoryss;

    public function __construct()
    {
        parent::__construct();
        $this->db = pc_base::load_model('content_model');
        $this->dbte = pc_base::load_model('aself_model');
        $this->siteid = $this->get_siteid();
        // $this->categorys = getcache('category_content_'.$this->siteid,'commons');
        $this->dbte->selftb("v9_category");
        $cateres = $this->dbte->select("`ismenu`=1 and `catid` < 1700 or `catid` > 6155", '*', 12000);
        foreach ($cateres as $r) {
            $this->categorys[$r['catid']] = $r;
        }
        //权限判断
        if (isset($_GET['catid']) && $_SESSION['roleid'] != 1 && ROUTE_A != 'pass' && strpos(ROUTE_A, 'public_') === false) {
            $catid = intval($_GET['catid']);
            $this->priv_db = pc_base::load_model('category_priv_model');
            $action = $this->categorys[$catid]['type'] == 0 ? ROUTE_A : 'init';
            $priv_datas = $this->priv_db->get_one(array('catid' => $catid, 'is_admin' => 1, 'action' => $action));
            if (!$priv_datas) showmessage(L('permission_to_operate'), 'blank');
        }
        //lison
        $userseid = $_SESSION['userid_kk'] ? $_SESSION['userid_kk'] : $_SESSION['userid'];//$_SESSION['userid']为系统后台登录的ID
        // echo $_SESSION['userid'];exit;
        $admin_db = pc_base::load_model('admin_model');
        $this->userinfo = $admin_db->get_one(array('userid' => $userseid));
        $this->url = pc_base::load_app_class('url', 'content');
        //$this->urlrules = getcache('urlrules','commons');
    }

    public function iscategory()
    {//ajax验证该品牌项目是否已存在
        $catess = pc_base::load_model('aself_model');
        if (isset($_POST['param'])) {
            $param = trim($_POST['param']);
            $catess->selftb("v9_category");
            $res = $catess->get_one(array('catname' => $param), "catname");
            if ($res) {
                echo '该品牌项目已存在！';
            } else {
                $sta = array('status' => 'y');
                echo json_encode($sta);
            }
        } else {
            showmessage('该品牌项目已存在！', $GLOBALS['referer'], 900);
        }
    }


    public function public_addpingpai()
    {
        include $this->admin_tpl('content_addpingpai');
    }


    public function public_listpingpai()
    {//品牌项目管理
        $cass = $this->categorys;
        $this->cate = pc_base::load_model('category_model');
        $page = isset($_GET['page']) && trim($_GET['page']) ? intval($_GET['page']) : 1;
        $dataw = $this->cate->listinfo("type=0 and modelid=1 and child=1 and parentid >12 and ismenu=1", 'catid DESC', $page, 50);
        $pages = $this->cate->pages;
        include $this->admin_tpl('content_listpingpai');
    }


    /**
     *下载资料的方法集合
     */
    public function public_watchZiliao()
    {
        $cass = $this->categorys;
        $this->dbte->selftb("v9_sources");
        $page = isset($_GET['page']) && trim($_GET['page']) ? intval($_GET['page']) : 1;
        $dataw = $this->dbte->listinfo("", 'id DESC', $page, 50);
        $pages = $this->cate->pages;
        $this->dbte->selftb("v9_admin");
        foreach ($dataw as $k => $v) {
            $userid = $v['userid'];
            $res = $this->dbte->select(array('userid' => $userid), 'username');
            $dataw[$k]['userid'] = $res[0]['username'];
        }
        $this->dbte->selftb("v9_sources_type");
        foreach ($dataw as $key => $value) {
            $type = $value['type'];
            $res = $this->dbte->select(array('tid' => $type), 'type_name');
            $dataw[$key]['type'] = $res[0]['type_name'];
        }
        include $this->admin_tpl('content_listziliao');
    }

    public function uploadziliao()
    {
        $this->dbte->selftb("v9_sources_type");
        $data = $this->dbte->select();
        include $this->admin_tpl('content_uploadziliao');
    }

    public function uploadziliao_add()
    {
        pc_base::load_sys_class('attachment', '', 0);    //加载类
        pc_base::load_app_func('global', 'attachment'); //加载函数库
        $siteid = $this->get_siteid();
        $site_setting = get_site_setting($siteid);
        $site_allowext = "doc|docx|txt|pdf";
        $attachment = new attachment($module, $catid, $siteid);
        $attachment->set_userid($this->userid);
        $max_size = ini_get('upload_max_filesize');
        $max_size = intval($max_size) * 1024;
        if (($_FILES['file']['size'] / 1000) > $max_size) {
            showmessage(L('上传文件过大，请认真核对文件不大小不能超过' . $max_size, '', 'attachment'));
        }
        $a = $attachment->upload('file', $site_allowext);
        $upload_root = pc_base::load_config('system', 'upload_path');  //载入配置
        if ($a) {
            $filepath = $attachment->uploadedfiles[0]['filepath'];
            $inputFileName = $upload_root . $filepath;//上传文件
            if ($inputFileName == null) showmessage(L('没有获取到上传文件名', '', 'attachment'));
            $data['title'] = $_POST['title'];
            $data['type'] = $_POST['type'];
            $data['url'] = $inputFileName;
            $data['addtime'] = time();
            $data['size'] = $_FILES['file']['size'] / 1000;
            $data['format'] = substr($filepath, strpos($filepath, '.'));
            $data['updatetime'] = time();
            $data['userid'] = $_SESSION['userid'];
            $data['downurl'] = '/uploadfile/' . $filepath;
            $this->dbte->selftb("v9_sources");
            $res = $this->dbte->insert($data);
            if ($res) {
                showmessage(L('add_success'), HTTP_REFERER);
            } else {
                showmessage(L('上传文件格式错误，请认真核对格式必须为doc|docx|txt|pdf'), HTTP_REFERER);
            }
        } else {
            showmessage(L('上传文件格式错误，请认真核对格式必须为doc|docx|txt|pdf', '', 'attachment'));
        }
    }

    public function ziliaodelete()
    {
        $this->dbte->selftb("v9_sources");
        $ids = $_POST['ids'];
        if ($ids) {
            foreach ($ids as $key => $r) {
                $info = $this->dbte->get_one(array('id' => $r));
                if ($info) {
                    @unlink($info['url']);
                    $res = $this->dbte->delete("`id`=$r");
                    if ($res) {
                        $isa = 2;
                    } else {
                        $isa = 1;
                    }
                }
            }
        } else {
            showmessage("未选择！", HTTP_REFERER, 1000);
        }
        if ($isa == 2) {
            $pc_hash = $_GET['pc_hash'];
            showmessage("删除成功！", "?m=content&c=content&a=public_watchZiliao&pc_hash=$pc_hash", 1000);
        } else {
            showmessage("删除失败！", HTTP_REFERER, 1000);
        }
    }

    /**
     * 品牌资讯查看
     *
     */
    public function public_watchBrand()
    {

        $cass = $this->categorys;

        $this->cate = pc_base::load_model('category_model');
        $page = isset($_GET['page']) && trim($_GET['page']) ? intval($_GET['page']) : 1;
        $dataw = $this->cate->listinfo("type=0 and modelid=12 and child=0 and catname='品牌资讯' and ismenu=1", 'catid DESC', $page, 50);
        $pages = $this->cate->pages;
        include $this->admin_tpl('content_listzixun');
    }

    public function pingpaidelete()
    {//品牌项目删除
        $this->cate = pc_base::load_model('category_model');
        $this->page = pc_base::load_model('page_model');
        $this->log = pc_base::load_model('log_model');
        $data['module'] = 'content';
        $data['action'] = 'content';
        $data['userid'] = $_SESSION['userid'];
        $data['username'] = 'ttadmin';
        $data['ip'] = ip();
        $data['time'] = date('Y-m-d H:i:s', time());
        $ids = $_POST['ids'];
        if ($ids) {
            foreach ($ids as $key => $r) {
                $info = $this->cate->get_one(array('catid' => $r));
                $arrchildid = $info['arrchildid'];
                if ($info) {
                    $res = $this->cate->delete("catid in($arrchildid)");
                    $data['querystring'] = '?m=content&c=content&a=pingpaidelete&catid=' . $r;
                    $addres = $this->log->insert($data);
                    if ($res) {
                        $res2 = $this->page->delete("catid in($arrchildid)");
                        if ($res2) {
                            $isa = 2;

                        } else {
                            $isa = 3;
                        }
                    } else {
                        $isa = 1;
                    }
                }
            }
        } else {
            showmessage("未选择！", HTTP_REFERER, 1000);
        }
        if ($isa == 1) {
            showmessage("删除category失败！", HTTP_REFERER, 1000);
        } elseif ($isa == 2) {
            $pc_hash = $_GET['pc_hash'];
            showmessage("删除成功！", "?m=content&c=create_html_lison&a=update_catid&menuid=43&module=admin&pc_hash=$pc_hash", 1000);
        } else {
            showmessage("删除page失败！", HTTP_REFERER, 1000);
        }
    }

    public function ajax_menu()
    {//个人中心 所属栏目
        if ($_POST['aid']) {
            $aid = $_POST['aid'];
            $this->cate = pc_base::load_model('category_model');
            $res = $this->cate->select(array('parentid' => $aid), 'catid,catname');
            $aa = json_encode($res);
            echo $aa;
        }
    }

    public function isarr()
    {//判断品牌项目表与单页表的关系
        $username = $this->userinfo;
        $username = $username['username'];
        $this->cate = pc_base::load_model('category_model');
        $this->page = pc_base::load_model('page_model');
        $todaydate = date("Ymd");//20161216
        //获取该用户最后一条记录
        $seinfo = $this->cate->get_one(array('child' => 1, 'username' => $username), '*', 'catid desc');//条件，数据
        if ($seinfo) {
            if ($seinfo['todaydate'] == $todaydate) {
                $arrch = explode(",", $seinfo['arrchildid']);
                $page_catid = $this->page->select(array('username' => $username, 'todaydate' => $todaydate), 'catid');//条件，数据
                $arrhaibao = $arrch[2];//招商海报
                $arrjianjie = $arrch[3];//项目简介
                $arrzhengce = $arrch[4];//加盟政策
                foreach ($page_catid as $value) {
                    $arrpage[] = $value['catid'];
                }
                if (in_array($arrhaibao, $arrpage) && in_array($arrjianjie, $arrpage) && in_array($arrzhengce, $arrpage)) {
                    $isupdate = 'quanxin';
                    return $isupdate;//可以全新提交表单
                } else {
                    $isupdate = 'xiugai';
                    return $isupdate;//可以全新提交表单
                }
            } else {//第二种情况 之前填写的内容信息未完善且保存了部分信息
                $arrch = explode(",", $seinfo['arrchildid']);
                $page_catid = $this->page->select(array('username' => $username), 'catid');//条件，数据
                $arrhaibao = $arrch[2];//招商海报
                $arrjianjie = $arrch[3];//项目简介
                $arrzhengce = $arrch[4];//加盟政策
                foreach ($page_catid as $value) {
                    $arrpage[] = $value['catid'];
                }
                if (in_array($arrhaibao, $arrpage) && in_array($arrjianjie, $arrpage) && in_array($arrzhengce, $arrpage)) {
                    $isupdate = 'quanxin';
                    return $isupdate;//可以全新提交表单
                } else {
                    $isupdate = 'weiwanchang';
                    return $isupdate;//要保存上次的未完善的信息
                }
            }
        } else {//用户首次进行提交项目信息
            $isupdate = 'quanxin';
            return $isupdate;//可以全新提交表单
        }
    }

    public function infoget()
    {
        /*
         * Array
        (
            [xiangmuimg] => data:image/png;base64,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
            [xiangmuname] => 测试的啊
            [touzijinhe] => 2
            [moneyNum] => 7
            [moneyNums] => 14
            [date] => 2012
            [dates] => 03
            [mendianshuliang] => 22
            [jiamengqiuyu] => 中国
            [shiherenqun] => 大众
            [pinpaifayuandi] => 中国
            [jiamengfeiyong] => 5万
            [jingyingfanwei] => 全国
            [xinji] => 3
            [cixiangmu] => 99%
            [renguanzhu] => 563
            [companylogoimg] => data:image/png;base64,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
            [gongsimingcheng] => 测试的啊
            [companys] => 测试的啊
            [editor1] => \"\"
            [editor2] => aaaaaaaaaa
            [editor3] => sssssssssssssssss
        )
         * */

		$username = $this->userinfo;
        $username = $username['username'] ? $username['username'] : 'ttadmin';
        $this->url = pc_base::load_app_class('url');
        $this->page_db = pc_base::load_model('page_model');
        $this->cate = pc_base::load_model('category_model');
        $this->page = pc_base::load_model('page_model');
        $todaydate = date("Ymd");//20161216
        $urlpath = APP_PATH;
        $len = strlen($urlpath) - 1;
        if ($urlpath{$len} == '/') {
            $apppath = substr($urlpath, 0, -1);
        } else {
            $apppath = $urlpath;
        }

        $moneyNum = $_POST['moneyNum'];//例如 catid为7
        $moneyNums = $_POST['moneyNums'];//例如 catid为14
        $catname = $_POST['xiangmuname'];
        $touzijinhe = $_POST['touzijinhe'];
        $changlishijian = $_POST['date'] . '-' . $_POST['dates'];
        $mendianshuliang = $_POST['mendianshuliang'];
        $gongsimingcheng = $_POST['gongsimingcheng'];
        $jiamengqiuyu = $_POST['jiamengqiuyu'];
        $shiherenqun = $_POST['shiherenqun'];
        $pinpaifayuandi = $_POST['pinpaifayuandi'];
        $jiamengfeiyong = $_POST['jiamengfeiyong'];
        $jingyingfanwei = $_POST['jingyingfanwei'];
        $companys = $_POST['companys'];
        $xinji = $_POST['xinji'];
        $cixiangmu = $_POST['cixiangmu'];
        $renguanzhu = $_POST['renguanzhu'];
        $companylogo = $_POST['companylogoimg'];
        $xiangmuimg = $_POST['xiangmuimg'];
        if (empty($catname)) {
            showmessage('"' . 项目名称 . '"' . "不能为空！", $GLOBALS['referer']);
        } elseif (empty($touzijinhe)) {
            showmessage('"' . 投资金额 . '"' . "不能为空！", $GLOBALS['referer']);
        } elseif (empty($moneyNum) || empty($moneyNums)) {
            showmessage('"' . 所属栏目 . '"' . "不能为空！", $GLOBALS['referer']);
        } elseif (empty($changlishijian)) {
            showmessage('"' . 成立时间 . '"' . "不能为空！", $GLOBALS['referer']);
        } elseif (empty($jiamengqiuyu)) {
            showmessage('"' . 加盟区域 . '"' . "不能为空！", $GLOBALS['referer']);
        } elseif (empty($pinpaifayuandi)) {
            showmessage('"' . 品牌发源地 . '"' . "不能为空！", $GLOBALS['referer']);
        } elseif (empty($jingyingfanwei)) {
            showmessage('"' . 经营范围 . '"' . "不能为空！", $GLOBALS['referer']);
        } elseif (empty($mendianshuliang)) {
            showmessage('"' . 门店总数 . '"' . "不能为空！", $GLOBALS['referer']);
        } elseif (empty($shiherenqun)) {
            showmessage('"' . 加盟适合人群 . '"' . "不能为空！", $GLOBALS['referer']);
        } elseif (empty($jiamengfeiyong)) {
            showmessage('"' . 加盟费用 . '"' . "不能为空！", $GLOBALS['referer']);
        } elseif (empty($gongsimingcheng)) {
            showmessage('"' . 公司名称 . '"' . "不能为空！", $GLOBALS['referer']);
        } elseif (empty($companys)) {
            showmessage('"' . 公司简介 . '"' . "不能为空！", $GLOBALS['referer']);
        }
        $savepath = './uploadfile/user/image/' . date("Ymd");
        $saveurl = '/uploadfile/user/image/' . date("Ymd");
        if (!is_dir($savepath)) {
            @mkdir($savepath, 0777);
        }
        $datepath1 = date('YmdHis') . '_' . rand(10000, 99999);
        $datepath2 = date('YmdHis') . '_' . rand(10000, 99999);
        
        $base = explode(',', $companylogo);
        $ext = explode("/", $base[0]);
        $exta = explode(";", $ext[1]);
        $img = base64_decode($base[1]);
        $arrimg = array("jpg", "jpeg", "gif", "png");
        if (!in_array($exta[0], $arrimg)) {
            // showmessage('上传图片必须是“jpg或jpeg或gif或png”的格式！',$GLOBALS['referer']);
            $n = array('info' => "上传图片必须是“jpg或jpeg或gif或png”的格式！", 'status' => 'n');
            echo json_encode($n);
            exit;
        }
        if ($img) {//公司logo
            $thumbput = $savepath . '/' . $datepath1 . '.' . $exta[0];
            file_put_contents($thumbput, $img);
            $img_size = ceil(filesize($thumbput) / 1000);
            $imgdelete = PHPCMS_PATH . str_replace("./", "", $thumbput);
            if ($img_size > 1024) {
                @unlink($imgdelete);
                $n = array('info' => "公司logo图片大小不能大于1M", 'status' => 'n');
                echo json_encode($n);
                exit;
            }
            $thumbsave = $apppath . $saveurl . '/' . $datepath1 . '.' . $exta[0];
        } else {
            $n = array('info' => "请上传公司logo图片！", 'status' => 'n');
            echo json_encode($n);
            exit;
        }
        //产品图
        $base2 = explode(',', $xiangmuimg);
        $ext2 = explode("/", $base2[0]);
        $exta2 = explode(";", $ext2[1]);
        $img2 = base64_decode($base2[1]);
        if (!in_array($exta2[0], $arrimg)) {
            $n = array('info' => "上传图片必须是“jpg或jpeg或gif或png”的格式！", 'status' => 'n');
            echo json_encode($n);
            exit;
        }
        if ($img2) {
            $thumbput2 = $savepath . '/' . $datepath2 . '.' . $exta2[0];
            file_put_contents($thumbput2, $img2);
            $img_size = ceil(filesize($thumbput2) / 1000);
            $imgdelete = PHPCMS_PATH . str_replace("./", "", $thumbput2);
            if ($img_size > 1024) {
                @unlink($imgdelete);
                $n = array('info' => "产品图大小不能大于1M", 'status' => 'n');
                echo json_encode($n);
                exit;
            }
            $thumbsave2 = $apppath . $saveurl . '/' . $datepath2 . '.' . $exta2[0];
        } else {
            $n = array('info' => "请上传产品图图片！", 'status' => 'n');
            echo json_encode($n);
            exit;
        }
        
        $setting = '{"workflowid":"","ishtml":"1","content_ishtml":"0","create_to_html_root":"1","template_list":"default","category_template":"category_location","list_template":"list","show_template":"show","meta_title":"","meta_keywords":"","meta_description":"","presentpoint":"1","defaultchargepoint":"0","paytype":"0","repeatchargedays":"1","category_ruleid":"30","show_ruleid":"18"}';
        $setting1 = '{"ishtml":"1","template_list":"","meta_title":"","meta_keywords":"","meta_description":"","category_ruleid":"30","show_ruleid":"","repeatchargedays":"1"}';
        $setting2 = '{"workflowid":"","ishtml":"0","content_ishtml":"0","create_to_html_root":"1","template_list":"default","category_template":"category","list_template":"list","show_template":"show","meta_title":"","meta_keywords":"","meta_description":"","presentpoint":"1","defaultchargepoint":"0","paytype":"0","repeatchargedays":"1","category_ruleid":"30","show_ruleid":"18"}';
        $setting3 = '{"ishtml":"0","template_list":"","meta_title":"","meta_keywords":"","meta_description":"","category_ruleid":"30","show_ruleid":"","repeatchargedays":"1"}';
        $arrparentid = "0,6,$moneyNum,$moneyNums";
        
        $parentdir = $username;
        $resid = $this->cate->insert(array('siteid' => 1, 'module' => 'content', 'type' => 0, 'modelid' => 1, 'parentid' => $moneyNums, 'arrparentid' => $arrparentid, 'child' => 1, 'catname' => $catname, 'image' => $thumbsave2, 'touzijinhe' => $touzijinhe, 'cixiangmu' => $cixiangmu, 'xinji' => $xinji, 'renguanzhu' => $renguanzhu, 'gongsimingcheng' => $gongsimingcheng, 'changlishijian' => $changlishijian, 'jiamengqiuyu' => $jiamengqiuyu, 'pinpaifayuandi' => $pinpaifayuandi, 'jiamengfeiyong' => $jiamengfeiyong, 'shiherenqun' => $shiherenqun, 'mendianshuliang' => $mendianshuliang, 'gongsimingcheng' => $gongsimingcheng, 'jingyingfanwei' => $jingyingfanwei, 'companys' => $companys, 'companylogo' => $thumbsave, 'parentdir' => $parentdir, 'catdir' => '', 'url' => '', 'items' => 1, 'hits' => 0, 'letter' => 'letter', 'setting' => $setting, 'listorder' => '777', 'sehit' => 1, 'ismenu' => 1, 'timechuo' => SYS_TIME, 'sethtml' => 0, 'todaydate' => $todaydate, 'username' => $username), true);
        
        $str_l = '/xm/';
        $str_l2 = '/list-';
        $str_r = '/';
        $str_r2 = '-1.html';
        if ($resid) {
            $res = $this->cate->update(array('arrchildid' => $resid, 'url' => $str_l . $resid . $str_r, 'listorder' => $resid, 'catdir' => $resid), array('catid' => $resid));//数据 ，条件
        }
        $arrparentid = "0,6,$moneyNum,$moneyNums,$resid";
        if ($res) {//项目首页
            $res1 = $this->cate->insert(array('siteid' => 1, 'module' => 'content', 'type' => 1, 'modelid' => 0, 'parentid' => $resid, 'arrparentid' => $arrparentid, 'child' => 0, 'catname' => '项目首页', 'parentdir' => $parentdir, 'catdir' => $catdir, 'url' => 'url', 'items' => 1, 'hits' => 0, 'letter' => 'letter', 'setting' => $setting3, 'listorder' => '777', 'sehit' => 1, 'ismenu' => 1, 'timechuo' => SYS_TIME, 'sethtml' => 0, 'todaydate' => $todaydate, 'username' => $username), true);
        }
        if ($res1) {//招商海报
            $up1 = $this->cate->update(array('arrchildid' => $res1, 'url' => $str_l2 . $res1 . $str_r2, 'listorder' => $res1, 'catdir' => $res1), array('catid' => $res1));
            $this->page->insert(array('catid' => $res1, 'title' => '项目首页', 'keywords' => '项目首页', 'updatetime' => SYS_TIME, 'username' => $username, 'todaydate' => $todaydate));
            if ($up1) {
                $res2 = $this->cate->insert(array('siteid' => 1, 'module' => 'content', 'type' => 1, 'modelid' => 0, 'parentid' => $resid, 'arrparentid' => $arrparentid, 'child' => 0, 'catname' => '招商海报', 'parentdir' => $parentdir, 'catdir' => $catdir, 'url' => 'url', 'items' => 1, 'hits' => 0, 'letter' => 'letter', 'setting' => $setting1, 'listorder' => '777', 'sehit' => 1, 'ismenu' => 1, 'timechuo' => SYS_TIME, 'sethtml' => 0, 'todaydate' => $todaydate, 'username' => $username), true);
            }
        }
        if ($res2) {//项目简介
            $up2 = $this->cate->update(array('arrchildid' => $res2, 'url' => $str_l . $res2 . $str_r, 'listorder' => $res2, 'catdir' => $res2), array('catid' => $res2));
            if ($up2) {
                $res3 = $this->cate->insert(array('siteid' => 1, 'module' => 'content', 'type' => 1, 'modelid' => 0, 'parentid' => $resid, 'arrparentid' => $arrparentid, 'child' => 0, 'catname' => '项目简介', 'parentdir' => $parentdir, 'catdir' => $catdir, 'url' => '', 'items' => 1, 'hits' => 0, 'letter' => 'letter', 'setting' => $setting1, 'listorder' => '777', 'sehit' => 1, 'ismenu' => 1, 'timechuo' => SYS_TIME, 'sethtml' => 0, 'todaydate' => $todaydate, 'username' => $username), true);
            }
        }
        if ($res3) {//加盟政策
            $up3 = $this->cate->update(array('arrchildid' => $res3, 'url' => $str_l . $res3 . $str_r, 'listorder' => $res3, 'catdir' => $res3), array('catid' => $res3));
            if ($up3) {
                $res4 = $this->cate->insert(array('siteid' => 1, 'module' => 'content', 'type' => 1, 'modelid' => 0, 'parentid' => $resid, 'arrparentid' => $arrparentid, 'child' => 0, 'catname' => '加盟政策', 'parentdir' => $parentdir, 'catdir' => $catdir, 'url' => '', 'items' => 1, 'hits' => 0, 'letter' => 'letter', 'setting' => $setting1, 'listorder' => '777', 'sehit' => 1, 'ismenu' => 1, 'timechuo' => SYS_TIME, 'sethtml' => 0, 'todaydate' => $todaydate, 'username' => $username), true);
            }
        }
        if ($res4) {//品牌资讯
            $up4 = $this->cate->update(array('arrchildid' => $res4, 'url' => $str_l . $res4 . $str_r, 'listorder' => $res4, 'catdir' => $res4), array('catid' => $res4));
            if ($up4) {
                $res5 = $this->cate->insert(array('siteid' => 1, 'module' => 'content', 'type' => 0, 'modelid' => 12, 'parentid' => $resid, 'arrparentid' => $arrparentid, 'child' => 0, 'catname' => '品牌资讯', 'parentdir' => $parentdir, 'catdir' => $catdir, 'url' => '', 'items' => 1, 'hits' => 0, 'letter' => 'letter', 'setting' => $setting2, 'listorder' => '777', 'sehit' => 1, 'ismenu' => 1, 'timechuo' => SYS_TIME, 'sethtml' => 0, 'todaydate' => $todaydate, 'username' => $username), true);
            }
        }
        if ($res5) {//网友点评
            $up5 = $this->cate->update(array('arrchildid' => $res5, 'url' => $str_l2 . $res5 . $str_r2, 'listorder' => $res5, 'catdir' => $res5), array('catid' => $res5));
            if ($up5) {
                $res6 = $this->cate->insert(array('siteid' => 1, 'module' => 'content', 'type' => 1, 'modelid' => 0, 'parentid' => $resid, 'arrparentid' => $arrparentid, 'child' => 0, 'catname' => '网友点评', 'parentdir' => $parentdir, 'catdir' => $catdir, 'url' => '', 'items' => 1, 'hits' => 0, 'letter' => 'letter', 'setting' => $setting3, 'listorder' => '777', 'sehit' => 1, 'ismenu' => 1, 'timechuo' => SYS_TIME, 'sethtml' => 0, 'todaydate' => $todaydate, 'username' => $username), true);
            }
        }
        if ($res6) {//品牌问答
            $up6 = $this->cate->update(array('arrchildid' => $res6, 'url' => $str_l2 . $res6 . $str_r2, 'listorder' => $res6, 'catdir' => $res6), array('catid' => $res6));
            $this->page->insert(array('catid' => $res6, 'title' => '网友点评', 'keywords' => '网友点评', 'updatetime' => SYS_TIME, 'username' => $username, 'todaydate' => $todaydate));
            if ($up6) {
                $res7 = $this->cate->insert(array('siteid' => 1, 'module' => 'content', 'type' => 1, 'modelid' => 0, 'parentid' => $resid, 'arrparentid' => $arrparentid, 'child' => 0, 'catname' => '品牌问答', 'parentdir' => $parentdir, 'catdir' => $catdir, 'url' => 'url', 'items' => 1, 'hits' => 0, 'letter' => 'letter', 'setting' => $setting3, 'listorder' => '777', 'sehit' => 1, 'ismenu' => 1, 'timechuo' => SYS_TIME, 'sethtml' => 0, 'todaydate' => $todaydate, 'username' => $username), true);
            }
        }
        if ($res7) {
            $arrchildid = $resid . ',' . $res1 . ',' . $res2 . ',' . $res3 . ',' . $res4 . ',' . $res5 . ',' . $res6 . ',' . $res7;
            $this->cate->update(array('arrchildid' => $arrchildid), array('catid' => $resid));//数据 ，条件
            $this->page->insert(array('catid' => $res7, 'title' => '品牌问答', 'keywords' => '品牌问答', 'updatetime' => SYS_TIME, 'username' => $username, 'todaydate' => $todaydate));
            $res8 = $this->cate->update(array('arrchildid' => $res7, 'url' => $str_l2 . $res7 . $str_r2, 'listorder' => $res7, 'catdir' => $res7), array('catid' => $res7));
        }
        if ($res8) {
			//go on
			$editor1 = stripslashes(urldecode($_POST['editor1']));
			$editor2 = stripslashes(urldecode($_POST['editor2']));
			$editor3 = stripslashes(urldecode($_POST['editor3']));

			$savepath = './uploadfile/user/image/' . date("Ymd");
            $datefloder = './uploadfile/user/image/tmpdelete/';//tmpdelete 临时文件夹
            //新建日期文件夹
            if (!is_dir($datefloder)) {
                mkdir($datefloder, 0777);
            }
            if (!empty($editor1)) {//招商海报
                preg_match_all("/src=([\"|']?)([^\"'>]+\.(gif|jpg|jpeg|bmp|png))\\1/i", $editor1, $res);//正则表达式匹配查找图片路径
                $num = count($res[2]);
                if ($num) {
                    for ($i = 0; $i < $num; $i++) {
                        $ueditor_img = $res[2][$i];//完整图片路径
                        $tmp_arr = explode('/', $ueditor_img);
                        $new_img = $savepath . '/' . $tmp_arr[13];//$tmp_arr[5]为 20161212105503_48820.png
                        $tmpimg = $datefloder . $tmp_arr[13];
                        //转移图片
                        $datesave = '/' . date("Ymd") . '/';
                        if (rename($tmpimg, $new_img)) { //旧，新
                            $content1 = str_replace("/tmpdelete/", $datesave, $editor1);//旧，新
                        }
                    }
                } else {
					$n = array('info' => "请上传招商海报！", 'status' => 'n');
            		echo json_encode($n);
            		exit;
                }
                //添加招商海报page表
                $info_2 = $this->page->insert(array('catid' => $res2, 'title' => '招商海报', 'keywords' => '招商海报', 'content' => $content1, 'username' => $username, 'updatetime' => SYS_TIME, 'todaydate' => $todaydate));
                $this->page_db->create_html($res2, $info_2);
            } else {
                $n = array('info' => "请上传招商海报！", 'status' => 'n');
        		echo json_encode($n);
        		exit;
            }
            if (!empty($editor2)) {//项目简介
                // var_dump($editor2);exit;
                preg_match_all("/src=([\"|']?)([^\"'>]+\.(gif|jpg|jpeg|bmp|png))\\1/i", $editor2, $res);//正则表达式匹配查找图片路径
                $num2 = count($res[2]);
                if ($num2) {
                    for ($i = 0; $i < $num2; $i++) {
                        $ueditor_img2 = $res[2][$i];//完整图片路径,例： /uploadfile/user/image/tmpdelete/20161223162342_50663.png
                        $tmp_arr2 = explode('/', $ueditor_img2);
                        $new_img2 = $savepath . '/' . $tmp_arr2[5];//$tmp_arr[5]为 20161212105503_48820.png
                        $tmpimg2 = $datefloder . $tmp_arr2[5];
                        //转移图片
                        $datesave = '/' . date("Ymd") . '/';
                        @rename($tmpimg2, $new_img2); //旧，新
                        $content2 = str_replace('/tmpdelete/', $datesave, $editor2);//旧，新
                    }
                } else {
                    $content2 = $editor2;
                    $description = str_cut(str_replace(array("'", "\r\n", "\t", '[page]', '[/page]', '&ldquo;', '&rdquo;', '&nbsp;'), '', strip_tags($content2)), 400);
                    $wecatid = $resid;
                    $this->cate->update(array('description' => $description), array('catid' => $wecatid));
                }
                //给品牌项目添加description
                $description = str_cut(str_replace(array("'", "\r\n", "\t", '[page]', '[/page]', '&ldquo;', '&rdquo;', '&nbsp;'), '', strip_tags($content2)), 400);
                $wecatid = $resid;
                $this->cate->update(array('description' => $description), array('catid' => $wecatid));
                //添加项目简介page表
                $info_3 = $this->page->insert(array('catid' => $res3, 'title' => '项目简介', 'keywords' => '项目简介', 'content' => $content2, 'username' => $username, 'updatetime' => SYS_TIME, 'todaydate' => $todaydate));
                $this->page_db->create_html($res3, $info_3);
            } else {
				$n = array('info' => "请填写项目简介！", 'status' => 'n');
        		echo json_encode($n);
        		exit;
            }
            if (!empty($editor3)) {//加盟政策
                preg_match_all("/src=([\"|']?)([^\"'>]+\.(gif|jpg|jpeg|bmp|png))\\1/i", $editor3, $res);
                $num3 = count($res[2]);
                if ($num3) {
                    for ($i = 0; $i < $num3; $i++) {
                        $ueditor_img3 = $res[2][$i];//完整图片路径,例： /uploadfile/user/image/tmpdelete/20161223162342_50663.png
                        $tmp_arr3 = explode('/', $ueditor_img3);
                        $new_img3 = $savepath . '/' . $tmp_arr3[5];//$tmp_arr[5]为 20161212105503_48820.png
                        $tmpimg3 = $datefloder . $tmp_arr3[5];
                        //转移图片
                        $datesave = '/' . date("Ymd") . '/';
                        $rename = @rename($tmpimg3, $new_img3); //旧，新
                        $content3 = str_replace('/tmpdelete/', $datesave, $editor3);//旧，新
                    }
                } else {
                    $content3 = $editor3;
                }
                $info_4 = $this->page->insert(array('catid' => $res4, 'title' => '加盟政策', 'keywords' => '加盟政策', 'content' => $content3, 'username' => $username, 'updatetime' => SYS_TIME, 'todaydate' => $todaydate));
                $this->page_db->create_html($res4, $info_4);
            } else {
				$n = array('info' => '请填写加盟政策！', 'status' => 'n');
        		echo json_encode($n);
        		exit;
            }
			$n = array('info' => '添加成功。', 'status' => 'y');
        	echo json_encode($n);
        	exit;
        }
		$n = array('info' => '未知错误！', 'status' => 'n');
        echo json_encode($n);
        exit;
	}
	
	

    public function iswriteup()
    {//ajax请先完善保存上面的信息！
        $isupdate = $this->isarr();
        if ($isupdate == 'quanxin' || $isupdate == 'weiwanchang') {
            echo 1;
            exit;
        } else {
            echo 2;
            exit;
        }
    }

    public function xiangmu()
    {//品牌项目审核页面显示
        $this->mber = pc_base::load_model('member_model');
        $this->cate = pc_base::load_model('category_model');
        if ($_SESSION['userid_kk']) {
            $seid = $_SESSION['userid_kk'];
            $mberinfo = $this->mber->get_one(array('userid' => $seid));
        }
        $username = $mberinfo['username'];
        $page = $_GET['page'] ? intval($_GET['page']) : '1';
        $seres = $this->cate->listinfo(array('type' => 0, 'modelid' => 1, 'child' => 1, 'ismenu' => 0), 'catid desc', $page, 50);
        $pages = $this->cate->pages;
        include $this->admin_tpl('content_xiangmu');
    }

    public function passxiangmu()
    {//品牌项目审核通过、退稿
        $this->cate = pc_base::load_model('category_model');
        $this->page = pc_base::load_model('page_model');
        $this->message_db = pc_base::load_model('message_model');
        $reject_c = $_POST['reject_c'];//就不需要安全过滤了
        if (isset($_GET['reject'])) {//退稿
            $reject = 1;
        }
        $arrid = $_POST['ids'];
        $isarrid = count($arrid);
        if ($isarrid) {
            $catids = implode(",", $arrid);
            if (!$reject) {//审核通过
                $res = $this->cate->update("ismenu=1", "catid in($catids) and type=0 and modelid=1 and child=1");
                if ($res) {
                    showmessage("成功,记得到“管理栏目”处“更新栏目缓存”！", HTTP_REFERER);

                } else {
                    showmessage("审核操作失败！", HTTP_REFERER);
                }
            }

        }

        if (!$isarrid) {
            showmessage("未选择！", HTTP_REFERER);
        }
        if ($reject && $isarrid == 1) {//退稿
            $catids = implode(",", $arrid);
            $reinfo = $this->cate->get_one(array("catid" => $catids));
            if (!$reinfo) {
                showmessage("查询没有所属用户名！", HTTP_REFERER);
            }
            $res = $this->message_db->insert(array('send_from_id' => 'xiangmu', 'send_to_id' => $reinfo['username'], 'catid' => $catids, 'subject' => $reinfo['catname'], 'content' => $reject_c, 'message_time' => SYS_TIME));
            if ($res) {
                //$this->cate->update(array('ismenu'=>0),array('catid'=>$catids));
                $arrchildid = $reinfo['arrchildid'];
                if ($arrchildid) {
                    $res = $this->cate->delete("catid in($arrchildid)");
                    if ($res) {
                        $res2 = $this->page->delete("catid in($arrchildid)");
                        if ($res2) {
                            $isa = 2;
                        } else {
                            $isa = 3;
                        }
                    } else {
                        $isa = 1;
                    }
                }

                if ($isa == 1) {
                    showmessage("退稿删除category时失败！", HTTP_REFERER, 1000);
                } elseif ($isa == 2) {
                    showmessage("退稿成功！", HTTP_REFERER, 1000);
                } else {
                    showmessage("退稿删除page时失败！", HTTP_REFERER, 1000);
                }
            } else {
                showmessage("退稿失败！", HTTP_REFERER);
            }
        }
        if ($reject && $isarrid != 1) {//退稿 不通选择多个id进行insert操作
            showmessage("退稿失败，只能选择一个进行退稿！", HTTP_REFERER, 1600);
        }
        showmessage(L('operation_success'), HTTP_REFERER);
        //include $this->admin_tpl('content_xiangmu');
    }

    public function passpinpaichixun()
    {//品牌资讯退稿
        $catid = intval($_GET['catid']);
        $arrid = $_POST['ids'];
        $reject_c = $_POST['reject_c'];
        $this->self = pc_base::load_model('aself_model');
        $this->mess = pc_base::load_model('message_model');
        $this->self->selftb("v9_pinpaizhixun");
        $isarrid = count($arrid);
        //print_r($isarrid);exit;
        if ($isarrid == 1) {
            $arrid = implode(",", $arrid);
            $titleinfo = $this->self->get_one(array('id' => $arrid));
            $title = $titleinfo['title'];
            $username = $titleinfo['username'];
            if ($titleinfo) {
                $res = $this->self->delete(array('id' => $arrid, 'catid' => $catid));
                if ($res) {
                    $this->self->selftb("v9_pinpaizhixun_data");
                    $res2 = $this->self->delete(array('id' => $arrid));
                    if ($res2) {
                        $this->mess->insert(array('send_from_id' => 'pinpaizhixun', 'send_to_id' => $username, 'folder' => 'inbox', 'catid' => $catid, 'status' => 0, 'message_time' => SYS_TIME, 'subject' => $title, 'content' => $reject_c));//status为0时 标记为未读状态
                        showmessage("退稿成功！", HTTP_REFERER, 1600);
                    } else {
                        showmessage("退稿失败！", HTTP_REFERER, 1600);
                    }
                } else {
                    showmessage("退稿失败！", HTTP_REFERER, 1600);
                }
            }
        } else {
            showmessage("退稿失败，只能选择一个进行退稿！", HTTP_REFERER, 1600);
        }
        showmessage("未知参数，请重试！", HTTP_REFERER, 1600);
    }

    public function liuyan()
    {//后台留言管理
        $this->se = pc_base::load_model('aself_model');
        $this->se->selftb("v9_liuyan");
        $page = isset($_GET['page']) && trim($_GET['page']) ? intval($_GET['page']) : 1;
        $datas = $this->se->listinfo('', 'id DESC', $page, 30);
        $pages = $this->se->pages;
        include $this->admin_tpl('content_liuyan');
    }

    public function dianpin()
    {//后台评论管理
        $this->se = pc_base::load_model('aself_model');
        $this->se->selftb("v9_dianping");
        $page = isset($_GET['page']) && trim($_GET['page']) ? intval($_GET['page']) : 1;
        $datas = $this->se->listinfo('', 'id DESC', $page, 30);
        $pages = $this->se->pages;
        include $this->admin_tpl('content_dianpin');
    }

    public function liuyanpass()
    {//推送留言至用户个人中心处
        $this->se = pc_base::load_model('aself_model');
        $this->se->selftb("v9_liuyan");
        foreach ($_POST['ids'] as $key => $r) {
            $ids[] = $r;
        }
        if ($ids) {
            $catids = implode(",", $ids);
            $res = $this->se->update(array('status' => 1, 'passtime' => SYS_TIME), "id in($catids)");
            if ($res) {
                showmessage("推送成功！", HTTP_REFERER, 1000);
            } else {
                showmessage("推送失败！", HTTP_REFERER, 1000);
            }
        }
        showmessage("未选择！", HTTP_REFERER, 1000);
    }

    public function liuyandelete()
    {//留言删除
        $this->se = pc_base::load_model('aself_model');
        $this->se->selftb("v9_liuyan");
        foreach ($_POST['ids'] as $key => $r) {
            $ids[] = $r;
        }
        if ($ids) {
            $catids = implode(",", $ids);
            $res = $this->se->delete("id in($catids)");
            if ($res) {
                showmessage("删除成功！", HTTP_REFERER, 1000);
            } else {
                showmessage("删除失败！", HTTP_REFERER, 1000);
            }
        }
        showmessage("未选择！", HTTP_REFERER, 1000);
    }

    public function dianpindelete()
    {//评论删除
        $this->se = pc_base::load_model('aself_model');
        $this->se->selftb("v9_dianping");
        foreach ($_POST['ids'] as $key => $r) {
            $ids[] = $r;
        }
        if ($ids) {
            $catids = implode(",", $ids);
            $res = $this->se->delete("id in($catids)");
            if ($res) {
                showmessage("删除成功！", HTTP_REFERER, 1000);
            } else {
                showmessage("删除失败！", HTTP_REFERER, 1000);
            }
        }
        showmessage("未选择！", HTTP_REFERER, 1000);
    }

    //友情链接

    /**
     * 删除友情链接
     * @param    intval $sid 友情链接ID，递归删除
     */
    public function public_links_del()
    {
        $this->dbte->selftb("v9_category_links");
        if ((!isset($_GET['linkid']) || empty($_GET['linkid'])) && (!isset($_POST['linkid']) || empty($_POST['linkid']))) {
            showmessage(L('illegal_parameters'), HTTP_REFERER);
        } else {
            if (is_array($_POST['linkid'])) {
                foreach ($_POST['linkid'] as $linkid_arr) {
                    //批量删除友情链接
                    $this->dbte->delete(array('linkid' => $linkid_arr));

                }
                showmessage(L('operation_success'));
            } else {
                $linkid = intval($_GET['linkid']);
                if ($linkid < 1) return false;
                //删除友情链接
                $result = $this->dbte->delete(array('linkid' => $linkid));
                if ($result) {
                    showmessage(L('operation_success'));
                } else {
                    showmessage(L("operation_failure"));
                }
            }
            showmessage(L('operation_success'), HTTP_REFERER);
        }
    }

    public function public_links_edit()
    {
        $this->dbte->selftb("v9_category_links");
        if (isset($_POST['dosubmit'])) {
            $linkid = intval($_GET['linkid']);
            if ($linkid < 1) return false;
            if (!is_array($_POST['link']) || empty($_POST['link'])) return false;
            if ((!$_POST['link']['name']) || empty($_POST['link']['name'])) return false;
            $this->dbte->update($_POST['link'], array('linkid' => $linkid));
            if (isset($_POST['dosubmit'])) {
                showmessage(L('update_success') . L('2s_close'), 'blank', '', '', 'function set_time() {$("#secondid").html(1);}setTimeout("set_time()", 500);setTimeout("window.close()", 1200);');
            } else {
                showmessage(L('update_success'), HTTP_REFERER);
            }
        }
    }

    public function public_link_list()
    {
        $catid = $_GET['catid'];
        $this->dbte->selftb("v9_category_links");
        $page = isset($_GET['page']) && intval($_GET['page']) ? intval($_GET['page']) : 1;
        $wherek = "`catid`=$catid";
        $infos = $this->dbte->listinfo($wherek, $order = 'linkid DESC', $page, $pages = '9');
        $pages = $this->dbte->pages;
        $big_menu = array('javascript:window.top.art.dialog(
			{id:\'add\',
			iframe:\'?m=content&c=content&a=public_links_add\', 
			title:\'' . L('添加友链') . '\', 
			width:\'700\', height:\'450\'}, 
			function(){
				var d = window.top.art.dialog({id:\'add\'}).data.iframe;
				var form = d.document.getElementById(\'dosubmit\');
				form.click();return false;
			}, 
			function(){
				window.top.art.dialog({id:\'add\'}).close()
			});void(0);', L('添加友链'));
        include $this->admin_tpl('link_list');
    }

    //添加友情链接
    public function public_links_add()
    {
        $this->dbte->selftb("v9_category_links");
        if (isset($_POST['dosubmit'])) {
            if (empty($_POST['link']['title'])) {
                showmessage(L('sitename_noempty'), HTTP_REFERER);
            } else {
                $_POST['link']['title'] = safe_replace($_POST['link']['title']);
            }

            $data = new_addslashes($_POST['link']);
            $data['catid'] = intval($_COOKIE['cccccatid']);
            $linkid = $this->dbte->insert($data, true);
            if (!$linkid) return FALSE;
            showmessage(L('operation_success'), HTTP_REFERER);
        } else {
            $show_validator = $show_scroll = $show_header = true;
            pc_base::load_sys_class('form', '', 0);

            //print_r($types);exit;
            include $this->admin_tpl('link_add');
        }

    }

    public function huatiadd()
    { //问答话题添加
        $db = pc_base::load_model('content_model');
        $self_db = pc_base::load_model('aself_model');
        $urlrules = $this->urlrules[30];//生成列表页URL
        $self_db->selftb("v9_huati");
        $info = $self_db->select("");
        if ($info) {
            $db->query("select * from v9_huati,v9_huati_data where v9_huati.id=v9_huati_data.huatiid and v9_huati_data.fustatus=99 order by v9_huati_data.aid desc");
            $data = $db->fetch_array();
        }
        // print_r($data);exit;
        $username = $this->userinfo;
        $username = $username['username'];
        if (isset($_POST['submitkk']) && $_POST['submitkk'] == "sub1") {//正表
            $title = trim($_POST['title']);
            $res = $self_db->insert(array('title' => $title, 'status' => 99, 'inputtime' => SYS_TIME), ture);
            if ($res) {
                $urls = $this->url->show($res, $page = 0, $catid = 922, $time = 0, $prefix = '', $data = '', $action = 'add', $upgrade = 0);
                $urls = $urls[0];
                $res2 = $self_db->update(array('url' => $urls), array('id' => $res));
                if ($res2) {
                    $self_db->selftb("v9_huati_wdfl");//问题分类里的话题
                    $res3 = $self_db->insert(array('id' => $res, 'title' => $title, 'status' => 99, 'inputtime' => SYS_TIME));
                    if ($res3) {
                        $urls = $this->url->show($res, $page = 0, $catid = 930, $time = 0, $prefix = '', $data = '', $action = 'add', $upgrade = 0);
                        $urls = $urls[0];
                        $res4 = $self_db->update(array('url' => $urls), array('id' => $res));
                        if ($res4) {
                            $self_db->selftb("v9_huati_rmhd");//热门回答里的话题
                            $res5 = $self_db->insert(array('id' => $res, 'title' => $title, 'status' => 99, 'inputtime' => SYS_TIME));
                            if ($res5) {
                                $urls = $this->url->show($res, $page = 0, $catid = 931, $time = 0, $prefix = '', $data = '', $action = 'add', $upgrade = 0);
                                $urls = $urls[0];
                                $res6 = $self_db->update(array('url' => $urls), array('id' => $res));
                                if ($res6) {
                                    showmessage("操作成功", HTTP_REFERER, 600);
                                }
                            }
                        }
                    }
                }
            } else {
                showmessage("操作失败", HTTP_REFERER, 600);
            }
        }
        if (isset($_POST['submitkk']) && $_POST['submitkk'] == "sub2") {//副表
            $futitle = trim($_POST['futitle']);
            $fudescription = trim($_POST['fudescription']);
            $fuid = trim($_POST['fuid']);
            $cimg = trim($_POST['cimg']);
            if (!$futitle) {
                showmessage("名称不能为空", HTTP_REFERER, 600);
            } elseif (!$cimg) {
                showmessage("图片不能为空", HTTP_REFERER, 600);
            }
            $base = explode(',', $cimg);
            $ext = explode("/", $base[0]);
            $exta = explode(";", $ext[1]);
            $img = base64_decode($base[1]);

            $datea = './uploadfile/user/wd_huati/' . date("Ymd");
            $thumbsave = $datea . '/' . date("YmdHis") . '_' . rand(10000, 99999) . '.' . $exta[0];

            @mkdir($datea, 0777);

            file_put_contents($thumbsave, $img);
            $self_db->selftb("v9_huati_data");
            $res = $self_db->insert(array('futitle' => $futitle, 'huatiid' => $fuid, 'fudescription' => $fudescription, 'fustatus' => 99, 'huatiimg' => $thumbsave, 'fuinputtime' => SYS_TIME), true);
            if ($res) {
                showmessage("操作成功", HTTP_REFERER, 600);
            } else {
                showmessage("操作失败", HTTP_REFERER, 600);
            }
        }
        if (isset($_POST['submitkk']) && $_POST['submitkk'] == "sub3") {//副表  更改操作
            $aid = trim($_POST['aid']);
            $futitle = trim($_POST['futitle']);
            $fudescription = trim($_POST['fudescription']);
            $fuid = trim($_POST['fuid']);
            $cimg = trim($_POST['upimg']);
            $deleimg = trim($_POST['deleimg']);
            if ($deleimg) {//删除旧图片
                @unlink($deleimg);
            }
            if (!$futitle) {
                showmessage("名称不能为空", HTTP_REFERER, 600);
            } elseif (!$cimg) {
                showmessage("图片不能为空", HTTP_REFERER, 600);
            }
            $base = explode(',', $cimg);
            $ext = explode("/", $base[0]);
            $exta = explode(";", $ext[1]);
            $img = base64_decode($base[1]);

            $datea = './uploadfile/user/wd_huati/' . date("Ymd");
            $thumbsave = $datea . '/' . date("YmdHis") . '_' . rand(10000, 99999) . '.' . $exta[0];

            @mkdir($datea, 0777);

            file_put_contents($thumbsave, $img);
            $self_db->selftb("v9_huati_data");
            $res = $self_db->update(array('futitle' => $futitle, 'huatiid' => $fuid, 'fudescription' => $fudescription, 'huatiimg' => $thumbsave, 'fuinputtime' => SYS_TIME), array('aid' => $aid), true);
            if ($res) {
                showmessage("更改成功", HTTP_REFERER, 600);
            } else {
                showmessage("更改失败", HTTP_REFERER, 600);
            }
        }
        include $this->admin_tpl('content_huatiadd');
    }

    public function wd_huati_del()
    { //问答话题删除
        $self_db = pc_base::load_model('aself_model');
        $self_db->selftb("v9_huati_data");
        $ids = $_POST['ids'];// $ids=trim($_POST['ids'])这样写是错误的
        $ids = implode(",", $ids);
        $huatiimg = $self_db->select("aid IN($ids)", 'huatiimg');
        foreach ($huatiimg as $r) {
            @unlink($r['huatiimg']);
        }
        if ($huatiimg) {
            $res = $self_db->delete("aid IN($ids)");
            if ($res) {
                showmessage("删除成功", HTTP_REFERER, 600);
            } else {
                showmessage("删除失败", HTTP_REFERER, 600);
            }
        } else {
            showmessage("删除图片出错", HTTP_REFERER, 600);
        }
    }

    public function wd_huati_order()
    {//问答话题排序
        $self_db = pc_base::load_model('aself_model');
        $self_db->selftb("v9_huati_data");
        $fulistorder = $_POST['fulistorder'];
        showmessage("待开发", HTTP_REFERER, 900);;
        exit;
        $fulistorder = implode(",", $fulistorder);
        $res = $self_db->update("fulistorder IN($fulistorder)");
        if ($res) {
            showmessage("操作成功", HTTP_REFERER, 600);
        } else {
            showmessage("操作失败", HTTP_REFERER, 600);
        }
    }

    public function wd_wenti_manage()
    {//问题管理
        if (isset($_POST['ids']) && !empty($_POST['ids'])) {
            $ids = $_POST['ids'];


            // $this->dbte->selftb("v9_question");
            // for ($i=0; $i < count($ids) ; $i++) {

            foreach ($ids as $key => $id) {
                $this->dbte->selftb("v9_question");
                $info = $this->dbte->get_one(array('id' => $id));
                if ($info) {
                    $wt_userid = $info['userid'];
                    $res = $this->dbte->delete(array('id' => $id));

                    if ($res) {
                        $this->xiangyin_huida_del($id);
                        $this->xiangyin_dianzan_del($id);
                        $this->xiangyin_guangzhu_del($id);
                        $this->xiangyin_jubao_del($id);
                        $this->xiangyin_dongdai_del($id);
                        $this->xiangyin_xiangtatiwen_del($id);
                        $this->dbte->selftb("v9_member");
                        $res2 = $this->dbte->update("tiwenshu=tiwenshu-1", array('userid' => $wt_userid));
                        if ($res2) {
                            $ist = 1;
                        } else {
                            showmessage('删除问题失败！', HTTP_REFERER, 900);
                        }
                    } else {
                        showmessage('删除问题出错！', HTTP_REFERER, 900);
                    }
                } else {
                    showmessage('没有这个问题！', HTTP_REFERER, 900);
                }
            }

            if ($ist) {
                showmessage('删除问题成功！', HTTP_REFERER, 900);
            }

        }

        $sql = "select * from v9_question order by id desc";
        $seget = pc_base::load_model('get_model');
        $page = intval($_GET['page']) ? intval($_GET['page']) : '1';
        $data = $seget->multi_listinfo($sql, $page, 20); //返回查询结果
        $pages = $seget->pages;//返回分页
        include $this->admin_tpl('content_wenti_manage');
    }

    public function wd_huida_manage()
    {//回答管理
        if (isset($_POST['ids']) && !empty($_POST['ids'])) {//删除操作
            $ids = $_POST['ids'];
            $wtids = $_POST['wtids'];

            $this->dbte->selftb("v9_huida");

            $ids = implode(",", $ids);
            $wtids = implode(",", $wtids);
            $res = $this->dbte->delete("huidaid in($ids)");
            if ($res) {
                $this->dbte->selftb("v9_question");
                $res2 = $this->dbte->update("huidas=huidas-1", "id in($wtids)");
                if ($res2) {
                    showmessage("删除成功！", HTTP_REFERER, 1000);
                } else {
                    showmessage("删除失败！", HTTP_REFERER, 1000);
                }
            } else {
                showmessage("删除失败！", HTTP_REFERER, 1000);
            }
        }

        $sql = "select h.*,q.* from v9_huida as h,v9_question as q where h.wtid = q.id order by h.huidaid desc";
        $seget = pc_base::load_model('get_model');
        $page = intval($_GET['page']) ? intval($_GET['page']) : '1';
        $data = $seget->multi_listinfo($sql, $page, 20); //返回查询结果
        $pages = $seget->pages;//返回分页
        include $this->admin_tpl('content_huida_manage');
    }

    public function wd_jubao_manage()
    {//举报管理
        if (isset($_POST['ids']) && !empty($_POST['ids'])) {//删除操作
            $ids = $_POST['ids'];
            $this->se = pc_base::load_model('aself_model');
            $this->se->selftb("v9_wd_jubao");
            $ids = implode(",", $ids);
            $res = $this->se->delete("id in($ids)");
            if ($res) {
                showmessage("删除成功！", HTTP_REFERER, 1000);
            } else {
                showmessage("删除失败！", HTTP_REFERER, 1000);
            }
        }

        $sql = "select * from v9_wd_jubao order by id desc";
        $seget = pc_base::load_model('get_model');
        $page = intval($_GET['page']) ? intval($_GET['page']) : '1';
        $data = $seget->multi_listinfo($sql, $page, 20); //返回查询结果
        $pages = $seget->pages;//返回分页
        include $this->admin_tpl('content_jubao_manage');
    }

    public function xiangyin_huida_del($id)
    {//删除相应回答
        $this->dbte->selftb("v9_huida");
        $res = $this->dbte->get_one(array('wtid' => $id));
        if ($res) {
            $this->dbte->delete(array('wtid' => $id));
        }
        //未做删除相应回答用户的member表的huidashu
    }

    public function xiangyin_dianzan_del($id)
    {//删除相应点赞
        $this->dbte->selftb("v9_wd_wenti_dianzan");
        $res = $this->dbte->get_one(array('wtid' => $id));
        if ($res) {
            $this->dbte->delete(array('wtid' => $id));
        }
    }

    public function xiangyin_guangzhu_del($id)
    {//删除相应关注
        $this->dbte->selftb("v9_wd_question_guangzhu");
        $res = $this->dbte->get_one(array('wtid' => $id));
        if ($res) {
            $this->dbte->delete(array('wtid' => $id));
        }
    }

    public function xiangyin_jubao_del($id)
    {//删除相应举报
        $this->dbte->selftb("v9_wd_jubao");
        $res = $this->dbte->get_one(array('wtid' => $id));
        if ($res) {
            $this->dbte->delete(array('wtid' => $id));
        }
    }

    public function xiangyin_dongdai_del($id)
    {//删除相应个人动态
        $this->dbte->selftb("v9_wd_dongdai");
        $res = $this->dbte->get_one(array('wtid' => $id));
        if ($res) {
            $this->dbte->delete(array('wtid' => $id));
        }
    }

    public function xiangyin_xiangtatiwen_del($id)
    {//删除相应向他提问
        $this->dbte->selftb("v9_wd_xiangtatiwen");
        $res = $this->dbte->get_one(array('wentiid' => $id));
        if ($res) {
            $this->dbte->delete(array('wentiid' => $id));
        }
    }

    public function init()
    {
        $catid = $_GET['catid'] = intval($_GET['catid']);
        param::set_cookie('catid', $catid);
        $this->aself = pc_base::load_model('aself_model');
        $this->aself->selftb("v9_category");
        $wherek = "`catid`=$catid";
        $cateres = $this->aself->select($wherek, '*', 12000);
        foreach ($cateres as $r) {
            $this->categorys[$r['catid']] = $r;
        }
        $category = $this->categorys[$catid];
        $modelid = $category['modelid'];
        $show_header = $show_dialog = $show_pc_hash = '';
        // if(isset($_GET['catid']) && $_GET['catid'] && $this->categorys[$_GET['catid']]['siteid']==$this->siteid) {
        if (isset($_GET['catid']) && $_GET['catid'] && $this->categorys[$catid]['siteid'] == $this->siteid) {
            // $catid = $_GET['catid'] = intval($_GET['catid']);
            // $category = $this->categorys[$catid];

            // $model_arr = getcache('model', 'commons');
            $MODEL = $model_arr[$modelid];
            unset($model_arr);
            $admin_username = param::get_cookie('admin_username');
            //查询当前的工作流
            $setting = string2array($category['setting']);
            $workflowid = $setting['workflowid'];
            $workflows = getcache('workflow_' . $this->siteid, 'commons');
            $workflows = $workflows[$workflowid];
            $workflows_setting = string2array($workflows['setting']);

            //将有权限的级别放到新数组中
            $admin_privs = array();
            foreach ($workflows_setting as $_k => $_v) {
                if (empty($_v)) continue;
                foreach ($_v as $_value) {
                    if ($_value == $admin_username) $admin_privs[$_k] = $_k;
                }
            }
            //工作流审核级别
            $workflow_steps = $workflows['steps'];
            $workflow_menu = '';
            $steps = isset($_GET['steps']) ? intval($_GET['steps']) : 0;
            //工作流权限判断
            if ($_SESSION['roleid'] != 1 && $steps && !in_array($steps, $admin_privs)) showmessage(L('permission_to_operate'));
            $this->db->set_model($modelid);
            if ($this->db->table_name == $this->db->db_tablepre) showmessage(L('model_table_not_exists'));;
            $status = $steps ? $steps : 99;

            if (isset($_GET['reject'])) $status = 0;

            $where = 'catid=' . $catid . ' AND status=' . $status;
            //echo $where;exit;
            //搜索

            if (isset($_GET['start_time']) && $_GET['start_time']) {
                $start_time = strtotime($_GET['start_time']);
                $where .= " AND `inputtime` > '$start_time'";
            }
            if (isset($_GET['end_time']) && $_GET['end_time']) {
                $end_time = strtotime($_GET['end_time']);
                $where .= " AND `inputtime` < '$end_time'";
            }
            if ($start_time > $end_time) showmessage(L('starttime_than_endtime'));
            if (isset($_GET['keyword']) && !empty($_GET['keyword'])) {
                $type_array = array('title', 'description', 'username');
                $searchtype = intval($_GET['searchtype']);
                if ($searchtype < 3) {
                    $searchtype = $type_array[$searchtype];
                    $keyword = strip_tags(trim($_GET['keyword']));
                    $where .= " AND `$searchtype` like '%$keyword%'";
                } elseif ($searchtype == 3) {
                    $keyword = intval($_GET['keyword']);
                    $where .= " AND `id`='$keyword'";
                }
            }
            if (isset($_GET['posids']) && !empty($_GET['posids'])) {
                $posids = $_GET['posids'] == 1 ? intval($_GET['posids']) : 0;
                $where .= " AND `posids` = '$posids'";
            }

            if($this->db->table_name == 'v9_chuanyexueyuan' || $this->db->table_name == 'v9_shangjizixun'){
                // echo $this->db->table_name;exit;
                $time = time();
                $where .= " AND inputtime <=".$time;
            }  

            $datas = $this->db->listinfo($where, 'id desc', $_GET['page']);
            $pages = $this->db->pages;
            $pc_hash = $_SESSION['pc_hash'];
            for ($i = 1; $i <= $workflow_steps; $i++) {
                if ($_SESSION['roleid'] != 1 && !in_array($i, $admin_privs)) continue;
                $current = $steps == $i ? 'class=on' : '';
                $r = $this->db->get_one(array('catid' => $catid, 'status' => $i));
                $newimg = $r ? '<img src="' . IMG_PATH . 'icon/new.png" style="padding-bottom:2px" onclick="window.location.href=\'?m=content&c=content&a=&menuid=' . $_GET['menuid'] . '&catid=' . $catid . '&steps=' . $i . '&pc_hash=' . $pc_hash . '\'">' : '';
                $workflow_menu .= '<a href="?m=content&c=content&a=&menuid=' . $_GET['menuid'] . '&catid=' . $catid . '&steps=' . $i . '&pc_hash=' . $pc_hash . '" ' . $current . ' ><em>' . L('workflow_' . $i) . $newimg . '</em></a><span>|</span>';
            }
            if ($workflow_menu) {
                $current = isset($_GET['reject']) ? 'class=on' : '';
                $workflow_menu .= '<a href="?m=content&c=content&a=&menuid=' . $_GET['menuid'] . '&catid=' . $catid . '&pc_hash=' . $pc_hash . '&reject=1" ' . $current . ' ><em>' . L('reject') . '</em></a><span>|</span>';
            }
            //$ = 153fc6d28dda8ca94eaa3686c8eed857;获取模型的thumb字段配置信息
            $model_fields = getcache('model_field_' . $modelid, 'model');
            $setting = string2array($model_fields['thumb']['setting']);
            $args = '1,' . $setting['upload_allowext'] . ',' . $setting['isselectimage'] . ',' . $setting['images_width'] . ',' . $setting['images_height'] . ',' . $setting['watermark'];
            $authkey = upload_key($args);
            $template = $MODEL['admin_list_template'] ? $MODEL['admin_list_template'] : 'content_list';
            if ($catid == 198 || $catid == 199 || $catid == 200 || $catid == 201 || $catid == 202 || $catid == 203 || $catid == 230) {
                echo '请到 商机库 相对应的品牌资讯里添加！';
                exit;
            }
            if ($modelid == 12) {//品牌资讯时
                $workflow_menu = 12;
                $tuigou = 1;
            }            
            include $this->admin_tpl($template);//content_list
        } else {
            include $this->admin_tpl('content_quick');
        }
    }

    public function seoadd_list()
    {
        $this->aself = pc_base::load_model('aself_model');
        $this->aself->selftb("v9_category");
        $catid = $_POST['catid'];
        $setinfo = '{"workflowid":"","ishtml":"1","content_ishtml":"0","create_to_html_root":"1","template_list":"default","category_template":"category_location","list_template":"list","show_template":"show","meta_title":"' . $_POST['seotitle'] . '","meta_keywords":"' . $_POST['seokeyword'] . '","meta_description":"' . $_POST['seodescription'] . '","presentpoint":"1","defaultchargepoint":"0","paytype":"0","repeatchargedays":"1","category_ruleid":"30","show_ruleid":"18"}';
        $data = array(
            'setting' => $setinfo,
            // 'seokeyword'=>$_POST['seokeyword']
        );
        $res = $this->aself->update($data, array('catid' => $catid));
        if ($res) {
            showmessage('保存成功', HTTP_REFERER);
        } else {
            showmessage('保存失败', HTTP_REFERER);
        }

    }

    public function add()
    {
        if (isset($_POST['dosubmit']) || isset($_POST['dosubmit_continue'])) {
            $catid = $_POST['info']['catid'] = intval($_POST['info']['catid']);
            if (trim($_POST['info']['title']) == '') showmessage(L('title_is_empty'));
            $this->aself = pc_base::load_model('aself_model');
            $this->aself->selftb("v9_category");
            $wherek = "`catid`=$catid";
            $cateres = $this->aself->select($wherek, '*', 12000);
            foreach ($cateres as $r) {
                $this->categorys[$r['catid']] = $r;
            }
            $category = $this->categorys[$catid];
            // var_dump($category);exit;
            if ($category['type'] == 0) {
                $modelid = $this->categorys[$catid]['modelid'];
                $this->db->set_model($modelid);
                // var_dump($modelid);exit;
                //如果该栏目设置了工作流，那么必须走工作流设定
                $setting = string2array($category['setting']);
                $workflowid = $setting['workflowid'];
                if ($workflowid && $_POST['status'] != 99) {

                    //如果用户是超级管理员，那么则根据自己的设置来发布
                    $_POST['info']['status'] = $_SESSION['roleid'] == 1 ? intval($_POST['status']) : 1;
                } else {

                    $_POST['info']['status'] = 99;
                }
                $_POST['info']['updatetime'] = $_POST['info']['inputtime'] = strtotime($_POST['info']['inputtime']);
                $this->db->add_content($_POST['info']);
                // $result22 = $this->db->select();
                // var_dump($result22]);exit;
                // print_r('88');exit;
                if (isset($_POST['dosubmit'])) {
                    showmessage(L('add_success') . L('2s_close'), 'blank', '', '', 'function set_time() {$("#secondid").html(1);}setTimeout("set_time()", 500);setTimeout("window.close()", 1200);');
                } else {
                    showmessage(L('add_success'), HTTP_REFERER);
                }
            } else {

                //单网页
                $this->page_db = pc_base::load_model('page_model');
                $style_font_weight = $_POST['style_font_weight'] ? 'font-weight:' . strip_tags($_POST['style_font_weight']) : '';
                $_POST['info']['style'] = strip_tags($_POST['style_color']) . ';' . $style_font_weight;

                if ($_POST['edit']) {
                    $this->page_db->update($_POST['info'], array('catid' => $catid));
                } else {
                    $catid = $this->page_db->insert($_POST['info'], 1);
                }
                $this->page_db->create_html($catid, $_POST['info']);
                $forward = HTTP_REFERER;
            }

            showmessage(L('add_success'), $forward);
        } else {

            $show_header = $show_dialog = $show_validator = '';
            //设置cookie 在附件添加处调用
            param::set_cookie('module', 'content');

            if (isset($_GET['catid']) && $_GET['catid']) {
                $catid = $_GET['catid'] = intval($_GET['catid']);

                param::set_cookie('catid', $catid);
                $this->aself = pc_base::load_model('aself_model');
                $this->aself->selftb("v9_category");
                $wherek = "`catid`=$catid";
                $cateres = $this->aself->select($wherek, '*', 12000);
                foreach ($cateres as $r) {
                    $this->categorys[$r['catid']] = $r;
                }
                $category = $this->categorys[$catid];
                if ($category['type'] == 0) {
                    $modelid = $category['modelid'];
                    //取模型ID，依模型ID来生成对应的表单
                    require CACHE_MODEL_PATH . 'content_form.class.php';
                    // echo CACHE_MODEL_PATH . 'content_form.class.php';exit;
                    $content_form = new content_form($modelid, $catid, $this->categorys);
                    $forminfos = $content_form->get();
                    $formValidator = $content_form->formValidator;
                    $setting = string2array($category['setting']);
                    $workflowid = $setting['workflowid'];
                    $workflows = getcache('workflow_' . $this->siteid, 'commons');
                    $workflows = $workflows[$workflowid];
                    $workflows_setting = string2array($workflows['setting']);
                    $nocheck_users = $workflows_setting['nocheck_users'];
                    $admin_username = param::get_cookie('admin_username');
                    if (!empty($nocheck_users) && in_array($admin_username, $nocheck_users)) {
                        $priv_status = true;
                    } else {
                        $priv_status = false;
                    }
                    include $this->admin_tpl('content_add');
                } else {
                    //单网页
                    if ($catid == 230) {
                        echo '此栏目无需添加！';
                        exit;
                    }
                    $this->page_db = pc_base::load_model('page_model');

                    $r = $this->page_db->get_one(array('catid' => $catid));

                    if ($r) {
                        extract($r);
                        $style_arr = explode(';', $style);
                        $style_color = $style_arr[0];
                        $style_font_weight = $style_arr[1] ? substr($style_arr[1], 12) : '';
                    }
                    include $this->admin_tpl('content_page');
                }
            } else {                
                include $this->admin_tpl('content_add');
            }
            header("Cache-control: private");
        }
    }

    public function edit()
    {
        //设置cookie 在附件添加处调用
        param::set_cookie('module', 'content');
        if (isset($_POST['dosubmit']) || isset($_POST['dosubmit_continue'])) {
            // var_dump($_POST);exit;
            define('INDEX_HTML', true);
            $id = $_POST['info']['id'] = intval($_POST['id']);
            $catid = $_POST['info']['catid'] = intval($_POST['info']['catid']);
            if (trim($_POST['info']['title']) == '') showmessage(L('title_is_empty'));
            // echo $catid;exit;
            $this->aself = pc_base::load_model('aself_model');
            $this->aself->selftb("v9_category");
            $wherek = "`ismenu`=1 and `catid`=$catid";
            $cateres = $this->aself->select($wherek, '*', 12000);
            // var_dump($cateres);exit;
            foreach ($cateres as $r) {
                $this->categorys[$r['catid']] = $r;
            }

            $modelid = $this->categorys[$catid]['modelid'];

            $this->db->set_model($modelid);
            $this->db->edit_content($_POST['info'], $id);
            if (isset($_POST['dosubmit'])) {
                showmessage(L('update_success') . L('2s_close'), 'blank', '', '', 'function set_time() {$("#secondid").html(1);}setTimeout("set_time()", 500);setTimeout("window.close()", 1200);');
            } else {
                showmessage(L('update_success'), HTTP_REFERER);
            }
        } else {
            $show_header = $show_dialog = $show_validator = '';
            //从数据库获取内容
            $id = intval($_GET['id']);
            if (!isset($_GET['catid']) || !$_GET['catid']) showmessage(L('missing_part_parameters'));
            $catid = $_GET['catid'] = intval($_GET['catid']);

            $this->aself = pc_base::load_model('aself_model');
            $this->aself->selftb("v9_category");

            $wherek = "`ismenu`=1 and `catid`=$catid";
            $cateres = $this->aself->select($wherek, '*', 12000);
            foreach ($cateres as $r) {
                $this->categorys[$r['catid']] = $r;
            }


            $this->model = getcache('model', 'commons');
            // echo $catid;exit;
            param::set_cookie('catid', $catid);
            $category = $this->categorys[$catid];
            // var_dump($category);exit; //null
            $modelid = $category['modelid'];
            // var_dump($modelid);exit;
            $this->db->table_name = $this->db->db_tablepre . $this->model[$modelid]['tablename'];
            $r = $this->db->get_one(array('id' => $id));
            $this->db->table_name = $this->db->table_name . '_data';
            $r2 = $this->db->get_one(array('id' => $id));
            if (!$r2) showmessage(L('subsidiary_table_datalost'), 'blank');
            $data = array_merge($r, $r2);
            $data = array_map('htmlspecialchars_decode', $data);
            require CACHE_MODEL_PATH . 'content_form.class.php';
            $content_form = new content_form($modelid, $catid, $this->categorys);

            $forminfos = $content_form->get($data);
            $formValidator = $content_form->formValidator;
            include $this->admin_tpl('content_edit');
        }
        header("Cache-control: private");
    }

    public function delete()
    {
        if (isset($_GET['dosubmit'])) {
            $this->aself = pc_base::load_model('aself_model');
            $this->aself->selftb("v9_category");
            $catid = intval($_GET['catid']);
            $wherek = "`ismenu`=1 and `catid`=$catid";
            $cateres = $this->aself->select($wherek, '*', 12000);
            foreach ($cateres as $r) {
                $this->categorys[$r['catid']] = $r;
            }
            if (!$catid) showmessage(L('missing_part_parameters'));
            $modelid = $this->categorys[$catid]['modelid'];
            $sethtml = $this->categorys[$catid]['sethtml'];
            $siteid = $this->categorys[$catid]['siteid'];

            $html_root = pc_base::load_config('system', 'html_root');
            if ($sethtml) $html_root = '';

            $setting = string2array($this->categorys[$catid]['setting']);
            $content_ishtml = $setting['content_ishtml'];
            $this->db->set_model($modelid);
            $this->hits_db = pc_base::load_model('hits_model');
            $this->queue = pc_base::load_model('queue_model');
            if (isset($_GET['ajax_preview'])) {
                $ids = intval($_GET['id']);
                $_POST['ids'] = array(0 => $ids);
            }
            if (empty($_POST['ids'])) showmessage(L('you_do_not_check'));
            //附件初始化
            $attachment = pc_base::load_model('attachment_model');
            $this->content_check_db = pc_base::load_model('content_check_model');
            $this->position_data_db = pc_base::load_model('position_data_model');
            $this->search_db = pc_base::load_model('search_model');
            //判断视频模块是否安装
            if (module_exists('video') && file_exists(PC_PATH . 'model' . DIRECTORY_SEPARATOR . 'video_content_model.class.php')) {
                $video_content_db = pc_base::load_model('video_content_model');
                $video_install = 1;
            }
            $this->comment = pc_base::load_app_class('comment', 'comment');
            $search_model = getcache('search_model_' . $this->siteid, 'search');
            $typeid = $search_model[$modelid]['typeid'];
            $this->url = pc_base::load_app_class('url', 'content');

            foreach ($_POST['ids'] as $id) {
                $r = $this->db->get_one(array('id' => $id));
                if ($content_ishtml && !$r['islink']) {
                    $urls = $this->url->show($id, 0, $r['catid'], $r['inputtime']);
                    $fileurl = $urls[1];
                    if ($this->siteid != 1) {
                        $sitelist = getcache('sitelist', 'commons');
                        $fileurl = $html_root . '/' . $sitelist[$this->siteid]['dirname'] . $fileurl;
                    }
                    //删除静态文件，排除htm/html/shtml外的文件
                    $lasttext = strrchr($fileurl, '.');
                    $len = -strlen($lasttext);
                    $path = substr($fileurl, 0, $len);
                    $path = ltrim($path, '/');
                    $filelist = glob(PHPCMS_PATH . $path . '{_,-,.}*', GLOB_BRACE);
                    foreach ($filelist as $delfile) {
                        $lasttext = strrchr($delfile, '.');
                        if (!in_array($lasttext, array('.htm', '.html', '.shtml'))) continue;
                        @unlink($delfile);
                        //删除发布点队列数据
                        $delfile = str_replace(PHPCMS_PATH, '/', $delfile);
                        $this->queue->add_queue('del', $delfile, $this->siteid);
                    }
                } else {
                    $fileurl = 0;
                }
                if ($modelid == 16) {//商机资讯
                    $fileurl = PHPCMS_PATH . 'bnews' . $fileurl;
                } elseif ($modelid == 18) {//创业学院
                    $fileurl = PHPCMS_PATH . 'enews' . $fileurl;
                } else {
                    $fileurl = PHPCMS_PATH . 'xm' . $fileurl;
                }
                // echo $id.'aa'.$fileurl.'bb'.$catid;exit;
                //删除内容
                $this->db->delete_content($id, $fileurl, $catid);
                //删除统计表数据
                $this->hits_db->delete(array('hitsid' => 'c-' . $modelid . '-' . $id));
                //删除附件
                $attachment->api_delete('c-' . $catid . '-' . $id);
                //删除审核表数据
                //$this->content_check_db->delete(array('checkid'=>'c-'.$id.'-'.$modelid));
                //lison
                $this->content_check_db->delete(array('checkid' => $catid . '-' . $id . '-' . $modelid));
                //删除推荐位数据
                $this->position_data_db->delete(array('id' => $id, 'catid' => $catid, 'module' => 'content'));
                //删除全站搜索中数据
                // $this->search_db->delete_search($typeid,$id);
                //删除视频库与内容对应关系数据
                // if ($video_install ==1) {
                // 	$video_content_db->delete(array('contentid'=>$id, 'modelid'=>$modelid));
                // }

                //删除相关的评论,删除前应该判断是否还存在此模块
                if (module_exists('comment')) {
                    $commentid = id_encode('content_' . $catid, $id, $siteid);
                    $this->comment->del($commentid, $siteid, $id, $catid);
                }

            }
            //更新栏目统计
            // $this->db->cache_items();

            showmessage(L('operation_success'), HTTP_REFERER);
        } else {
            showmessage(L('operation_failure'));
        }
    }

    public function public_articles()
    { //文章审核
        $page = isset($_GET['page']) && intval($_GET['page']) ? intval($_GET['page']) : 1;
        $this->content_check_db = pc_base::load_model('content_check_model');
        $datas = $this->content_check_db->listinfo('status=1', 'inputtime DESC', $page);
        $pages = $this->content_check_db->pages;
        $status = 1;
        include $this->admin_tpl('content_articles');
    }

    public function passall()
    {//凤森添加的审核
        $ids = $_POST['ids'];
        if (!$ids) showmessage(L('missing_part_parameters'));
        $this->content_check_db = pc_base::load_model('content_check_model');
        $html = pc_base::load_app_class('html', 'content');
        $this->url = pc_base::load_app_class('url', 'content');
        $member_db = pc_base::load_model('member_model');
        $this->con = pc_base::load_model('content_model');
        foreach ($ids as $k => $v) {
            $content = $this->content_check_db->get_one(array('checkid' => $v));
            $modelid = $this->categorys[$content['catid']]['modelid'];
            $catid = $content['catid'];
            $arr_checkid = explode('-', $content['checkid']);
            $this->db->set_model($modelid);

            $content_info = $this->db->get_content($content['catid'], $arr_checkid[1]);
            $memberinfo = $member_db->get_one(array('username' => $content_info['username']), 'userid, username');
            $flag = $content['catid'] . '_' . $arr_checkid[1];

            if ($setting['presentpoint'] > 0) {
                pc_base::load_app_class('receipts', 'pay', 0);
                receipts::point($setting['presentpoint'], $memberinfo['userid'], $memberinfo['username'], $flag, 'selfincome', L('contribute_add_point'), $memberinfo['username']);
            } else {
                pc_base::load_app_class('spend', 'pay', 0);
                spend::point($setting['presentpoint'], L('contribute_del_point'), $memberinfo['userid'], $memberinfo['username'], '', '', $flag);
            }
            if ($setting['content_ishtml'] == '1') {//栏目有静态配置
                $urls = $this->url->show($id, 0, $content_info['catid'], $content_info['inputtime'], '', $content_info, 'add');
                $html->show($urls[1], $urls['data'], 0);
            }

            $this->con->set_model($modelid);
            $this->con->update(array('status' => 99), array('catid' => $catid));
            $this->content_check_db->delete_content(array('checkid' => $v));
            //$this->db->status($arr_checkid[1],'99');

        }
        showmessage(L('operation_success'), HTTP_REFERER);
    }

    public function xmgetinfo()
    {
        $this->dbte->selftb('v9_category');
        $id = trim($_POST['id']);
        if ($id) {
            $xmres = $this->dbte->get_one(array('catid' => $id));
            $xmres['catname'] = $xmres['catname'];
            $xmres['image'] = $xmres['image'];
            $xmres['touzijinhe'] = $xmres['touzijinhe'];
            $xmres['xinji'] = $xmres['xinji'];
            $xmres['url'] = APP_PATH . str_replace("/xm", "xm", $xmres['url']);
            echo json_encode($xmres);
        }
    }

    /**
     * 过审内容
     */
    public function pass()
    {
        $admin_username = param::get_cookie('admin_username');
        $this->content_check_db = pc_base::load_model('content_check_model');
        $catid = intval($_GET['catid']);

        if (!$catid) showmessage(L('missing_part_parameters'));
        $category = $this->categorys[$catid];
        $setting = string2array($category['setting']);
        $workflowid = $setting['workflowid'];
        //只有存在工作流才需要审核
        if ($workflowid) {
            $steps = intval($_GET['steps']);

            //检查当前用户有没有当前工作流的操作权限
            $workflows = getcache('workflow_' . $this->siteid, 'commons');
            $workflows = $workflows[$workflowid];
            $workflows_setting = string2array($workflows['setting']);
            //将有权限的级别放到新数组中
            $admin_privs = array();
            foreach ($workflows_setting as $_k => $_v) {
                if (empty($_v)) continue;
                foreach ($_v as $_value) {
                    if ($_value == $admin_username) $admin_privs[$_k] = $_k;
                }
            }
            if ($_SESSION['roleid'] != 1 && $steps && !in_array($steps, $admin_privs)) showmessage(L('permission_to_operate'));
            //更改内容状态
            if (isset($_GET['reject'])) {
                //退稿
                $status = 0;
            } else {
                //工作流审核级别
                $workflow_steps = $workflows['steps'];

                if ($workflow_steps > $steps) {
                    $status = $steps + 1;
                } else {
                    $status = 99;
                }
            }

            $modelid = $this->categorys[$catid]['modelid'];
            $this->db->set_model($modelid);
            //lison
            $vid = $_POST['ids'][0];
            $reject = $_GET['reject'];
            //echo $catid;exit;
            $cinfo = $this->db->get_one(array('id' => $vid));
            if (!$steps && !$reject) {//退稿时,reject=1为点击退稿，$steps为0时点击审核
                $this->content_check_db->update(array('catid' => $catid, 'siteid' => 1, 'title' => $cinfo['title'], 'username' => $_SESSION['sename_kk'], 'inputtime' => SYS_TIME, 'status' => 1), array('checkid' => $catid . '-' . $vid . '-' . $modelid));//数据，条件
            }
            if ($reject) {
                $this->content_check_db->update(array('status' => 0), array('checkid' => $catid . '-' . $vid . '-' . $modelid));
            }

            //var_dump($content_info);exit;
            $this->db->search_db = pc_base::load_model('search_model');
            //审核通过，检查投稿奖励或扣除积分
            if ($status == 99) {
                $html = pc_base::load_app_class('html', 'content');
                $this->url = pc_base::load_app_class('url', 'content');
                $member_db = pc_base::load_model('member_model');
                if (isset($_POST['ids']) && !empty($_POST['ids'])) {
                    foreach ($_POST['ids'] as $id) {
                        $content_info = $this->db->get_content($catid, $id);
                        //var_dump($content_info);exit;


                        $memberinfo = $member_db->get_one(array('username' => $content_info['username']), 'userid, username');
                        $flag = $catid . '_' . $id;
                        if ($setting['presentpoint'] > 0) {
                            pc_base::load_app_class('receipts', 'pay', 0);
                            receipts::point($setting['presentpoint'], $memberinfo['userid'], $memberinfo['username'], $flag, 'selfincome', L('contribute_add_point'), $memberinfo['username']);
                        } else {
                            pc_base::load_app_class('spend', 'pay', 0);
                            spend::point($setting['presentpoint'], L('contribute_del_point'), $memberinfo['userid'], $memberinfo['username'], '', '', $flag);
                        }
                        if ($setting['content_ishtml'] == '1') {//栏目有静态配置
                            $urls = $this->url->show($id, 0, $content_info['catid'], $content_info['inputtime'], '', $content_info, 'add');
                            // $html->show($urls[1],$urls['data'],0);
                            // var_dump($urls);
                            // var_dump($urls['data']);exit;
                        }
                        //更新到全站搜索
                        $inputinfo = '';
                        $inputinfo['system'] = $content_info;
                        $this->db->search_api($id, $inputinfo);
                        //凤森
                        //var_dump($id);exit;
                        $this->content_check_db->delete_content(array('checkid' => "$catid-$id-$modelid"));
                    }
                } else if (isset($_GET['id']) && $_GET['id']) {
                    $id = intval($_GET['id']);
                    $content_info = $this->db->get_content($catid, $id);
                    $memberinfo = $member_db->get_one(array('username' => $content_info['username']), 'userid, username');
                    $flag = $catid . '_' . $id;
                    if ($setting['presentpoint'] > 0) {
                        pc_base::load_app_class('receipts', 'pay', 0);
                        receipts::point($setting['presentpoint'], $memberinfo['userid'], $memberinfo['username'], $flag, 'selfincome', L('contribute_add_point'), $memberinfo['username']);
                    } else {
                        pc_base::load_app_class('spend', 'pay', 0);
                        spend::point($setting['presentpoint'], L('contribute_del_point'), $memberinfo['userid'], $memberinfo['username'], '', '', $flag);
                    }
                    //单篇审核，生成静态
                    if ($setting['content_ishtml'] == '1') {//栏目有静态配置
                        $urls = $this->url->show($id, 0, $content_info['catid'], $content_info['inputtime'], '', $content_info, 'add');
                        $html->show($urls[1], $urls['data'], 0);
                    }
                    //更新到全站搜索
                    $inputinfo = '';
                    $inputinfo['system'] = $content_info;
                    $this->db->search_api($id, $inputinfo);
                }
            }
            if (isset($_GET['ajax_preview'])) {
                $_POST['ids'] = $_GET['id'];
            }

            $this->db->status($_POST['ids'], $status);
            $this->content_check_db->delete_content(array('checkid' => "$catid-$id-$modelid"));
        }
        showmessage(L('operation_success'), HTTP_REFERER);
    }

    /**
     * 排序
     */
    public function listorder()
    {
        if (isset($_GET['dosubmit'])) {
            $catid = intval($_GET['catid']);
            if (!$catid) showmessage(L('missing_part_parameters'));
            $modelid = $this->categorys[$catid]['modelid'];
            $this->db->set_model($modelid);
            foreach ($_POST['listorders'] as $id => $listorder) {
                $this->db->update(array('listorder' => $listorder), array('id' => $id));
            }
            showmessage(L('operation_success'));
        } else {
            showmessage(L('operation_failure'));
        }
    }

    /**
     * 显示栏目菜单列表
     */
    public function public_categorys()
    {
        $this->aself = pc_base::load_model('aself_model');
        $this->aself->selftb("v9_category");
        $wherek = "`catid` < 1700";
        $cateres = $this->aself->select($wherek, '*', 12000);
        foreach ($cateres as $r) {
            $this->categorys[$r['catid']] = $r;
        }
        $categorys = $this->categorys[$catid];
        //var_dump($categorys); exit;
        $show_header = '';
        $cfg = getcache('common', 'commons');
        $ajax_show = intval($cfg['category_ajax']);
        $from = isset($_GET['from']) && in_array($_GET['from'], array('block')) ? $_GET['from'] : 'content';
        $tree = pc_base::load_sys_class('tree');
        if ($from == 'content' && $_SESSION['roleid'] != 1) {
            $this->priv_db = pc_base::load_model('category_priv_model');
            $priv_result = $this->priv_db->select(array('action' => 'init', 'roleid' => $_SESSION['roleid'], 'siteid' => $this->siteid, 'is_admin' => 1));
            $priv_catids = array();
            foreach ($priv_result as $_v) {
                $priv_catids[] = $_v['catid'];
            }
            if (empty($priv_catids)) return '';
        }       
        $_GET['menuid'] = intval($_GET['menuid']);
        $categorys = array();
        
        if (!empty($this->categorys)) {
            foreach ($this->categorys as $key => $r) {
                if ($key > 3000) continue;//@todo 这里限制了菜单条数,如果没找到的话就改改这里
                if ($r['siteid'] != $this->siteid || ($r['type'] == 2 && $r['child'] == 0)) continue;
                if ($from == 'content' && $_SESSION['roleid'] != 1 && !in_array($r['catid'], $priv_catids)) {
                    $arrchildid = explode(',', $r['arrchildid']);
                    $array_intersect = array_intersect($priv_catids, $arrchildid);
                    if (empty($array_intersect)) continue;
                }     
                
                if ($r['type'] == 1 || $from == 'block') {
                    // if ($r['type'] == 0) {
                    //     $r['vs_show'] = "<a href='?m=block&c=block_admin&a=public_visualization&menuid=" . $_GET['menuid'] . "&catid=" . $r['catid'] . "&type=show' target='right'>[" . L('content_page') . "]</a>";
                    // } else {
                    //     $r['vs_show'] = '';
                    // }
                    // $r['icon_type'] = 'file';
                    // $r['add_icon'] = '';
                    // $r['type'] = 'add';
                } else {                    
                    $r['icon_type'] = $r['vs_show'] = '';
                    $r['type'] = 'init';
                    $r['add_icon'] = "<a target='right' href='?m=content&c=content&menuid=" . $_GET['menuid'] . "&catid=" . $r['catid'] . "' onclick=javascript:openwinx('?m=content&c=content&a=add&menuid=" . $_GET['menuid'] . "&catid=" . $r['catid'] . "&hash_page=" . $_SESSION['hash_page'] . "','')><img src='" . IMG_PATH . "add_content.gif' alt='" . L('add') . "'></a> ";
                }
                
                //@todo
                $categorys[$r['catid']] = $r;         
            }
            // echo 22;exit;
        }
        if (!empty($categorys)) {
            $tree->init($categorys);
            switch ($from) {
                case 'block':
                    $strs = "<span class='\$icon_type'>\$add_icon<a href='?m=block&c=block_admin&a=public_visualization&menuid=" . $_GET['menuid'] . "&catid=\$catid&type=list' target='right'>\$catname</a> \$vs_show</span>";
                    $strs2 = "<img src='" . IMG_PATH . "folder.gif'> <a href='?m=block&c=block_admin&a=public_visualization&menuid=" . $_GET['menuid'] . "&catid=\$catid&type=category' target='right'>\$catname</a>";
                    break;

                default:
                    $strs = "<span class='\$icon_type'>\$add_icon<a href='?m=content&c=content&a=\$type&menuid=" . $_GET['menuid'] . "&catid=\$catid' target='right' onclick='open_list(this)'>\$catname</a></span>";
                    $strs2 = "<span class='folder'>\$catname</span>";

                    break;
            }
            $categorys = $tree->get_treeview(0, 'category_tree', $strs, $strs2, $ajax_show);
        } else {
            $categorys = L('please_add_category');
        }
        include $this->admin_tpl('category_tree');
        exit;
    }

    /**
     * 检查标题是否存在
     */
    public function public_check_title()
    {
        if ($_GET['data'] == '' || (!$_GET['catid'])) return '';
        $catid = intval($_GET['catid']);
        $modelid = $this->categorys[$catid]['modelid'];
        $this->db->set_model($modelid);
        $title = $_GET['data'];
        if (CHARSET == 'gbk') $title = iconv('utf-8', 'gbk', $title);
        $r = $this->db->get_one(array('title' => $title));
        if ($r) {
            exit('1');
        } else {
            exit('0');
        }
    }

    /**
     * 修改某一字段数据
     */
    public function update_param()
    {
        $id = intval($_GET['id']);
        $field = $_GET['field'];
        $modelid = intval($_GET['modelid']);
        $value = $_GET['value'];
        if (CHARSET != 'utf-8') {
            $value = iconv('utf-8', 'gbk', $value);
        }
        //检查字段是否存在
        $this->db->set_model($modelid);
        if ($this->db->field_exists($field)) {
            $this->db->update(array($field => $value), array('id' => $id));
            exit('200');
        } else {
            $this->db->table_name = $this->db->table_name . '_data';
            if ($this->db->field_exists($field)) {
                $this->db->update(array($field => $value), array('id' => $id));
                exit('200');
            } else {
                exit('300');
            }
        }
    }

    /**
     * 图片裁切
     */
    public function public_crop()
    {
        if (isset($_GET['picurl']) && !empty($_GET['picurl'])) {
            $picurl = $_GET['picurl'];
            $catid = intval($_GET['catid']);
            if (isset($_GET['module']) && !empty($_GET['module'])) {
                $module = $_GET['module'];
            }
            $show_header = '';
            include $this->admin_tpl('crop');
        }
    }

    /**
     * 相关文章选择
     */
    public function public_relationlist()
    {
        pc_base::load_sys_class('format', '', 0);
        $show_header = '';
        $model_cache = getcache('model', 'commons');
        if (!isset($_GET['modelid'])) {
            showmessage(L('please_select_modelid'));
        } else {
            $page = intval($_GET['page']);

            $modelid = intval($_GET['modelid']);
            $this->db->set_model($modelid);
            $where = '';
            if ($_GET['catid']) {
                $catid = intval($_GET['catid']);
                $where .= "catid='$catid'";
            }
            $where .= $where ? ' AND status=99' : 'status=99';

            if (isset($_GET['keywords'])) {
                $keywords = trim($_GET['keywords']);
                $field = $_GET['field'];
                if (in_array($field, array('id', 'title', 'keywords', 'description'))) {
                    if ($field == 'id') {
                        $where .= " AND `id` ='$keywords'";
                    } else {
                        $where .= " AND `$field` like '%$keywords%'";
                    }
                }
            }
            $infos = $this->db->listinfo($where, '', $page, 12);
            $pages = $this->db->pages;
            include $this->admin_tpl('relationlist');
        }
    }

    public function public_getjson_ids()
    {
        $modelid = intval($_GET['modelid']);
        $id = intval($_GET['id']);
        $this->db->set_model($modelid);
        $tablename = $this->db->table_name;
        $this->db->table_name = $tablename . '_data';
        $r = $this->db->get_one(array('id' => $id), 'relation');

        if ($r['relation']) {
            $relation = str_replace('|', ',', $r['relation']);
            $relation = trim($relation, ',');
            $where = "id IN($relation)";
            $infos = array();
            $this->db->table_name = $tablename;
            $datas = $this->db->select($where, 'id,title');
            foreach ($datas as $_v) {
                $_v['sid'] = 'v' . $_v['id'];
                if (strtolower(CHARSET) == 'gbk') $_v['title'] = iconv('gbk', 'utf-8', $_v['title']);
                $infos[] = $_v;
            }
            echo json_encode($infos);
        }
    }

    //文章预览
    public function public_preview()
    {
        $catid = intval($_GET['catid']);
        $id = intval($_GET['id']);

        if (!$catid || !$id) showmessage(L('missing_part_parameters'), 'blank');
        $page = intval($_GET['page']);
        $page = max($page, 1);
        // $CATEGORYS = getcache('category_content_' . $this->get_siteid(), 'commons');
        $this->dbte->selftb("v9_category");
        $cateres = $this->dbte->select("`ismenu`=1 and `catid` < 1700 or `catid` > 6155", '*', 12000);
        foreach ($cateres as $r) {
           $CATEGORYS[$r['catid']] = $r;
        }
        if (!isset($CATEGORYS[$catid]) || $CATEGORYS[$catid]['type'] != 0) showmessage(L('missing_part_parameters'), 'blank');
        define('HTML', true);
        $CAT = $CATEGORYS[$catid];

        $siteid = $CAT['siteid'];
        $MODEL = getcache('model', 'commons');
        $modelid = $CAT['modelid'];

        $this->db->table_name = $this->db->db_tablepre . $MODEL[$modelid]['tablename'];
        $r = $this->db->get_one(array('id' => $id));
        if (!$r) showmessage(L('information_does_not_exist'));
        $this->db->table_name = $this->db->table_name . '_data';
        $r2 = $this->db->get_one(array('id' => $id));
        $rs = $r2 ? array_merge($r, $r2) : $r;

        //再次重新赋值，以数据库为准
        $catid = $CATEGORYS[$r['catid']]['catid'];
        $modelid = $CATEGORYS[$catid]['modelid'];

        require_once CACHE_MODEL_PATH . 'content_output.class.php';
        $content_output = new content_output($modelid, $catid, $CATEGORYS);
        $data = $content_output->get($rs);
        extract($data);
        $CAT['setting'] = string2array($CAT['setting']);
        $template = $template ? $template : $CAT['setting']['show_template'];
        $allow_visitor = 1;
        //SEO
        $SEO = self::seokk($siteid, $catid, $title, $description);

        define('STYLE', $CAT['setting']['template_list']);
        if (isset($rs['paginationtype'])) {
            $paginationtype = $rs['paginationtype'];
            $maxcharperpage = $rs['maxcharperpage'];
        }
        $pages = $titles = '';
        if ($rs['paginationtype'] == 1) {
            //自动分页
            if ($maxcharperpage < 10) $maxcharperpage = 500;
            $contentpage = pc_base::load_app_class('contentpage');
            $content = $contentpage->get_data($content, $maxcharperpage);
        }
        if ($rs['paginationtype'] != 0) {
            //手动分页
            $CONTENT_POS = strpos($content, '[page]');
            if ($CONTENT_POS !== false) {
                $this->url = pc_base::load_app_class('url', 'content');
                $contents = array_filter(explode('[page]', $content));
                $pagenumber = count($contents);
                if (strpos($content, '[/page]') !== false && ($CONTENT_POS < 7)) {
                    $pagenumber--;
                }
                for ($i = 1; $i <= $pagenumber; $i++) {
                    $pageurls[$i][0] = 'index.php?m=content&c=content&a=public_preview&steps=' . intval($_GET['steps']) . '&catid=' . $catid . '&id=' . $id . '&page=' . $i;
                }
                $END_POS = strpos($content, '[/page]');
                if ($END_POS !== false) {
                    if ($CONTENT_POS > 7) {
                        $content = '[page]' . $title . '[/page]' . $content;
                    }
                    if (preg_match_all("|\[page\](.*)\[/page\]|U", $content, $m, PREG_PATTERN_ORDER)) {
                        foreach ($m[1] as $k => $v) {
                            $p = $k + 1;
                            $titles[$p]['title'] = strip_tags($v);
                            $titles[$p]['url'] = $pageurls[$p][0];
                        }
                    }
                }
                //当不存在 [/page]时，则使用下面分页
                $pages = content_pages($pagenumber, $page, $pageurls);
                //判断[page]出现的位置是否在第一位
                if ($CONTENT_POS < 7) {
                    $content = $contents[$page];
                } else {
                    if ($page == 1 && !empty($titles)) {
                        $content = $title . '[/page]' . $contents[$page - 1];
                    } else {
                        $content = $contents[$page - 1];
                    }
                }
                if ($titles) {
                    list($title, $content) = explode('[/page]', $content);
                    $content = trim($content);
                    if (strpos($content, '</p>') === 0) {
                        $content = '<p>' . $content;
                    }
                    if (stripos($content, '<p>') === 0) {
                        $content = $content . '</p>';
                    }
                }
            }
        }
        include template('content', $template);
        $pc_hash = $_SESSION['pc_hash'];
        $steps = intval($_GET['steps']);
        // echo "
        // <link href=\"".CSS_PATH."dialog_simp.css\" rel=\"stylesheet\" type=\"text/css\" />
        // <script language=\"javascript\" type=\"text/javascript\" src=\"".JS_PATH."dialog.js\"></script>
        // <script type=\"text/javascript\">art.dialog({lock:false,title:'".L('operations_manage')."',mouse:true, id:'content_m', content:'<span id=cloading ><a href=\'javascript:ajax_manage(1)\'>".L('passed_checked')."</a> | <a href=\'javascript:ajax_manage(2)\'>".L('reject')."</a> |　<a href=\'javascript:ajax_manage(3)\'>".L('delete')."</a></span>',left:'100%',top:'100%',width:200,height:50,drag:true, fixed:true});
        // function ajax_manage(type) {
        // 	if(type==1) {
        // 		$.get('?m=content&c=content&a=pass&ajax_preview=1&catid=".$catid."&steps=".$steps."&id=".$id."&pc_hash=".$pc_hash."');
        // 	} else if(type==2) {
        // 		$.get('?m=content&c=content&a=pass&ajax_preview=1&reject=1&catid=".$catid."&steps=".$steps."&id=".$id."&pc_hash=".$pc_hash."');
        // 	} else if(type==3) {
        // 		$.get('?m=content&c=content&a=delete&ajax_preview=1&dosubmit=1&catid=".$catid."&steps=".$steps."&id=".$id."&pc_hash=".$pc_hash."');
        // 	}
        // 	$('#cloading').html('<font color=red>".L('operation_success')."<span id=\"secondid\">2</span>".L('after_a_few_seconds_left')."</font>');
        // 	setInterval('set_time()', 1000);
        // 	setInterval('window.close()', 2000);
        // }
        // function set_time() {
        // 	$('#secondid').html(1);
        // }
        // </script>";
    }

    public function updatec()
    {
        $catid = $_POST['catid'];
        $this->aself = pc_base::load_model('aself_model');
        $this->aself->selftb("v9_category");
        $wherek = "`catid`=$catid";
        $cateres = $this->aself->get_one($wherek);
        if ($cateres) {
            $strs = explode(",", $cateres['arrchildid']);
        } else {
            $strs = 1111;
        }
        echo json_encode($strs);
        // retrun json_encode($strs);
    }

    /**
     * 审核所有内容
     */
    public function public_checkall()
    {
        $page = isset($_GET['page']) && intval($_GET['page']) ? intval($_GET['page']) : 1;

        $show_header = '';
        $workflows = getcache('workflow_' . $this->siteid, 'commons');
        $datas = array();
        $pagesize = 20;
        $sql = '';
        if (in_array($_SESSION['roleid'], array('1'))) { //echo 11;exit;
            $super_admin = 1;
            //$status = isset($_GET['status']) ? $_GET['status'] : -1;
            $status = isset($_GET['status']) ? $_GET['status'] : 1;
        } else { //echo 22;exit;
            $super_admin = 0;
            $status = isset($_GET['status']) ? $_GET['status'] : 1;
            if ($status == -1) $status = 1;
        }
        //echo 333;exit;
        if ($status > 4) $status = 4;
        $this->priv_db = pc_base::load_model('category_priv_model');;
        $admin_username = param::get_cookie('admin_username');
        if ($status == -1) {
            //$sql = "`status` NOT IN (99,0,-2) AND `siteid`=$this->siteid";
            $sql = "`status` NOT IN (99,0,-2)";
        } else {
            //$sql = "`status` = '$status' AND `siteid`=$this->siteid";
            $sql = "`status` = '$status'";
        }

        if ($status != 0 && !$super_admin) {
            //以栏目进行循环
            foreach ($this->categorys as $catid => $cat) {
                if ($cat['type'] != 0) continue;
                //查看管理员是否有这个栏目的查看权限。
                if (!$this->priv_db->get_one(array('catid' => $catid, 'siteid' => $this->siteid, 'roleid' => $_SESSION['roleid'], 'is_admin' => '1'))) {
                    continue;
                }
                //如果栏目有设置工作流，进行权限检查。
                $workflow = array();
                $cat['setting'] = string2array($cat['setting']);
                if (isset($cat['setting']['workflowid']) && !empty($cat['setting']['workflowid'])) {
                    $workflow = $workflows[$cat['setting']['workflowid']];
                    $workflow['setting'] = string2array($workflow['setting']);
                    $usernames = $workflow['setting'][$status];
                    if (empty($usernames) || !in_array($admin_username, $usernames)) {//判断当前管理，在工作流中可以审核几审
                        continue;
                    }
                }
                $priv_catid[] = $catid;
            }
            if (empty($priv_catid)) {
                $sql .= " AND catid = -1";
            } else {
                $priv_catid = implode(',', $priv_catid);
                $sql .= " AND catid IN ($priv_catid)";
            }
        }
//echo $sql;exit;
        $this->content_check_db = pc_base::load_model('content_check_model');
        $datas = $this->content_check_db->listinfo($sql, 'inputtime DESC', $page);
        $pages = $this->content_check_db->pages;
        include $this->admin_tpl('content_checkall');
    }

    /**
     * 批量移动文章
     */
    public function remove()
    {
        if (isset($_POST['dosubmit'])) {
            $this->content_check_db = pc_base::load_model('content_check_model');
            $this->hits_db = pc_base::load_model('hits_model');
            if ($_POST['fromtype'] == 0) {
                if ($_POST['ids'] == '') showmessage(L('please_input_move_source'));
                if (!$_POST['tocatid']) showmessage(L('please_select_target_category'));
                $tocatid = intval($_POST['tocatid']);
                $modelid = $this->categorys[$tocatid]['modelid'];
                if (!$modelid) showmessage(L('illegal_operation'));
                $ids = array_filter(explode(',', $_POST['ids']), "is_numeric");
                foreach ($ids as $id) {
                    $checkid = 'c-' . $id . '-' . $this->siteid;
                    $this->content_check_db->update(array('catid' => $tocatid), array('checkid' => $checkid));
                    $hitsid = 'c-' . $modelid . '-' . $id;
                    $this->hits_db->update(array('catid' => $tocatid), array('hitsid' => $hitsid));
                }
                $ids = implode(',', $ids);
                $this->db->set_model($modelid);
                $this->db->update(array('catid' => $tocatid), "id IN($ids)");
            } else {
                if (!$_POST['fromid']) showmessage(L('please_input_move_source'));
                if (!$_POST['tocatid']) showmessage(L('please_select_target_category'));
                $tocatid = intval($_POST['tocatid']);
                $modelid = $this->categorys[$tocatid]['modelid'];
                if (!$modelid) showmessage(L('illegal_operation'));
                $fromid = array_filter($_POST['fromid'], "is_numeric");
                $fromid = implode(',', $fromid);
                $this->db->set_model($modelid);
                $this->db->update(array('catid' => $tocatid), "catid IN($fromid)");
                $this->hits_db->update(array('catid' => $tocatid), "catid IN($fromid)");
            }
            showmessage(L('operation_success'), HTTP_REFERER);
            //ids
        } else {
            $show_header = '';
            $catid = intval($_GET['catid']);
            $modelid = $this->categorys[$catid]['modelid'];
            $tree = pc_base::load_sys_class('tree');
            $tree->icon = array('&nbsp;&nbsp;│ ', '&nbsp;&nbsp;├─ ', '&nbsp;&nbsp;└─ ');
            $tree->nbsp = '&nbsp;&nbsp;';
            $categorys = array();
            foreach ($this->categorys as $cid => $r) {
                if ($this->siteid != $r['siteid'] || $r['type']) continue;
                if ($modelid && $modelid != $r['modelid']) continue;
                $r['disabled'] = $r['child'] ? 'disabled' : '';
                $r['selected'] = $cid == $catid ? 'selected' : '';
                $categorys[$cid] = $r;
            }
            $str = "<option value='\$catid' \$selected \$disabled>\$spacer \$catname</option>";

            $tree->init($categorys);
            $string .= $tree->get_tree(0, $str);
            $str = "<option value='\$catid'>\$spacer \$catname</option>";
            $source_string = '';
            $tree->init($categorys);
            $source_string .= $tree->get_tree(0, $str);
            $ids = empty($_POST['ids']) ? '' : implode(',', $_POST['ids']);
            include $this->admin_tpl('content_remove');
        }
    }

    /**
     * 同时发布到其他栏目
     */
    public function add_othors()
    {
        $show_header = '';
        $sitelist = getcache('sitelist', 'commons');
        $siteid = $_GET['siteid'];
        include $this->admin_tpl('add_othors');

    }

    /**
     * 同时发布到其他栏目 异步加载栏目
     */
    public function public_getsite_categorys()
    {
        $siteid = intval($_GET['siteid']);
        $this->categorys = getcache('category_content_' . $siteid, 'commons');
        $models = getcache('model', 'commons');
        $tree = pc_base::load_sys_class('tree');
        $tree->icon = array('&nbsp;&nbsp;&nbsp;│ ', '&nbsp;&nbsp;&nbsp;├─ ', '&nbsp;&nbsp;&nbsp;└─ ');
        $tree->nbsp = '&nbsp;&nbsp;&nbsp;';
        $categorys = array();
        if ($_SESSION['roleid'] != 1) {
            $this->priv_db = pc_base::load_model('category_priv_model');
            $priv_result = $this->priv_db->select(array('action' => 'add', 'roleid' => $_SESSION['roleid'], 'siteid' => $siteid, 'is_admin' => 1));
            $priv_catids = array();
            foreach ($priv_result as $_v) {
                $priv_catids[] = $_v['catid'];
            }
            if (empty($priv_catids)) return '';
        }

        foreach ($this->categorys as $r) {
            if ($r['siteid'] != $siteid || $r['type'] != 0) continue;
            if ($_SESSION['roleid'] != 1 && !in_array($r['catid'], $priv_catids)) {
                $arrchildid = explode(',', $r['arrchildid']);
                $array_intersect = array_intersect($priv_catids, $arrchildid);
                if (empty($array_intersect)) continue;
            }
            $r['modelname'] = $models[$r['modelid']]['name'];
            $r['style'] = $r['child'] ? 'color:#8A8A8A;' : '';
            $r['click'] = $r['child'] ? '' : "onclick=\"select_list(this,'" . safe_replace($r['catname']) . "'," . $r['catid'] . ")\" class='cu' title='" . L('click_to_select') . "'";
            $categorys[$r['catid']] = $r;
        }
        $str = "<tr \$click >
					<td align='center'>\$id</td>
					<td style='\$style'>\$spacer\$catname</td>
					<td align='center'>\$modelname</td>
				</tr>";
        $tree->init($categorys);
        $categorys = $tree->get_tree(0, $str);
        echo $categorys;
    }

    public function public_sub_categorys()
    {
        $cfg = getcache('common', 'commons');
        $ajax_show = intval(abs($cfg['category_ajax']));
        $catid = intval($_POST['root']);
        $modelid = intval($_POST['modelid']);
        $this->categorys = getcache('category_content_' . $this->siteid, 'commons');
        $tree = pc_base::load_sys_class('tree');
        $_GET['menuid'] = intval($_GET['menuid']);
        if (!empty($this->categorys)) {
            foreach ($this->categorys as $r) {
                if ($r['siteid'] != $this->siteid || ($r['type'] == 2 && $r['child'] == 0)) continue;
                if ($from == 'content' && $_SESSION['roleid'] != 1 && !in_array($r['catid'], $priv_catids)) {
                    $arrchildid = explode(',', $r['arrchildid']);
                    $array_intersect = array_intersect($priv_catids, $arrchildid);
                    if (empty($array_intersect)) continue;
                }
                if ($r['type'] == 1 || $from == 'block') {
                    if ($r['type'] == 0) {
                        $r['vs_show'] = "<a href='?m=block&c=block_admin&a=public_visualization&menuid=" . $_GET['menuid'] . "&catid=" . $r['catid'] . "&type=show' target='right'>[" . L('content_page') . "]</a>";
                    } else {
                        $r['vs_show'] = '';
                    }
                    $r['icon_type'] = 'file';
                    $r['add_icon'] = '';
                    $r['type'] = 'add';
                } else {
                    $r['icon_type'] = $r['vs_show'] = '';
                    $r['type'] = 'init';
                    $r['add_icon'] = "<a target='right' href='?m=content&c=content&menuid=" . $_GET['menuid'] . "&catid=" . $r['catid'] . "' onclick=javascript:openwinx('?m=content&c=content&a=add&menuid=" . $_GET['menuid'] . "&catid=" . $r['catid'] . "&hash_page=" . $_SESSION['hash_page'] . "','')><img src='" . IMG_PATH . "add_content.gif' alt='" . L('add') . "'></a> ";
                }
                $categorys[$r['catid']] = $r;
            }
        }
        if (!empty($categorys)) {
            $tree->init($categorys);
            switch ($from) {
                case 'block':
                    $strs = "<span class='\$icon_type'>\$add_icon<a href='?m=block&c=block_admin&a=public_visualization&menuid=" . $_GET['menuid'] . "&catid=\$catid&type=list&pc_hash=" . $_SESSION['pc_hash'] . "' target='right'>\$catname</a> \$vs_show</span>";
                    break;

                default:
                    $strs = "<span class='\$icon_type'>\$add_icon<a href='?m=content&c=content&a=\$type&menuid=" . $_GET['menuid'] . "&catid=\$catid&pc_hash=" . $_SESSION['pc_hash'] . "' target='right' onclick='open_list(this)'>\$catname</a></span>";
                    break;
            }
            $data = $tree->creat_sub_json($catid, $strs);
        }
        echo $data;
    }

    /**
     * 一键清理演示数据
     */
    public function clear_data()
    {
        //清理数据涉及到的数据表

        if ($_POST['dosubmit']) {
            set_time_limit(0);
            $models = array('category', 'content', 'hits', 'search', 'position_data', 'video_content', 'video_store', 'comment');
            $tables = $_POST['tables'];
            if (is_array($tables)) {
                foreach ($tables as $t) {
                    if (in_array($t, $models)) {
                        if ($t == 'content') {
                            $model = $_POST['model'];
                            $db = pc_base::load_model('content_model');
                            //读取网站的所有模型
                            $model_arr = getcache('model', 'commons');
                            foreach ($model as $modelid) {
                                $db->set_model($modelid);
                                if ($r = $db->count()) { //判断模型下是否有数据
                                    $sql_file = CACHE_PATH . 'bakup' . DIRECTORY_SEPARATOR . 'default' . DIRECTORY_SEPARATOR . $model_arr[$modelid]['tablename'] . '.sql';
                                    $result = $data = $db->select();
                                    $this->create_sql_file($result, $db->db_tablepre . $model_arr[$modelid]['tablename'], $sql_file);
                                    $db->query('TRUNCATE TABLE `phpcms_' . $model_arr[$modelid]['tablename'] . '`');
                                    //开始清理模型data表数据
                                    $db->table_name = $db->table_name . '_data';
                                    $sql_file = CACHE_PATH . 'bakup' . DIRECTORY_SEPARATOR . 'default' . DIRECTORY_SEPARATOR . $model_arr[$modelid]['tablename'] . '_data.sql';
                                    $result = $db->select();
                                    $this->create_sql_file($result, $db->db_tablepre . $model_arr[$modelid]['tablename'] . '_data', $sql_file);
                                    $db->query('TRUNCATE TABLE `phpcms_' . $model_arr[$modelid]['tablename'] . '_data`');
                                    //删除该模型中在hits表的数据
                                    $hits_db = pc_base::load_model('hits_model');
                                    $hitsid = 'c-' . $modelid . '-';
                                    $result = $hits_db->select("`hitsid` LIKE '%$hitsid%'");
                                    if (is_array($result)) {
                                        $sql_file = CACHE_PATH . 'bakup' . DIRECTORY_SEPARATOR . 'default' . DIRECTORY_SEPARATOR . 'hits-' . $modelid . '.sql';
                                        $this->create_sql_file($result, $hits_db->db_tablepre . 'hits', $sql_file);
                                    }
                                    $hits_db->delete("`hitsid` LIKE '%$hitsid%'");
                                    //删除该模型在search中的数据
                                    $search_db = pc_base::load_model('search_model');
                                    $type_model = getcache('type_model_' . $model_arr[$modelid]['siteid'], 'search');
                                    $typeid = $type_model[$modelid];
                                    $result = $search_db->select("`typeid`=" . $typeid);
                                    if (is_array($result)) {
                                        $sql_file = CACHE_PATH . 'bakup' . DIRECTORY_SEPARATOR . 'default' . DIRECTORY_SEPARATOR . 'search-' . $modelid . '.sql';
                                        $this->create_sql_file($result, $search_db->db_tablepre . 'search', $sql_file);
                                    }
                                    $search_db->delete("`typeid`=" . $typeid);
                                    //Delete the model data in the position table
                                    $position_db = pc_base::load_model('position_data_model');
                                    $result = $position_db->select('`modelid`=' . $modelid . ' AND `module`=\'content\'');
                                    if (is_array($result)) {
                                        $sql_file = CACHE_PATH . 'bakup' . DIRECTORY_SEPARATOR . 'default' . DIRECTORY_SEPARATOR . 'position_data-' . $modelid . '.sql';
                                        $this->create_sql_file($result, $position_db->db_tablepre . 'position_data', $sql_file);
                                    }
                                    $position_db->delete('`modelid`=' . $modelid . ' AND `module`=\'content\'');
                                    //清理视频库与内容对应关系表
                                    if (module_exists('video')) {
                                        $video_content_db = pc_base::load_model('video_content_model');
                                        $result = $video_content_db->select('`modelid`=\'' . $modelid . '\'');
                                        if (is_array($result)) {
                                            $sql_file = CACHE_PATH . 'bakup' . DIRECTORY_SEPARATOR . 'default' . DIRECTORY_SEPARATOR . 'video_content-' . $modelid . '.sql';
                                            $this->create_sql_file($result, $video_content_db->db_tablepre . 'video_content', $sql_file);
                                        }
                                        $video_content_db->delete('`modelid`=\'' . $modelid . '\'');
                                    }
                                    //清理评论表及附件表，附件的清理为不可逆操作。
                                    //附件初始化
                                    //$attachment = pc_base::load_model('attachment_model');
                                    //$comment = pc_base::load_app_class('comment', 'comment');
                                    //if(module_exists('comment')){
                                    //$comment_exists = 1;
                                    //}
                                    //foreach ($data as $d) {
                                    //$attachment->api_delete('c-'.$d['catid'].'-'.$d['id']);
                                    //if ($comment_exists) {
                                    //$commentid = id_encode('content_'.$d['catid'], $d['id'], $model_arr[$modelid]['siteid']);
                                    //$comment->del($commentid, $model_arr[$modelid]['siteid'], $d['id'], $d['catid']);
                                    //}
                                    //}
                                }
                            }

                        } elseif ($t == 'comment') {
                            $comment_db = pc_base::load_model('comment_data_model');
                            for ($i = 1; ; $i++) {
                                $comment_db->table_name($i);
                                if ($comment_db->table_exists(str_replace($comment_db->db_tablepre, '', $comment_db->table_name))) {
                                    if ($r = $comment_db->count()) {
                                        $sql_file = CACHE_PATH . 'bakup' . DIRECTORY_SEPARATOR . 'default' . DIRECTORY_SEPARATOR . 'comment_data_' . $i . '.sql';
                                        $result = $comment_db->select();
                                        $this->create_sql_file($result, $comment_db->db_tablepre . 'comment_data_' . $i, $sql_file);
                                        $comment_db->query('TRUNCATE TABLE `phpcms_comment_data_' . $i . '`');
                                    }
                                } else {
                                    break;
                                }
                            }
                        } else {
                            $db = pc_base::load_model($t . '_model');
                            if ($r = $db->count()) {
                                $result = $db->select();
                                $sql_file = CACHE_PATH . 'bakup' . DIRECTORY_SEPARATOR . 'default' . DIRECTORY_SEPARATOR . $t . '.sql';
                                $this->create_sql_file($result, $db->db_tablepre . $t, $sql_file);
                                $db->query('TRUNCATE TABLE `phpcms_' . $t . '`');
                            }
                        }
                    }
                }
            }
            showmessage(L('clear_data_message'));
        } else {
            //读取网站的所有模型
            $model_arr = getcache('model', 'commons');
            include $this->admin_tpl('clear_data');
        }
    }

    /**
     * 备份数据到文件
     * @param $data array 备份的数据数组
     * @param $tablename 数据所属数据表
     * @param $file 备份到的文件
     */
    private function create_sql_file($data, $db, $file)
    {
        if (is_array($data)) {
            $sql = '';
            foreach ($data as $d) {
                $tag = '';
                $sql .= "INSERT INTO `" . $db . '` VALUES(';
                foreach ($d as $_f => $_v) {
                    $sql .= $tag . '\'' . addslashes($_v) . '\'';
                    $tag = ',';
                }
                $sql .= ');' . "\r\n";
            }
            file_put_contents($file, $sql);
        }
        return true;
    }

    public function public_searchpinpai()
    {
        $keyword = trim($_GET['keyword']);
        $cass = $this->categorys;
        $this->cate = pc_base::load_model('category_model');
        $page = isset($_GET['page']) && trim($_GET['page']) ? intval($_GET['page']) : 1;
        $dataw = $this->cate->listinfo("type=0 and modelid=1 and child=1 and ismenu=1 and catname LIKE '%$keyword%'", 'catid DESC', $page, 50);
        $pages = $this->cate->pages;
        include $this->admin_tpl('content_searchpinpai');

        // include $this->admin_tpl('content_listpingpai');
    }

    /**
     *菜谱页集合
     */
    public function caipu_add()
    {
        if (isset($_POST['dosubmit']) || isset($_POST['dosubmit_continue'])) {
            define('INDEX_HTML', true);
            if (isset($_POST['dosubmit'])) {
                $data['thumb'] = $_POST['info']['thumb'];
                $data['inputtime'] = time();
                $data['updatetime'] = time();
                $data['title'] = $_POST['info']['title'];
                $data['keywords'] = $_POST['info']['keywords'];
                $data['description'] = $_POST['info']['description'];
                $data['content'] = $_POST['info']['content'];
                $data['typeid'] = $_POST['info']['type'];
                $data['userid'] = $_SESSION['userid'];
                $this->dbte->selftb("v9_caipu");
                $res = $this->dbte->insert($data);
                if ($res) {
                    showmessage(L('add_success') . L('2s_close'), 'blank', '', '', 'function set_time() {$("#secondid").html(1);}setTimeout("set_time()", 500);setTimeout("window.close()", 1200);');
                } else {
                    showmessage(L('上传菜谱失败'), HTTP_REFERER);
                }
            } else {
                showmessage(L('非法地址'), HTTP_REFERER);
            }
        } else {
            $show_header = $show_dialog = $show_validator = '';
            //设置cookie 在附件添加处调用
            param::set_cookie('module', 'content');

            $catid = $_GET['catid'] = intval($_GET['catid']);

            param::set_cookie('catid', $catid);
            $this->aself = pc_base::load_model('aself_model');
            $this->aself->selftb("v9_category");
            $wherek = "`catid`=$catid";
            $cateres = $this->aself->select($wherek, '*', 12000);
            foreach ($cateres as $r) {
                $this->categorys[$r['catid']] = $r;
            }
            $category = $this->categorys[$catid];
            $modelid = $category['modelid'];
            //取模型ID，依模型ID来生成对应的表单
            require CACHE_MODEL_PATH . 'content_form.class.php';
            $content_form = new content_form($modelid, $catid, $this->categorys);
            $forminfos = $content_form->get();
            $formValidator = $content_form->formValidator;
            $setting = string2array($category['setting']);
            $workflowid = $setting['workflowid'];
            $workflows = getcache('workflow_' . $this->siteid, 'commons');
            $workflows = $workflows[$workflowid];
            $workflows_setting = string2array($workflows['setting']);
            $nocheck_users = $workflows_setting['nocheck_users'];
            $admin_username = param::get_cookie('admin_username');
            if (!empty($nocheck_users) && in_array($admin_username, $nocheck_users)) {
                $priv_status = true;
            } else {
                $priv_status = false;
            }
            $this->aself->selftb("v9_caiputype");
            $type = $this->aself->select("", '*', 12000);

            include $this->admin_tpl('content_add_dl');
        }
    }

    public function public_listCaipu()
    {
        $cass = $this->categorys;
        $this->dbte->selftb("v9_caipu");
        $page = isset($_GET['page']) && trim($_GET['page']) ? intval($_GET['page']) : 1;
        $dataw = $this->dbte->listinfo("", 'id DESC', $page, 50);
        $pages = $this->cate->pages;
        $this->dbte->selftb("v9_admin");
        foreach ($dataw as $k => $v) {
            $userid = $v['userid'];
            $res = $this->dbte->select(array('userid' => $userid), 'username');
            $dataw[$k]['userid'] = $res[0]['username'];
        }
        $this->dbte->selftb("v9_caiputype");
        foreach ($dataw as $key => $value) {
            $type = intval($value['typeid']);
            $res = $this->dbte->select(array('cfid' => $type), 'cfname');
            $dataw[$key]['typeid'] = $res[0]['cfname'];
        }
        include $this->admin_tpl('content_list_dl');
    }

    public function caipu_del()
    {
        $this->dbte->selftb("v9_caipu");
        $ids = $_POST['ids'];
        if ($ids) {
            foreach ($ids as $key => $r) {
                $info = $this->dbte->get_one(array('id' => $r));
                if ($info) {
                    @unlink($info['url']);
                    $res = $this->dbte->delete("`id`=$r");
                    if ($res) {
                        $isa = 2;
                    } else {
                        $isa = 1;
                    }
                }
            }
        } else {
            showmessage("未选择！", HTTP_REFERER, 1000);
        }
        if ($isa == 2) {
            $pc_hash = $_GET['pc_hash'];
            showmessage("删除成功！", "?m=content&c=content&a=public_listCaipu&pc_hash=$pc_hash", 1000);
        } else {
            showmessage("删除失败！", HTTP_REFERER, 1000);
        }
    }

    public function caipu_edit()
    {
        if (isset($_POST['dosubmit']) || isset($_POST['dosubmit_continue'])) {
            define('INDEX_HTML', true);
            $id = $_POST['info']['id'] = intval($_POST['id']);
            if (trim($_POST['info']['title']) == '') showmessage(L('title_is_empty'));
            $this->aself = pc_base::load_model('aself_model');
            $this->aself->selftb("v9_caipu");
            $data['id'] = $id;
            $data['thumb'] = $_POST['info']['thumb'];
            $data['updatetime'] = time();
            $data['title'] = $_POST['info']['title'];
            $data['keywords'] = $_POST['info']['keywords'];
            $data['description'] = $_POST['info']['description'];
            $data['content'] = $_POST['info']['content'];
            $data['typeid'] = $_POST['info']['type'];
            $res = $this->aself->update($data, array('id' => $id));
            if ($res) {
                if (isset($_POST['dosubmit'])) {
                    showmessage(L('update_success') . L('2s_close'), 'blank', '', '', 'function set_time() {$("#secondid").html(1);}setTimeout("set_time()", 500);setTimeout("window.close()", 1200);');
                } else {
                    showmessage(L('update_success'), HTTP_REFERER);
                }
            } else {
                showmessage(L('更新失败'), HTTP_REFERER);
            }
        } else {
            $show_header = $show_dialog = $show_validator = '';
            //从数据库获取内容
            $id = intval($_GET['id']);
            $catid = $_GET['catid'] = intval($_GET['catid']);
            $this->aself = pc_base::load_model('aself_model');
            $this->aself->selftb("v9_category");
            $wherek = "`ismenu`=1 and `catid`=$catid";
            $cateres = $this->aself->select($wherek, '*', 12000);
            foreach ($cateres as $r) {
                $this->categorys[$r['catid']] = $r;
            }
            $this->model = getcache('model', 'commons');
            // echo $catid;exit;
            param::set_cookie('catid', $catid);
            $category = $this->categorys[$catid];
            // var_dump($category);exit; //null
            $modelid = $category['modelid'];
            // var_dump($modelid);exit;
            $this->db->table_name = 'v9_caipu';
            $r = $this->db->get_one(array('id' => $id));
            $data = array_map('htmlspecialchars_decode', $r);
            require CACHE_MODEL_PATH . 'content_form.class.php';
            $content_form = new content_form($modelid, $catid, $this->categorys);

            $forminfos = $content_form->get($data);
            $formValidator = $content_form->formValidator;
            include $this->admin_tpl('content_edit_dl');
        }
        header("Cache-control: private");
    }
    function seokk($siteid, $catid = '', $title = '', $description = '', $keyword = '') {
        $this->aself= pc_base::load_model('aself_model');
        $this->aself->selftb("v9_category");
        $wherek="`catid`=$catid";
        $cateres=$this->aself->select($wherek,'*',12000);
        foreach ($cateres as $r) {
            $this->categoryskk[$r['catid']]=$r;
        }
        if (!empty($title))$title = strip_tags($title);
        if (!empty($description)) $description = strip_tags($description);
        if (!empty($keyword)) $keyword = str_replace(' ', ',', strip_tags($keyword));
        $cat = array();
        if (!empty($catid)) {
            $categorys =$this->categoryskk;
            $cat = $categorys[$catid];
            $cat['setting'] = string2array($cat['setting']);
        }
        $seo['site_title'] =isset($site['site_title']) && !empty($site['site_title']) ? $site['site_title'] : $site['name'];
        $seo['keyword'] = !empty($keyword) ? $keyword : $site['keywords'];
        $seo['description'] = isset($description) && !empty($description) ? $description : (isset($cat['setting']['meta_description']) && !empty($cat['setting']['meta_description']) ? $cat['setting']['meta_description'] : (isset($site['description']) && !empty($site['description']) ? $site['description'] : ''));
        $seo['title'] =  (isset($title) && !empty($title) ? $title.'' : '').(isset($cat['setting']['meta_title']) && !empty($cat['setting']['meta_title']) ? $cat['setting']['meta_title'].'' : (isset($cat['catname']) && !empty($cat['catname']) ? $cat['catname'].'' : ''));
        foreach ($seo as $k=>$v) {
            $seo[$k] = str_replace(array("\n","\r"),    '', $v);
        }
        return $seo;
    }

    /**
     * 创建手机wap链接.txt
     */
    function ajax_create_wap_url()
    {
        $where = 'catid>236 and type=0 and modelid=1';
        $data = '`catid`,`catname`';
        $limit = '';
        $order = 'catid asc';
        $group = '';
        $key = '';

        $this->db->table_name = "v9_category";

        $result = $this->db->select($where, $data, $limit, $order, $group, $key);

        $filename = PC_PATH . "../手机WAP链接.txt";

        $str = '';
        $num = 0;
        foreach ($result as $k => $v) {
            $str .= 'http://m.iv37.com/product/'.$v['catid'] .'.html' . "\r\n";
        }
        $num += count($result);

        $this->db->table_name = "v9_chuanyexueyuan";
        $result = $this->db->select();
        foreach ($result as $k => $v) {
            $str .= 'http://m.iv37.com/chuangyexueyuan/'.$v['id'] .'.html' . "\r\n";
        }
        $num += count($result);

        $this->db->table_name = "v9_pinpaizhixun";
        $result = $this->db->select();
        foreach ($result as $k => $v) {
            $str .= 'http://m.iv37.com/articleDetail/'.$v['id'] .'.html' . "\r\n";
        }
        $num += count($result);
        
        $this->db->table_name = "v9_shangjizixun";
        $result = $this->db->select();
        foreach ($result as $k => $v) {
            $str .= 'http://m.iv37.com/articleDetails/'.$v['id'] .'.html' . "\r\n";
        }
        $num += count($result);

        file_put_contents($filename, $str);

        echo '操作成功;共有链接:'.$num.'条';


    }


}

?>