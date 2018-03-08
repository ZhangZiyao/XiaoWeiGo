//
//  XWOrgModel.h
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/11.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWModel.h"

@interface XWOrgModel : XWModel
/**
 *  ID
 */
@property (nonatomic, assign) int ID;
/**
 *  Row
 */
@property (nonatomic, assign) int Row;
/**
 *  category
 */
@property (nonatomic, assign) int category;
/**
 *  like
 */
@property (nonatomic, assign) int like;

/**
 *  企业名称
 */
@property (nonatomic, copy) NSString *orgName;
/**
 *  服务时间
 */
@property (nonatomic, copy) NSString *issueTime;
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
