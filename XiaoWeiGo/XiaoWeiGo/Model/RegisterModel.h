//
//  RegisterModel.h
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/4.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "UserModel.h"

@interface RegisterModel : UserModel

//@property (nonatomic, copy) NSString *name;//用户名
//@property (nonatomic, copy) NSString *pwd;//密码
@property (nonatomic, copy) NSString *confirmPwd;//确认密码
@property (nonatomic, copy) NSString *orgName;//机构或者企业名称
@property (nonatomic, copy) NSString *orgType;//机构或者企业性质
@property (nonatomic, copy) NSString *orgCode;//机构或者企业社会信用号码
@property (nonatomic, copy) NSString *contact;//联系人名字
//@property (nonatomic, copy) NSString *email;//邮箱
@property (nonatomic, copy) NSString *mobile;//手机号码
@property (nonatomic, copy) NSString *telephone;//固定号码
@property (nonatomic, copy) NSString *sTypeArr;//服务类别
@property (nonatomic, assign) int uType;//用户类型(1:企业服务商,2:小薇企业)
@property (nonatomic, copy) NSString *idCardNo;//身份证后8位
@property (nonatomic, copy) NSString *sType;//行业类别ID
@property (nonatomic, copy) NSString *sTypeName;//行业类别名称
@property (nonatomic, copy) NSString *comCode;//企业注册号
@property (nonatomic, copy) NSString *operation;//经营范围
@property (nonatomic, copy) NSString *reservedtelephone;//预留电话
@property (nonatomic, copy) NSString *question;//密保提问
@property (nonatomic, copy) NSString *answer;//密保回答
@property (nonatomic, copy) NSString *auditing;//是否审核通过(yes为审核通过,这个值 的获取需要以调用CheckCompany接口的返回情况而定)

//@property (nonatomic, assign)BOOL auditing;
@property (nonatomic, assign)int companyId;
@property (nonatomic, copy) NSString *companyTypeName;
@property (nonatomic, assign) int phoneStatus;

@end
