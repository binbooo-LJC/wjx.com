<?php
namespace app\admin\controller;

use app\common\model\Recharge as RechargeModel;
use app\common\controller\AdminBase;
use think\Db;

/**
 * 轮播图管理
 * Class Slide
 * @package app\admin\controller
 */
class Recharge extends AdminBase
{
    protected $recharge_model;
    protected function _initialize()
    {
        parent::_initialize();
        $this->recharge_model=new RechargeModel;
    }

    /**
     * 轮播图管理
     * @return mixed
     */
    public function index($keyword='',$date='',$page=1)
    {
        $map=[];

        if($keyword){
            $map['b.username|b.mobile']=['like', "%{$keyword}%"];
        }
        if(!$date){
            $date=date('Y-m');
        }
        $map['date_format(a.time,"%Y-%m")']=$date;
//        $sql= "SELECT a.id,a.money,a.time,a.type,b.username,b.mobile,c.name deposit,d.name FROM think_recharge a LEFT JOIN think_user b ON a.user_id=b.id LEFT JOIN think_deposit_type c ON a.type=c.id LEFT JOIN think_pay d ON a.pay=d.id WHERE  ( b.username LIKE '%l%' OR b.mobile LIKE '%l%' ) ORDER BY a.time  desc LIMIT 0,15'";

       $list=DB::name('recharge')->alias('a')->join('think_user b','a.user_id=b.id','left')->join('think_deposit_type c','a.type=c.id','left')->join('think_pay d','a.pay=d.id','left')->where($map)->field('a.id,a.money, a.time ,a.type,b.username,b.mobile,c.name deposit,d.name')->order('a.time','desc')->paginate(40, false, ['page' => $page]);
        $sum=DB::name('recharge')->alias('a')->join('think_user b','a.user_id=b.id','left')->join('think_deposit_type c','a.type=c.id','left')->join('think_pay d','a.pay=d.id','left')->where($map)->field('a.id,a.money, a.time ,a.type,b.username,b.mobile,c.name deposit,d.name')->sum('a.money');
        return $this->fetch('index', ['list' => $list,'keyword'=>$keyword,'sum'=>$sum,'date'=>$date]);
    }

    /**
     * 添加轮播图
     * @return mixed
     */
    public function add()
    {
        $slide_category_list = SlideCategoryModel::all();

        return $this->fetch('add', ['slide_category_list' => $slide_category_list]);
    }

    /**
     * 保存轮播图
     */
    public function save()
    {
        if ($this->request->isPost()) {
            $data            = $this->request->param();
            $validate_result = $this->validate($data, 'Slide');

            if ($validate_result !== true) {
                $this->error($validate_result);
            } else {
                $slide_model = new SlideModel();
                if ($slide_model->allowField(true)->save($data)) {
                    $this->success('保存成功');
                } else {
                    $this->error('保存失败');
                }
            }
        }
    }

    /**
     * 编辑轮播图
     * @param $id
     * @return mixed
     */
    public function edit($id)
    {
        $slide_category_list = SlideCategoryModel::all();
        $slide               = SlideModel::get($id);

        return $this->fetch('edit', ['slide' => $slide, 'slide_category_list' => $slide_category_list]);
    }

    /**
     * 更新轮播图
     * @param $id
     */
    public function update($id)
    {
        if ($this->request->isPost()) {
            $data            = $this->request->param();
            $validate_result = $this->validate($data, 'Slide');

            if ($validate_result !== true) {
                $this->error($validate_result);
            } else {
                $slide_model = new SlideModel();
                if ($slide_model->allowField(true)->save($data, $id) !== false) {
                    $this->success('更新成功');
                } else {
                    $this->error('更新失败');
                }
            }
        }
    }

    /**
     * 删除轮播图
     * @param $id
     */
    public function delete($id)
    {
        if (SlideModel::destroy($id)) {
            $this->success('删除成功');
        } else {
            $this->error('删除失败');
        }
    }
}