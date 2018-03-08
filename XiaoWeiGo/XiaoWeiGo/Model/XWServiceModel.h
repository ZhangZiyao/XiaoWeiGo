//
//  XWServiceModel.h
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/10.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWModel.h"

@interface XWServiceModel : XWModel
/**
 *  ID
 */
@property (nonatomic, assign) int ID;
/**
 *  uId
 */
@property (nonatomic, assign) int uId;
/**
 *  对应此项服务所属机构表ID
 */
@property (nonatomic, assign) int affUnit;
/**
 *  服务审核状态,关系到这项服务是否显示(true/false)
 */
@property (nonatomic, assign) BOOL auditing;
/**
 *  服务分类
 */
@property (nonatomic, assign) int category;
/**
 *  点赞数量
 */
@property (nonatomic, assign) int like;
/**
 *  服务详情
 */
@property (nonatomic, assign) NSString *details;
/**
 *  政策优惠
 */
@property (nonatomic, copy) NSString *discount;
/**
 *  时间
 */
@property (nonatomic, copy) NSString *issueTime;
/**
 *  机构名称
 */
@property (nonatomic, copy) NSString *orgName;
/**
 *  服务价格
 */
@property (nonatomic, copy) NSString *price;
/**
 *  服务地址
 */
@property (nonatomic, copy) NSString *sAddress;
/**
 *  标题
 */
@property (nonatomic, copy) NSString *sTitle;
/**
 *  服务名称
 */
@property (nonatomic, copy) NSString *serviceName;
/**
 *  简述
 */
@property (nonatomic, copy) NSString *sketch;
/**
 *
 */
@property (nonatomic, copy) NSString *xdetails;
/**
 *  联系人
 */
@property (nonatomic, copy) NSString *contacts;
/**
 *  联系电话
 */
@property (nonatomic, copy) NSString *tel;
/**
 *  电子邮箱
 */
@property (nonatomic, copy) NSString *email;
/**
 *  是否已经点赞
 */
@property (nonatomic, assign) BOOL isLiked;

@end
