//
//  XWLabelViewCell.m
//  XiaoWeiGo
//
//  Created by dingxin on 2018/3/13.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWLabelViewCell.h"

@interface XWLabelViewCell ()

@property (nonatomic, strong) UILabel *valueTextLabel;

@end

@implementation XWLabelViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createCell];
    }
    return self;
}
- (void)update{
    [super update];
    
    
    self.textLabel.textAlignment = NSTextAlignmentRight;
    self.textLabel.textColor = [UIColor blackColor];
    self.textLabel.text = self.rowDescriptor.title;
    self.valueTextLabel.text = self.rowDescriptor.value;
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.centerY.equalTo(self.contentView);
        make.width.mas_equalTo(295*kScaleW);
    }];
    
    self.cellHeight = [self.rowDescriptor.value sizeWithLabelWidth:ScreenWidth-350*kScaleW font:[UIFont rw_regularFontSize:15.0]].height+20;
}
- (void)createCell{
    [self.contentView addSubview:self.line];
    [self.contentView addSubview:self.valueTextLabel];
    
    [self addFrame];
}
- (void)addFrame{
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-30*kScaleW);
        make.left.equalTo(self.contentView).offset(30*kScaleW);
        make.height.mas_equalTo(0.5);
        make.bottom.equalTo(self.contentView);
    }];
    [self.valueTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-30*kScaleW);
        make.left.equalTo(self.contentView).offset(320*kScaleW);
        make.centerY.equalTo(self.contentView);
    }];
    
}
- (UILabel *)line{
    if (!_line) {
        _line = [[UILabel alloc] init];
        _line.backgroundColor = UIColorFromRGB16(0xdddddd);
    }
    return _line;
}
- (UILabel *)valueTextLabel{
    if (!_valueTextLabel) {
        _valueTextLabel = [[UILabel alloc] init];
        _valueTextLabel.textColor = [UIColor blackColor];
        _valueTextLabel.font = [UIFont rw_regularFontSize:15.0];
        _valueTextLabel.numberOfLines = 0;
        _valueTextLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _valueTextLabel;
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
