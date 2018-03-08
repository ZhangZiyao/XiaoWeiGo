//
//  CommandModel.h
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/9.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWModel.h"

@interface CommandModel : XWModel
/**
 *  需求表ID
 */
@property (nonatomic, assign) int ID;
/**
 *  category
 */
@property (nonatomic, assign) int category;
/**
 *  状态
 */
@property (nonatomic, assign) int auditing;//状态
/**
 *  标题
 */
@property (nonatomic, copy) NSString *dTitle;
/**
 *  需求服务分类(与服务分类是同一个)
 */
@property (nonatomic, copy) NSString *serviceName;
/**
 *  服务内容
 */
@property (nonatomic, copy) NSString *dContent;
/**
 *  开始时间
 */
@property (nonatomic, copy) NSString *starTime;
/**
 *  结束时间
 */
@property (nonatomic, copy) NSString *endTime;


@end
