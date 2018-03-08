//
//  XWListViewCell.h
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/9.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWBaseCell.h"
@class XWCommonModel;
@class CommandModel;
@class XWServiceModel;

typedef NS_ENUM(NSInteger,HHShowTableCellType) {
    HHShowPictureCellType = 0, //cell带图片
    HHShowNoPictureCellType = 1, //cell  没有图片
    HHShowOtherCellType = 2 //其他
};

@interface XWListViewCell : XWBaseCell
@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel0;
@property (nonatomic, strong) UILabel *detailLabel1;
@property (nonatomic, strong) UIButton *moreBtn;

@property (nonatomic, strong) NSArray *categoryName;

@property (nonatomic, assign) HHShowTableCellType type;

@property (nonatomic, strong) XWCommonModel *model;

@property (nonatomic, strong) CommandModel *dmodel;

@property (nonatomic, strong) XWServiceModel *serModel;

- (void)resetDataWith:(CommandModel *)dmodel category:(int)category;

@property (nonatomic, assign) int cType;

@end
