//
//  XWModel.h
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/9.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XWModel;
@protocol XWModelProtocol <NSObject>
@optional
/**
 *  init model
 *
 *  @param dict dict
 */
- (instancetype)initWithDictionary:(NSDictionary *)dict;
/**
 *  init model
 *
 *  @param dict dict
 */
+ (instancetype)modelOfDictionary:(NSDictionary *)dict;
/**
 *  dictionary
 *
 */
- (NSDictionary *)dictionary;
@end

@interface XWModel : NSObject<XWModelProtocol>
/**
 *  total
 */
@property (nonatomic, assign) NSInteger total;
/**
 *  data
 */
@property (nonatomic,strong) NSArray *data;
/**
 *  error
 */
@property (nonatomic,copy) NSString *error;

@end
