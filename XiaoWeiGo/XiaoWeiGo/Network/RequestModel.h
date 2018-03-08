//
//  RequestModel.h
//  ucupay
//
//  Created by dingxin on 2017/7/18.
//  Copyright © 2017年 dingxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestModel : NSObject

@property (nonatomic ,copy)   NSString *message;
@property (nonatomic ,assign) BOOL status;
@property (nonatomic, assign) NSInteger errorCode;


@end
