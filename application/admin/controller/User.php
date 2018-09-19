<?php
namespace app\admin\controller;

use app\common\model\User as UserModel;
use app\common\controller\AdminBase;
use think\Db;
use app\common\model\Recharge;
use app\common\model\Deposit_type;
//use think\Session;
/**
 * 用户管理
 * Class AdminUser
 * @package app\admin\controller
 */
class User extends AdminBase
{
    protected $user_model;

    protected function _initialize()
    {
        parent::_initialize();
        $this->user_model = new UserModel();
    }

    /**
     * 用户管理
     * @param string $keyword
     * @param int    $page
     * @return mixed
     */
    public function index($keyword = '', $page = 1)
    {
        $map = [];
        if ($keyword) {
            $map['a.username|a.mobile'] = ['like', "%{$keyword}%"];
        }
        $user_list=DB::name('user')->order('id DESC')->paginate(10, false, ['page' => $page]);
//        $user_list = DB::name('user')->alias('a')->join('think_deposit_type b','a.type=b.id')->where($map)->field('a.id,a.username,a.mobile,a.balance,a.create_time,a.last_time,b.name,a.wx_code')->order('a.id DESC')->paginate(10, false, ['page' => $page]);
        return $this->fetch('index', ['user_list' => $user_list, 'keyword' => $keyword]);
    }

    /**
     * 添加用户
     * @return mixed
     */
    public function add()
    {
        $deposit_type=DB::name('deposit_type')->where('statue',1)->select();
        $pay=DB::name('pay')->select();
        $project=DB::name('project')->where('statue','1')->select();
        return $this->fetch('add',['deposit_type'=>$deposit_type,'pay'=>$pay,'project'=>$project]);
    }
    /**
     * 保存用户
     */
    public function save()
    {
        if ($this->request->isPost()) {
            $cost=0;
            $data            = $this->request->post();
            if(isset($data['consume'])){
                $res=$this->cheakBill($data,'consume','bill');
                if($res['code']==2){
                    $this->error('勾选的免单项目不在消费项目中');
                }else{
                    $cost=$res['cost'];
                }
            }
            $class=new Deposit_type();
//            判断充值金额是否合法
            if($data['type']>0){
                $deposit=$class->getone($data['type']);
                if($data['money']==$deposit['premoney']){
                   $balance=$deposit['money'];
                }else{
                    $this->error('充值金额和所选套餐不匹配');
                }
            }else{
                $balance=$data['money'];

            }
            $validate_result = $this->validate($data, 'User');
            if ($validate_result !== true) {
                $this->error($validate_result);
            } else {
                $user['username']=$data['username'];
                $user['mobile']=$data['mobile'];
                $user['wx_code']=$data['wx_code'];
                $user['mark']=$data['mark'];
                $user['balance']=$balance-$cost;
                $class=new Recharge();
                Db::startTrans();
                try{
                    $this->user_model->save($user);
                    if(isset($data['consume'])){
                        $list=$this->consumeData($this->user_model->id,$data,'consume','bill');
                        Db::name('consume')->insertAll($list);
                    }
                    $class->insertdata($this->user_model->id,$data['money'],$data['type'],$data['pay']);
                    // 提交事务
                    Db::commit();
                } catch (\Exception $e) {
                    // 回滚事务
                    $this->error('保存失败');
                    Db::rollback();
                }
                $this->success('保存成功');
//                if ($this->user_model->save($user)) {
//                    $this->success('保存成功');
//                } else {
//                    $this->error('保存失败');
//                }
            }
        }
    }

    /*
     * 查看用户消费记录
     *
     * */
        public function userbill($id,$page = 1,$keyword=''){
            $map['a.id']=$id;
            if ($keyword) {
                $map['c.name'] = ['like', "%{$keyword}%"];
            }
            $list=DB::name('user')->alias('a')->join('think_consume b','b.user_id=a.id')->join('think_project c','c.id=b.project')->where($map)->field('a.username,a.mobile,b.no_bill,b.creat_time,b.mark,c.name,c.money')->order('b.creat_time DESC')->paginate(10, false, ['page' => $page]);
            return $this->fetch('userbill', ['list' => $list,'keyword'=>$keyword,'id'=>$id]);
        }
    /*
     * 添加用户账单
     *
     *
     * */
    public function addbill($id){
        $project=DB::name('project')->where('statue','1')->select();
        $user=$this->user_model->find($id);
        return $this->fetch('addbill',['project'=>$project,'user'=>$user,'id'=>$id]);
    }
    /*
     * 保存账单
     *
     * */
    public function savebill($id){
        if($this->request->isPost()){
            $data=$this->request->post();
            if(!isset($data['consume'])){
                $this->error('未勾选消费项目');
            }
            $res=$this->cheakBill($data,'consume','bill');
            /*判断消费项目和勾选项目是否合法*/
            if($res['code']==2){
                $this->error('勾选的免单项目不在消费项目中');
            }
            $balance=$this->user_model->where('id',$id)->value('balance');
            $balance-=$res['cost'];
            if($balance<0){
                $this->error('卡内余额不足，请充值');
            }
            $list=$this->consumeData($id,$data,'consume','bill');
//            $this->user_model->save(['balance'=>$balance],['id'=>$id]);
//            DB::name('consume')->insertAll($list);
            Db::startTrans();
            try{
                $this->user_model->save(['balance'=>$balance],['id'=>$id]);
                DB::name('consume')->insertAll($list);
                // 提交事务
                Db::commit();
            } catch (\Exception $e) {
                // 回滚事务
                $this->error('保存失败');
                Db::rollback();
            }
            $this->success('保存成功',url('admin/user/userbill',['id'=>$id]));
        }
    }

    /**
     * 编辑用户
     * @param $id
     * @return mixed
     */
    public function edit($id)
    {
        $user = $this->user_model->find($id);
        $pay=DB::name('pay')->select();
        $deposit_type=DB::name('deposit_type')->select();
        return $this->fetch('edit', ['user' => $user,'deposit_type'=>$deposit_type,'pay'=>$pay]);
    }

    /**
     * 更新用户
     * @param $id
     */
    public function update($id)
    {
        if ($this->request->isPost()) {
            $data            = $this->request->post();
            $validate_result = $this->validate($data, 'User');
            if ($validate_result !== true) {
                $this->error($validate_result);
            } else {
                //            判断充值金额是否合法
                $class=new Deposit_type();
                if($data['type']>0){
                    $Deposit_data=$class->getone($data['type']);
                    if($data['recharge']!=$Deposit_data['premoney']){
                        $this->error('充值金额和所选套餐不匹配');
                    }else{
                        $money=$class->getmoney($data['type']);

                    }
                }else{
                    $money=$data['recharge'];
                }
                $user           = $this->user_model->find($id);
                $user->id       = $id;
                $user->username = $data['username'];
                $user->mobile   = $data['mobile'];
                $user->wx_code   = $data['wx_code'];
                $user->balance=$user['balance']+$money;
                if($data['recharge']&&$data['recharge']>0){
                    $recharge['money']=$data['recharge'];
                    $recharge['type']=isset($data['type'])?$data['type']:0;
                    $recharge['pay']=isset($data['pay'])?$data['pay']:1;
                    $recharge['user_id']=$id;
                    try{
                        $user->save();
                        DB::name('recharge')->insert($recharge);
                        DB::name('recharge')->insert($recharge);
                        // 提交事务
                        Db::commit();
                    } catch (\Exception $e) {
                        // 回滚事务
                        $this->error('保存失败');
                        Db::rollback();
                    }

                    $this->success('更新成功');
                }else{
                    if ($user->save() !== false) {
                        $this->success('更新成功');
                    } else {
                        $this->error('更新失败');
                    }
                }

            }
        }
    }

    /**
     * 删除用户
     * @param $id
     */
    public function delete($id)
    {
        if ($this->user_model->destroy($id)) {
            $this->success('删除成功');
        } else {
            $this->error('删除失败');
        }
    }
/*
 *核查项目是否免单
 * $array 要判断的数据
 * str1 下标1 str2 下标表2
 * code=0 全部免单 code=1 部分免单 code=2 勾选的免单项目不在消费项目中
 * */
    function cheakBill($array,$str1,$str2){
        $res['code']=1; /*默认不全部面单*/
        $cost='';
        $price=[];
        $project=DB::name('project')->select();
        foreach ($project as $kk=>$vv){
            $price[$vv['id']]=$vv['money'];
        }
       if(isset($array[$str2])){
            if($array[$str1]==$array[$str2]){
                $res['code']=0; /*全部免单*/
                $res['cost']=0;
                return $res;
            }

            $result=array_diff_assoc($array[$str2],$array[$str1]);
            if(!empty($result)){
                $res['code']=2;
                return $res;
            }
            foreach ($result as $k=>$v){
                $cost+=$price[$v];
            }
            $res['cost']=$cost;
            return $res;
        }else{
            foreach ($array[$str1] as $key=>$vo){
                $cost+=$price[$vo];
            }
           $res['cost']=$cost;
           return $res;
        }

    }
/*
 * return 计算出充值首次消费的余额
 * */
//    public function cheakBalance($id='1', $cost=0){
//        $moeny=DB::name('deposit_type')->where('id',$id)->value('money');
//        $balance=$moeny-$cost;
//        return $balance;
//    }

/*
 * 整合插入到消费记录表中的数组
 *$id 用户id $arr1 消费项目，$arr2 免单项目
 * */
    public function consumeData($id,$data,$str1,$str2='')
    {
        $now=date('Y-m-d');
        $consume = $data[$str1];
        $list = [];
        $re=$this->getcyc();
        if (isset($data[$str2])) {
            $bill = $data[$str2];
            $result = array_diff_assoc($consume, $bill);
            foreach ($consume as $k => $v) {
                $arr['user_id'] = $id;
                $arr['project'] = $v;
                $arr['cyctime'] = date('Y-m-d',strtotime($re[$v] ."day"));
                if (array_key_exists($k, $result)) {
                    $arr['no_bill'] = 1;/*不免单*/

                } else {
                    $arr['no_bill'] = 0;/*免单*/
                }
                $list[] = $arr;
            }
        }else{
            foreach ($consume as $kk=>$vv){
                $arr['user_id'] = $id;
                $arr['project'] = $vv;
                $arr['no_bill'] = 1;
                $arr['cyctime'] = date('Y-m-d',strtotime($re[$vv] ."day"));
                $list[] = $arr;
            }
        }
        return $list;
    }

    /*
     * 获取项目id对应的周期
     * */
    public function getcyc(){

        $cyc=DB::name('project')->select();
        $re=[];
        foreach ($cyc as $k=>$v){
            $re[$v['id']]=$v['cyc'];
        }
        return $re;

    }

    /*
     *
     *
     * */

    public function test(){
     $class=new Deposit_type();
     halt($class->getone(1));
    }

}