<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2018/7/16
 * Time: 11:31
 */

namespace app\common\model;


use think\Model;
use think\Db;
class Project extends Model
{
     protected  $tables='project';
/*
 * 组装数组
 * return array ['name']=>['moeny'];
 * */
     public function getprice(){
        $re=[];
        $consume=DB::name($this->tables)->where('statue',1)->select();
        foreach ($consume as $k=>$v){
          $re[$v['name']]=$v['money'];
        }
        return $re;
    }
    /*
     * 获取项目列表
     * return array
     * */
     public function projectList(){
         $re=Db::name($this->tables)->order(['statue'=>'desc','id'])->select();
         return $re;
     }
     /*
      * 获取一条项目信息
      * */
     public function getone($id){
         $re=Db::name($this->tables)->find($id);
         return $re;
     }

     /*
      * 更新数据
      * */
      public function saveone($data){

      }
}
