//
//  XWCommonModel.h
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/10.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWModel.h"

@interface XWCommonModel : XWModel
/**
 *  需求表ID
 */
@property (nonatomic, assign) int ID;
/**
 *
 */
@property (nonatomic, assign) int Row;
/**
 *  服务分类
 */
@property (nonatomic, assign) int category;
/**
 *  点赞数
 */
@property (nonatomic, assign) int like;
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
 *  标题
 */
@property (nonatomic, copy) NSString *sTitle;
/**
 *  服务名称
 */
@property (nonatomic, copy) NSString *serviceName;

@end
