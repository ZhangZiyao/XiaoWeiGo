//
//  XWCompanyTypeListController.h
//  XiaoWeiGo
//
//  Created by dingxin on 2018/3/16.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWBaseViewController.h"

typedef void(^selectCompanyTypeBlock)(int cId , NSString *cType);

@interface XWCompanyTypeListController : XWBaseViewController

@property (nonatomic, copy) selectCompanyTypeBlock selectCompanyBlock;

@end
