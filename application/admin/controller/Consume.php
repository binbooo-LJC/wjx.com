<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2018/7/12
 * Time: 17:17
 */
namespace app\admin\controller;
use app\common\model\Consume as ConsumeModel;
use app\common\controller\AdminBase;
use think\Db;
class Consume extends AdminBase{
    protected $consume_model;

    protected function _initialize()
    {
        parent::_initialize();
        $this->consume_model = new ConsumeModel();
    }

    public function index($keyword='',$date='',$page=1){
        $map=[];
        if($keyword){
            $map['b.username|b.mobile']=['like', "%{$keyword}%"];
        }
        if(!$date){
            $date=date('Y-m-d');
        }
        $map['date_format(a.creat_time ,"%Y-%m-%d")']=$date;
        $list=Db('consume')->alias('a')->join('think_user b','a.user_id=b.id','left')->join('think_project c','a.project=c.id','left')->where($map)->field('a.id,b.username,a.no_bill,a.creat_time,a.mark,b.mobile,c.name project_name,c.money')->order('a.creat_time desc,a.id')->paginate(40, false, ['page' => $page]);
        return $this->fetch('index',['list'=>$list,'keyword'=>$keyword,'date'=>$date]);
    }

    public function sms($keyword='',$statue='',$page=1){
//        halt('2018-07-20'>'2018-07-13');
        $map=[];
        if($keyword){
            $map['b.username|b.mobile']=['like', "%{$keyword}%"];
        }
        if($statue){
           $num=10;
        }else{
            $num=0;
        }
        $now=date('Y-m-d');
//        halt('2017-01-02'+'7');
        $map['date_format(a.cyctime ,"%Y-%m-%d")']=['<',$now];
        $list=DB::name('consume')->alias('a')->join('think_user b','a.user_id=b.id')->join('think_project d','a.project=d.id')->join('think_sms e','a.id=e.consumeId','left')->where($map)->field(' a.id,b.username,b.mobile,a.cyctime ,a.creat_time,a.project,d.name project_name,d.cyc,count(e.id) smsNum')->group('a.user_id,a.creat_time,a.project')->order('count(e.id) ,a.id')-> having(
            "count(e.id)<=$num")->paginate(40, false, ['page' => $page]);
//        halt(DB::name('consume')->getLastSql());
//        halt($list);
        return $this->fetch('sms',['list'=>$list,'keyword'=>$keyword,'statue'=>$statue]);
    }
    public function smstotel(){
        $now=date('Y-m-d');
//        halt('2017-01-02'+'7');
        $map['date_format(a.cyctime ,"%Y-%m-%d")']=['<',$now];
        $num=DB::name('consume')->alias('a')->join('think_user b','a.user_id=b.id')->join('think_project d','a.project=d.id')->join('think_sms e','a.id=e.consumeId','left')->where($map)->field(' a.id,b.username,b.mobile,a.cyctime ,a.creat_time,a.project,d.name project_name,d.cyc,count(e.id) smsNum')->group('a.user_id,a.creat_time,a.project')->order('count(e.id) ,a.id')-> having(
            "count(e.id)<=0")->select();
       return count($num);
    }

}