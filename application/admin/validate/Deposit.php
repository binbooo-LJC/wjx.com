<?php
namespace app\admin\validate;

use think\Validate;

class Deposit extends Validate
{
    protected $rule = [
        'premoney'=>'require|number|gt:0',
        'money'=>'require|number|gt:0',
    ];

    protected $message = [
        'premoney.require'   => '请填写充值金额',
        'money.require'   => '请填写套餐金额',
        'premoney.number'   => '充值金额只能是数字',
        'money.number'   => '套餐金额只能是数字',
        'premoney.gt'=>'充值金额需大于0',
        'money.gt'=>'套餐金额需大于0'
    ];
}