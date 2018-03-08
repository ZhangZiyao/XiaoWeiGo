//
//  UserModel.h
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/9.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWModel.h"

@interface UserModel : XWModel
/**
 *  用户的ID,用户全局唯一标识
 */
@property (nonatomic, assign) int ID;
/**
 *  用户登录账号
 */
@property (nonatomic, copy) NSString *uId;
/**
 *  用户昵称
 */
@property (nonatomic, copy) NSString *NickName;
/**
 *  密码
 */
@property (nonatomic, copy) NSString *pwd;
/**
 *  最后登录时间
 */
@property (nonatomic, copy) NSString *LastTime;
/**
 *  最后登录IP
 */
@property (nonatomic, copy) NSString *LastIP;
/**
 *  用户是否审核(false为不能登陆)
 */
@property (nonatomic, assign) BOOL Val_Flag;
/**
 *  用户类型(1:企业服务商,2:小薇企业,3:一般用户)
 */
@property (nonatomic, assign) int UidType;
/**
 *  用户类型(1:企业服务商,2:小薇企业,3:一般用户)
 */
@property (nonatomic, assign) int loginType;
/**
 *  姓名
 */
@property (nonatomic, copy) NSString *name;
/**
 *  固定电话
 */
@property (nonatomic, copy) NSString *tel;
/**
 *  工作电话
 */
@property (nonatomic, copy) NSString *worktel;
/**
 *  邮箱
 */
@property (nonatomic, copy) NSString *email;
/**
 *  地址
 */
@property (nonatomic, copy) NSString *address;
/**
 *  备注
 */
@property (nonatomic, copy) NSString *remark;
/**
 *  登记机关
 */
@property (nonatomic, copy) NSString *regOrg;//
/**
 *  注册日期
 */
@property (nonatomic, copy) NSString *regDate;
/**
 *  资金数额
 */
@property (nonatomic, copy) NSString *regCapital;
/**
 *  行业代码
 */
@property (nonatomic, copy) NSString *tradeCode;
/**
 *  号码？
 */
@property (nonatomic, copy) NSString *weNumber;

/**
 是否登陆
 */
+ (BOOL)isLogin;

/**
 退出登陆
 */
+ (void)logout;

/**
 保存用户信息
 */
//+ (void)saveUserInfo:(NSDictionary *)userInfo;

+ (UserModel *)share;

/**
 获取保存的用户信息
 */
//+ (NSDictionary *)userInfo;

/**
 *
 *  用户登陆接口
 */
+ (void)loginWithParams:(NSDictionary *)params block:(void(^)(BOOL isLogin))block;


/**
 *  用户注册
 */
+ (void)registWithUrl:(NSString *)urlString params:(NSDictionary *)params block:(void (^)(BOOL success))block;
/**
 *
 *  用户修改密码接口
 */
+ (void)resetPwdWithParams:(NSDictionary *)params block:(void(^)(BOOL success))block;
/**
 *  获取用户信息
 */
+ (void)getUserData;
@end
