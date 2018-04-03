//
//  NewsModel.h
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/3.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsModel : NSObject
/**
 *  文章表ID
 */
@property (nonatomic, assign) int ID;
/**
 *  标题
 */
@property (nonatomic, copy) NSString *aTitle;
/**
 *  副标题
 */
@property (nonatomic, copy) NSString *subTitle;
/**
 *  宣传图
 */
@property (nonatomic, copy) NSString *coverImg;
/**
 *  时间
 */
@property (nonatomic, copy) NSString *issueTime;
@property (nonatomic, copy) NSString *aTime;
/**
 *  文章内容
 */
@property (nonatomic, copy) NSString *aContent;
/**
 *  文章分类
 */
@property (nonatomic, assign) int category;
/**
 *  文章地域分类
 */
@property (nonatomic, assign) int region;

@property (nonatomic, assign) int type;

@property (nonatomic, copy) NSString *tName;

@end
