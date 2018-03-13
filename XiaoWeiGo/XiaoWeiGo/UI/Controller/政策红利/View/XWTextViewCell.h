//
//  XWTextViewCell.h
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/8.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NewsModel;

typedef NS_ENUM(NSInteger,HHShowNewsTableCellType) {
    HHShowNewsSubTitleCellType = 0, //cell带图片
    HHShowNewsTimeCellType = 1, //cell  没有图片
    HHShowOtherCellType = 2 //其他
};
@interface XWTextViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView *leftLine;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UIImageView *bottomLine;

- (void)resetData:(NewsModel *)model type:(HHShowNewsTableCellType)type;

@property (nonatomic, strong) NewsModel *model;

@property (nonatomic, assign) int cType;

@end
