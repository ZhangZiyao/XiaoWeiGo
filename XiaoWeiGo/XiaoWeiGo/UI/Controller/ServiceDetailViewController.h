//
//  ServiceDetailViewController.h
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/9.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWBaseViewController.h"
@class XWServiceModel;

@interface ServiceDetailViewController : XWBaseViewController

@property (nonatomic, strong) XWServiceModel *model;

@property (nonatomic, assign) int category;

@end
