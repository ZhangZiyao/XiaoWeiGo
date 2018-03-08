//
//  XWServiceDetailViewController.h
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/10.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWBaseViewController.h"
@class XWServiceModel;

@interface XWServiceDetailViewController : XWBaseViewController

@property (nonatomic, strong) XWServiceModel *model;

@property (nonatomic, assign) int category;

@end
