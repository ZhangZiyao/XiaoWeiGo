//
//  XWReadDocViewController.h
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/28.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWBaseViewController.h"
@class XWAttachmentModel;

@interface XWReadDocViewController : XWBaseViewController

@property (nonatomic, strong) XWAttachmentModel *model;

@property (nonatomic, copy) NSString *urlString;

@end
