//
//  XWBaseHeaderView.h
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/11.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XWBaseHeaderView : UIView

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) BOOL showSearchBtn;

- (void)setupView;

/** 右边Item点击 */
@property (nonatomic, copy) dispatch_block_t rightItemClickBlock;


+ (XWBaseHeaderView *)createHeaderViewWithTitle:(NSString *)title;

@end
