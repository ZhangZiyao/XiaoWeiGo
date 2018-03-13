//
//  XWServiceViewCell.h
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/28.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWBaseCell.h"
@class XWServiceModel;
@class CommandModel;

typedef void(^heightBlock)();
@interface XWServiceViewCell : XWBaseCell

@property (nonatomic, strong) XWServiceModel *cmodel;

@property (nonatomic, strong) CommandModel *dmodel;

@property (nonatomic, assign) CGFloat cellheight;

@property (nonatomic, copy) heightBlock heightBlock;

@end
