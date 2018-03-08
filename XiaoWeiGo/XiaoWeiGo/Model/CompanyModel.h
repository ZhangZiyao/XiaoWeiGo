//
//  CompanyModel.h
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/10.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWModel.h"

@interface CompanyModel : XWModel
/**
 *  ID
 */
@property (nonatomic, assign) int ID;
/**
 *  like
 */
@property (nonatomic, assign) int like;
/**
 *  企业名称
 */
@property (nonatomic, copy) NSString *orgName;
/**
 *  服务收费
 */
@property (nonatomic, copy) NSString *price;
/**
 *  联系邮箱
 */
@property (nonatomic, copy) NSString *email;
/**
 *  联系电话
 */
@property (nonatomic, copy) NSString *tel;
/**
 *  联系人
 */
@property (nonatomic, copy) NSString *contacts;
/**
 *  机构简介
 */
@property (nonatomic, copy) NSString *orgSketch;
/**
 *  主营业务
 */
@property (nonatomic, copy) NSString *priBusness;
/**
 *  isRecommend
 */
@property (nonatomic, assign) BOOL isRecommend;
/**
 *  浏览量
 */
@property (nonatomic, assign) int visits;
/**
 *  固定电话
 */
@property (nonatomic, copy) NSString *telephone;
/**
 *  组织机构号码
 */
@property (nonatomic, copy) NSString *orgCode;
/**
 *  公司性质
 */
@property (nonatomic, copy) NSString *orgType;
/**
 *  企业地址
 */
@property (nonatomic, copy) NSString *orgAddress;

@end
