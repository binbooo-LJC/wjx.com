<?php
namespace app\admin\controller;

use think\Controller;
use think\Db;
use sms\Sms as Message;
class Sms extends Controller{
    protected $str= "尊敬的%s用户对您的产品很感兴趣，请及时联系【金子美妍】";
    public function index($id){
        $map['a.id']=$id;
        $user_info=Db::name('consume')->alias('a')->join('think_user b','a.user_id=b.id')->join('think_project c','a.project=c.id')->where($map)->field('a.creat_time,b.username,c.name,c.cyc,b.mobile')->find();
        if($user_info){
            $class=new Message(array('api_key' => 'c24b2635d052b39b5025811688869a8c' , 'use_ssl' => FALSE ));
//           $str= "尊敬的%s您好，您于上次%s做的%s项目建议周期为%s天一次，抽空请和我预约【金子美妍】";
           $sendmsg= sprintf($this->str,$user_info['mobile']);
            $res = $class->send( $user_info['mobile'], $sendmsg);
            if( $res ){
                if( isset( $res['error'] ) &&  $res['error'] == 0 ){
                  $data['mobile']=$user_info['mobile'];
                  $data['consumeId']=$id;
                    if(DB::name('sms')->insert($data)){
                        $this->success('发送成功');
                    }else{
                        $this->error('发送失败');
                    }
                }else{
                    $this->error('failed,code:'.$res['error'].',msg:'.$res['msg']);

                }
            }else{
                $this->error($class->last_error());
            }
        }

    }
    public function toggle($ids=[]){
        $map['a.id']=['in',$ids];
        $user_info=Db::name('consume')->alias('a')->join('think_user b','a.user_id=b.id')->join('think_project c','a.project=c.id')->where($map)->field('a.id,a.creat_time,b.username,c.name,c.cyc,b.mobile')->select();
        if($user_info){
            $mobile_list='';
            $class=new Message(array('api_key' => 'c24b2635d052b39b5025811688869a8c' , 'use_ssl' => FALSE ));
            foreach ($user_info as $k=>$v){
                $sendmsg= sprintf($this->str,$v['username'],$v['creat_time'],$v['name'],$v['cyc']);
                $res = $class->send( $v['mobile'], $sendmsg);
                if($res){
                    if( isset( $res['error'] ) &&  $res['error'] == 0 ){
                        $data['mobile']=$v['mobile'];
                        $data['consumeId']=$v['id'];
                        if(!DB::name('sms')->insert($data)){
                            $mobile_list=$mobile_list.$v['id'].',';
                        }
                    }else{
                        $mobile_list=$mobile_list.$v['id'].',';
                    }
                }
            }
            if(!$mobile_list){
                $this->success('发送成功');
            }
            $this->success('id为'.$mobile_list.'发送失败');
        }

    }

    public function test(){
        halt(fileGetconetnt());
        $url = 'http://api01.monyun.cn:7901/sms/v2/std/';
        $message=new Message($url);
        $data=array();
//设置账号(必填)
        $data['userid']='E104RV';
//设置密码（必填.填写明文密码,如:1234567890）
        $data['pwd']='iUcW3R';
///////////////////////////////////////////////////////////////////////////////////

        /*
        * 单条发送 接口调用
        */
// 设置手机号码 此处只能设置一个手机号码(必填)
        $data['mobile']='13366659939';
//设置发送短信内容(必填)
        $data['content']='验证码：6666，打死都不要告诉别人哦！';
// 业务类型(可选)
        $data['svrtype']='';
// 设置扩展号(可选)
        $data['exno']='';
//用户自定义流水编号(可选)
        $data['custid']='';
// 自定义扩展数据(可选)
        $data['exdata']='';
        try {
            $result = $message->singleSend($data);
            if ($result['result'] === 0) {
                print_r("单条信息发送成功！");
            } else {
                print_r("单条信息发送失败，错误码：" . $result['result']);
            }
        }catch (Exception $e) {
            print_r($e->getMessage());//输出捕获的异常消息，请根据实际情况，添加异常处理代码
            return false;
        }
    }
}
