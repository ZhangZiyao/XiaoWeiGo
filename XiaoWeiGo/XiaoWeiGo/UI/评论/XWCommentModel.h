//
//  XWCommentModel.h
//  XiaoWeiGo
//
//  Created by Ziyao on 2018/2/14.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWModel.h"

@interface XWCommentModel : XWModel

///评论相关的所有信息
@property (nonatomic,copy) NSMutableArray *commentModelArray;

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
 *  对应服务表ID
 */
@property (nonatomic, assign) int sId;
/**
 *  like
 */
@property (nonatomic, assign) int like;

/**
 *  评价内容
 */
@property (nonatomic, copy) NSString *eContent;
/**
 *  评价时间
 */
@property (nonatomic, copy) NSString *eTime;

@property (nonatomic, strong) NSArray *replyArray;

@end
