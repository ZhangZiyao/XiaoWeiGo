//
//  XWTextFieldViewCell.m
//  XiaoWeiGo
//
//  Created by dingxin on 2018/3/13.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWTextFieldViewCell.h"
@interface XWTextFieldViewCell ()

@property (nonatomic, strong) RWTextField *valueTextField;
@property (nonatomic, strong) UILabel *line;

@end
@implementation XWTextFieldViewCell
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
    if (!IsStrEmpty(self.rowDescriptor.value)) {
        self.textField.text = self.rowDescriptor.value;
    }
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.centerY.equalTo(self.contentView);
        make.width.mas_equalTo(295*kScaleW);
    }];
    self.textField.textAlignment = NSTextAlignmentLeft;
    self.textField.textColor = [UIColor blackColor];
    [self.textField mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.textLabel.mas_right).offset(20*kScaleW);
        make.right.equalTo(self.contentView).offset(-20*kScaleW);
        make.centerY.equalTo(self.contentView);
    }];
}
- (void)createCell{
    [self.contentView addSubview:self.line];
//    [self.contentView addSubview:self.valueTextField];
    
    [self addFrame];
}
- (void)addFrame{
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-30*kScaleW);
        make.left.equalTo(self.contentView).offset(30*kScaleW);
        make.height.mas_equalTo(0.5);
        make.bottom.equalTo(self.contentView);
    }];
//    [self.valueTextField mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self.contentView).offset(-30*kScaleW);
//        make.left.equalTo(self.contentView).offset(320*kScaleW);
//        make.centerY.equalTo(self.contentView);
//    }];
    
}
- (UILabel *)line{
    if (!_line) {
        _line = [[UILabel alloc] init];
        _line.backgroundColor = UIColorFromRGB16(0xdddddd);
    }
    return _line;
}
- (RWTextField *)valueTextField{
    if (!_valueTextField) {
        _valueTextField = [[RWTextField alloc] init];
        _valueTextField.textColor = [UIColor blackColor];
        _valueTextField.font = [UIFont rw_regularFontSize:15.0];
        _valueTextField.textAlignment = NSTextAlignmentLeft;
    }
    return _valueTextField;
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
