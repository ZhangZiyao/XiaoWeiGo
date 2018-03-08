//
//  XWButtonViewCell.m
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/8.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWButtonViewCell.h"

@interface XWButtonViewCell ()

@end

@implementation XWButtonViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createCell];
    }
    return self;
}
#pragma mark - XLFormDescriptorCell

-(void)configure
{
    [super configure];
}

- (void)update{
    [super update];
    
    self.titleLabel.text = self.rowDescriptor.title;
    self.selectButton.selected = [self.rowDescriptor.value boolValue];
}
- (void)formDescriptorCellDidSelectedWithFormController:(XLFormViewController *)controller{
    self.selectButton.selected = !self.selectButton.selected;
    self.rowDescriptor.value = @(self.selectButton.selected);
    
}
//- (void)btnClick:(UIButton *)sender{
//    sender.selected = !sender.selected;
//
//    self.rowDescriptor.value = @(sender.selected);
//}
- (void)createCell{
    [self.contentView addSubview:self.line];
    [self.contentView addSubview:self.selectButton];
    [self.contentView addSubview:self.titleLabel];
    [self addFrame];
}

- (void)addFrame{
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-30*kScaleW);
        make.left.equalTo(self.contentView).offset(30*kScaleW);
        make.height.mas_equalTo(0.5);
        make.bottom.equalTo(self.contentView);
    }];
    
    [self.selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(30*kScaleW);
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(16, 16));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.left.mas_equalTo(self.selectButton.mas_right).offset(15*kScaleW);
        make.right.equalTo(self.contentView).offset(-50*kScaleW);
    }];
}

- (UILabel *)line{
    if (!_line) {
        _line = [[UILabel alloc] init];
        _line.backgroundColor = UIColorFromRGB16(0xd2d2d2);
    }
    return _line;
}
- (UIButton *)selectButton{
    if (!_selectButton) {
        _selectButton = [[UIButton alloc] init];
        _selectButton.contentMode = UIViewContentModeScaleAspectFit;
        [_selectButton setImage:[UIImage imageNamed:@"registered_icon_d"] forState:UIControlStateNormal];
        [_selectButton setImage:[UIImage imageNamed:@"registered_icon_d_selected"] forState:UIControlStateSelected];
//        [_selectButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectButton;
}
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = UIColorFromRGB16(0x666666);
        _titleLabel.font = [UIFont rw_regularFontSize:15];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}
@end
