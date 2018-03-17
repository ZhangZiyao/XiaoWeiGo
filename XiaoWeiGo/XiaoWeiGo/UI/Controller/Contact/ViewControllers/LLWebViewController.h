//
//  LLWebViewController.h
//  LLWeChat
//
//  Created by GYJZH on 8/11/16.
//  Copyright © 2016 GYJZH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XWBaseViewController.h"

@interface LLWebViewController : XWBaseViewController

@property (nonatomic) NSURL *url;

@property (nonatomic) UIViewController *fromViewController;

@end
