//
//  XWCommandCell.h
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/9.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWBaseCell.h"
@class CommandModel;

@interface XWCommandCell : XWBaseCell

@property (nonatomic, strong) CommandModel *model;

/**
 *  撤回/重发按钮的block
 */
@property (nonatomic, copy)void(^funcBtnClickBlock)(CommandModel *smodel,int audio);

@end
