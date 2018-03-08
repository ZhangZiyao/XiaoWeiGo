//
//  XWChargeViewCell.h
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/10.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWBaseCell.h"

@interface XWChargeViewCell : XWBaseCell

@property (nonatomic, strong) UIImageView *codeImageView;

@property (nonatomic, strong) UILabel *accountLabel;

- (void)resetCellWithData:(id)data andType:(NSInteger)type;

@end
