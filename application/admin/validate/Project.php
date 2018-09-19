<?php
namespace app\admin\validate;

use think\Validate;

class Project extends Validate
{
    protected $rule = [
        'name' => 'require',
        'money' => 'require|number|gt:0',
        'cyc'  =>'number|egt:0'
    ];
    protected $scene=[
        'save'=>['name','money','cyc'],
        'update'=>['name','money','cyc']
    ];
    protected $message = [
        'name.require' => '请输入项目名称',
        'money.require' => '请输入排序',
        'money.number'  => '金额只能填写数字',
        'money.gt'  => '金额只能大于0',
        'cyc.number'          =>'周期只能是数字',
        'cyc.egt'          =>'周期不能小于0'
    ];
}