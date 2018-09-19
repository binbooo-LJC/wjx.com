<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2018/7/16
 * Time: 17:16
 */

namespace app\common\model;
use think\Model;
use think\Db;
class deposit_type extends Model
{
    protected $tables='deposit_type';
    public function getone($id){
        $re=Db::name($this->tables)->where('statue',1)->find($id);
        return $re;
    }
    public function getmoney($type){
        $money=Db::name($this->tables)->where(['id'=>$type,'statue'=>1])->value('money');
        return $money;
    }

    /*
     * return array 充值列表
     * */
    public function depositeList(){
        $re=Db($this->tables)->order(['statue'=>'desc','id'])->select();
        return $re;
    }
}