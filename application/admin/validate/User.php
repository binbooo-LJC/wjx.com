<?php
namespace app\admin\validate;

use think\Validate;

class User extends Validate
{
    protected $rule = [
        'username'         => 'require',
        'mobile'           => 'number|length:11',

    ];

    protected $message = [
        'username.require'         => '请输入会员名',
        'mobile.number'            => '手机号格式错误',
        'mobile.length'            => '手机号长度错误',

    ];
}