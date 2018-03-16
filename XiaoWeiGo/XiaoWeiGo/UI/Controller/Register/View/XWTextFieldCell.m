//
//  XWTextFieldCell.m
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/4.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWTextFieldCell.h"

@implementation XWTextFieldCell
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
    
    self.textField.tagString = self.rowDescriptor.tag;
    self.textFieldMaxNumberOfCharacters = self.rowDescriptor.textFieldMaxNumberOfCharacters;
    if (self.rowDescriptor.lineHidden) {
        self.line.hidden = YES;
    }
    self.textField.textAlignment = NSTextAlignmentLeft;
    if ([self.rowDescriptor.tag isEqualToString:XWRegisterPhoneTF]) {
        [self.textField addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventEditingChanged];
    }
    
    [self.textField mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.textLabel.mas_right).offset(20*kScaleW);
        make.right.equalTo(self.contentView).offset(-20*kScaleW);
        make.centerY.equalTo(self.contentView);
    }];
}
- (void)createCell{
    [self.contentView addSubview:self.line];
    
    [self addFrame];
}
- (void)addFrame{
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-30*kScaleW);
        make.left.equalTo(self.contentView).offset(30*kScaleW);
        make.height.mas_equalTo(0.5);
        make.bottom.equalTo(self.contentView);
    }];
}
- (UILabel *)line{
    if (!_line) {
        _line = [[UILabel alloc] init];
        _line.backgroundColor = UIColorFromRGB16(0xdddddd);
    }
    return _line;
}
- (void)textFieldChange:(RWTextField *)textField{
    if ([self.rowDescriptor.tag isEqualToString:XWRegisterPhoneTF]) {
        //判断是否包含－
        NSRange range = [textField.text rangeOfString:@"-"];
        bool bo = false;
        if (range.location ==NSNotFound) {
            bo = false;
        }else{
            bo = true;
        }
        //手机号格式逻辑
        if(textField.text.length==4 && !bo){
            textField.text = StringPush(textField.text, @"-", @"");
        }
    }
    
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
