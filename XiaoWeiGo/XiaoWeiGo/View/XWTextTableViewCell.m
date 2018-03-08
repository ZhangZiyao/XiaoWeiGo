//
//  XWTextTableViewCell.m
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/11.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWTextTableViewCell.h"
@interface XWTextTableViewCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UILabel *line;
@end
@implementation XWTextTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createCell];
    }
    return self;
}
- (void)configure{
    [super configure];
}
- (void)update{
    [super update];
    self.titleLabel.text = self.rowDescriptor.title;
    self.detailLabel.text = self.rowDescriptor.value;
    self.cellHeight = [self.rowDescriptor.value sizeWithLabelWidth:ScreenWidth-250*kScaleW font:[UIFont rw_regularFontSize:15.0]].height+20;
}
/** 动态获取cell高度 */
+ (CGFloat)cellHeightWithCell:(XWTextTableViewCell *)cell
{
      CGSize detailSize = [cell.detailLabel.text sizeWithLabelWidth:120 font:[UIFont rw_regularFontSize:15.0]];
//    CGSize detailSize = [NSString getSizeWithString:item.formDetail Font:Font(TitleFont) maxSize:CGSizeMake(ScreenWidth - (TitleWidth + 3*EdgeMarin), MAXFLOAT)];
//    return MAX(TitleHeight+2*EdgeMarin ,detailSize.height + 2*EdgeMarin);
    return detailSize.height;
}
- (void)createCell{
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.detailLabel];
    [self.contentView addSubview:self.line];
    
    [self addFrame];
}
- (void)addFrame{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(40*kScaleW);
        make.width.mas_equalTo(160*kScaleW);
        make.centerY.equalTo(self.contentView);
    }];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right).offset(10*kScaleW);
        make.right.equalTo(self.contentView).offset(-40*kScaleW);
        make.centerY.equalTo(self.titleLabel);
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-30*kScaleW);
        make.left.equalTo(self.contentView).offset(30*kScaleW);
        make.height.mas_equalTo(0.5);
        make.bottom.equalTo(self.contentView);
    }];
    
}
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = UIColorFromRGB16(0X666666);
        _titleLabel.font = [UIFont rw_regularFontSize:15];
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}
- (UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc] init];
        _detailLabel.textColor = UIColorFromRGB16(0X666666);
        _detailLabel.font = [UIFont rw_regularFontSize:15.0];
        _detailLabel.textAlignment = NSTextAlignmentLeft;
        _detailLabel.numberOfLines = 0;
    }
    return _detailLabel;
}
- (UILabel *)line{
    if (!_line) {
        _line = [[UILabel alloc] init];
        _line.backgroundColor = UIColorFromRGB16(0xdddddd);
    }
    return _line;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
