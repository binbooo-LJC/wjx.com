<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2018/7/16
 * Time: 15:42
 */

namespace app\common\model;


use think\Model;
use think\Db;
class Recharge extends Model
{
    protected $tables='recharge';

    /*
     * 插入数据
     * */
    public function insertdata($user,$money,$type,$pay){
        $data=['user_id'=>$user,'money'=>$money,'type'=>$type,'pay'=>$pay];
        $re=DB::name($this->tables)->insert($data);
        return $re;
    }
}