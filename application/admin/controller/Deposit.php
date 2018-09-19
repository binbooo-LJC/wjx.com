<?php
namespace app\admin\controller;

use app\common\model\Deposit_type as DepositModel;
use app\common\controller\AdminBase;
use think\Db;
/**
 * 文章管理
 * Class Article
 * @package app\admin\controller
 */
class deposit extends AdminBase
{

    protected  $deposite_model;
    protected function _initialize()
    {
        parent::_initialize();
        $this->deposite_model  = new DepositModel();
    }

    /**
     * 文章管理
     * @param int    $cid     分类ID
     * @param string $keyword 关键词
     * @param int    $page
     * @return mixed
     */
    public function index()
    {
        $list=$this->deposite_model->depositeList();
        return $this->fetch('index',['list'=>$list]);

    }

    /**
     * 添加文章
     * @return mixed
     */
    public function add()
    {
        return $this->fetch();
    }

    /**
     * 保存文章
     */
    public function save()
    {
        if ($this->request->isPost()) {
            $data            = $this->request->param();
            $validate_result = $this->validate($data, 'Deposit');

            if ($validate_result !== true) {
                $this->error($validate_result);
            } else {
                if ($this->deposite_model->allowField(true)->save($data)) {
                    $this->success('保存成功');
                } else {
                    $this->error('保存失败');
                }
            }
        }
    }

    /**
     * 编辑文章
     * @param $id
     * @return mixed
     */
    public function edit($id)
    {
        $deposit = $this->deposite_model->find($id);

        return $this->fetch('edit', ['deposit' => $deposit]);
    }

    /**
     * 更新文章
     * @param $id
     */
    public function update($id)
    {
        if ($this->request->isPost()) {
            $data            = $this->request->param();
            $validate_result = $this->validate($data, 'Deposit');
            if ($validate_result !== true) {
                $this->error($validate_result);
            } else {
                if ($this->deposite_model->allowField(true)->save($data, $id) !== false) {
                    $this->success('更新成功');
                } else {
                    $this->error('更新失败');
                }
            }
        }
    }

    /**
     * 删除文章
     * @param int   $id
     * @param array $ids
     */
    public function delete($id = 0)
    {
        $conut=Db::name('recharge')->where('type',$id)->count();
        if($conut>0){
            $this->error('会员充值过该套餐不能删除，请选择弃用');
        }else{
            if ($this->deposite_model->destroy($id)) {
                $this->success('删除成功');
            } else {
                $this->error('删除失败');
            }
        }
    }

    /**
     * 文章审核状态切换
     * @param array  $ids
     * @param string $type 操作类型
     */
    public function toggle($ids = [], $type = '')
    {
        $data   = [];
        $status = $type == 'audit' ? 1 : 0;

        if (!empty($ids)) {
            foreach ($ids as $value) {
                $data[] = ['id' => $value, 'status' => $status];
            }
            if ($this->deposite_model->saveAll($data)) {
                $this->success('操作成功');
            } else {
                $this->error('操作失败');
            }
        } else {
            $this->error('请选择需要操作的文章');
        }
    }
}