//
//  XWTextViewCell.m
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/8.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWTextViewCell.h"
#import "NewsModel.h"

@interface XWTextViewCell ()



@end
@implementation XWTextViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createCell];
    }
    return self;
}
- (void)resetData:(NewsModel *)model type:(HHShowNewsTableCellType)type{
    switch (type) {
        case HHShowNewsTimeCellType:
        {
            self.titleLabel.text = model.aTitle;
            self.detailLabel.text = model.issueTime;
        }
            break;
        case HHShowNewsSubTitleCellType:
        {
            self.titleLabel.text = model.aTitle;
            self.detailLabel.text = IsStrEmpty(model.subTitle)?model.issueTime:model.subTitle;
        }
            break;
        case HHShowOtherCellType:
        {
            self.titleLabel.text = model.aTitle;
            self.detailLabel.text = model.issueTime;
        }
            break;
            
        default:
            break;
    }
}
- (void)createCell{
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.detailLabel];
    [self.contentView addSubview:self.leftLine];
    [self.contentView addSubview:self.bottomLine];
    
    [self.leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(30*kScaleW);
        make.centerY.equalTo(self.contentView);
        make.height.mas_equalTo(30*kScaleH);
        make.width.mas_equalTo(1);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.equalTo(self.leftLine.mas_right).offset(20*kScaleW);
        make.right.equalTo(self.contentView).offset(-200*kScaleW);
        make.centerY.equalTo(self.leftLine);
    }];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(170*kScaleW);
        make.right.equalTo(self.contentView).offset(-30*kScaleW);
        make.centerY.equalTo(self.leftLine);
    }];
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(30*kScaleW);
        make.right.equalTo(self.contentView).offset(-30*kScaleW);
        make.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(0.5);
    }];
}
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = UIColorFromRGB16(0x4b4946);
        _titleLabel.font = [UIFont rw_regularFontSize:16];
    }
    return _titleLabel;
}
- (UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc] init];
        _detailLabel.textColor = UIColorFromRGB16(0x838383);
        _detailLabel.font = [UIFont rw_regularFontSize:16];
        _detailLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _detailLabel;
}
- (UIImageView *)leftLine{
    if (!_leftLine) {
        _leftLine = [[UIImageView alloc] init];
        _leftLine.backgroundColor = UIColorFromRGB16(0x3b78d8);
    }
    return _leftLine;
}
- (UIImageView *)bottomLine{
    if (!_bottomLine) {
        _bottomLine = [[UIImageView alloc] init];
        _bottomLine.backgroundColor = UIColorFromRGB16(0xd2d2d2);
    }
    return _bottomLine;
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
