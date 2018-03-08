//
//  XWEvaluateModel.h
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/10.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWModel.h"

@interface XWEvaluateModel : XWModel

/**
 *  服务表ID
 */
@property (nonatomic, assign) int ID;
/**
 *  对应服务表ID
 */
@property (nonatomic, assign) int sId;
/**
 *  评价发布者(对应用户表ID)
 */
@property (nonatomic, assign) int uId;
/**
 *  评价点赞数量
 */
@property (nonatomic, assign) int like;
/**
 *  标题
 */
@property (nonatomic, copy) NSString *eContent;
/**
 *  评价时间
 */
@property (nonatomic, copy) NSString *eTime;


@end
