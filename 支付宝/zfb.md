
**1.d支付宝接入流程：**

    1.账号密码及认证信息：https://b.alipay.com/
    2.开放文档：https://docs.open.alipay.com/270/105899/
    3.支付接入：网站的https://openhome.alipay.com/platform/appManage.htm#/apps
    
**2.接入：**

    1.创建应用：创建应用获取appID
    2.配置应用：
        1.添加功能并签约
        2.配置秘钥：获取公钥 私钥  查看以下视屏
            https://docs.open.alipay.com/291/105971
            视屏资料：https://gw.alipayobjects.com/os/skylark-tools/public/files/caa79b46fabf81d6b2ebc96413d6c0de.mp4
                应用私钥：开发者保存，签名使用，对数据加密发送给支付宝 
                应用公钥：上传支付宝，支付宝使用公钥解密，确定是商户发起的交易，上传后会生成支付宝公钥，下载保存使用
                支付宝公钥：商户验证该结果是否是有支付宝返回的
    3.