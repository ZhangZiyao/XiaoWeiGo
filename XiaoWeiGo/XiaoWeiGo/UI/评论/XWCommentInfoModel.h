//
//  XWCommentInfoModel.h
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/21.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWModel.h"

@interface XWCommentInfoModel : XWModel

@property (nonatomic, assign) CGFloat rowHeight;

/**
 *  ID
 */
@property (nonatomic, assign) int ID;
/**
 *  uId 评价发布者(对应用户表ID)
 */
@property (nonatomic, assign) int uId;
/**
 *
 */
@property (nonatomic, assign) int eId;

/**
 *  回复内容
 */
@property (nonatomic, copy) NSString *rContent;
/**
 *  回复时间
 */
@property (nonatomic, copy) NSString *rTime;

@end
