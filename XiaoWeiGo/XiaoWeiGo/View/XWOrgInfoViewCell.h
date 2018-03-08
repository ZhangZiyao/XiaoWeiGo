//
//  XWOrgInfoViewCell.h
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/11.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWBaseCell.h"
@class XWServiceModel;

@protocol XWOrgInfoCellDelegate <NSObject>

@optional
-(void)didClickCollectButton;

-(void)didClickLikeButton;

@end

@interface XWOrgInfoViewCell : XWBaseCell
@property (nonatomic, strong) UIButton *collectBtn;
@property (nonatomic, strong) UIButton *likeBtn;
@property (nonatomic, weak) id<XWOrgInfoCellDelegate> delegate;
@property (nonatomic, strong) XWServiceModel *cmodel;

@end
