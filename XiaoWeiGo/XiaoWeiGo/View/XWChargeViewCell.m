//
//  XWChargeViewCell.m
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/10.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWChargeViewCell.h"

@interface XWChargeViewCell ()
@property (nonatomic, strong) UILabel *firstLabel;
@property (nonatomic, strong) UILabel *secondLabel;
@property (nonatomic, strong) UILabel *firstDLabel;
@property (nonatomic, strong) UILabel *secondDLabel;

@end
@implementation XWChargeViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self createCell];
    }
    return self;
}
- (void)resetCellWithData:(id)data andType:(NSInteger)type{
    if (type == 1) {
        
        //支付宝
        self.firstDLabel.text = [NSString stringWithFormat:@"身份认证："];
        self.accountLabel.text = [NSString stringWithFormat:@"支付宝账号："];
    }else{
        
        //微信
        self.firstDLabel.text = @"添加朋友付款";
        self.accountLabel.text = [NSString stringWithFormat:@"微信号/手机号："];
    }
}
- (void)createCell{
    [self.contentView addSubview:self.firstLabel];
    [self.contentView addSubview:self.firstDLabel];
    [self.contentView addSubview:self.accountLabel];
    [self.contentView addSubview:self.secondLabel];
    [self.contentView addSubview:self.secondDLabel];
    [self.contentView addSubview:self.codeImageView];
    
    [self.firstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(40*kScaleW);
        make.top.equalTo(self.contentView).offset(40*kScaleW);
        make.right.equalTo(self.contentView).offset(-40*kScaleW);
    }];
    [self.firstDLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(40*kScaleW);
        make.top.equalTo(self.firstLabel.mas_bottom).offset(30*kScaleW);
        make.right.equalTo(self.contentView).offset(-40*kScaleW);
    }];
    [self.accountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(40*kScaleW);
        make.top.equalTo(self.firstDLabel.mas_bottom).offset(30*kScaleW);
        make.right.equalTo(self.contentView).offset(-40*kScaleW);
    }];
    [self.secondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(40*kScaleW);
        make.top.equalTo(self.accountLabel.mas_bottom).offset(60*kScaleW);
        make.right.equalTo(self.contentView).offset(-40*kScaleW);
    }];
    [self.secondDLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(40*kScaleW);
        make.top.equalTo(self.secondLabel.mas_bottom).offset(30*kScaleW);
        make.right.equalTo(self.contentView).offset(-40*kScaleW);
    }];
    [self.codeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView).offset(-30*kScaleW);
        make.top.equalTo(self.secondDLabel.mas_bottom).offset(40*kScaleW);
        make.centerX.equalTo(self.contentView);
    }];
}
- (UIImageView *)codeImageView{
    if (!_codeImageView) {
        _codeImageView = [[UIImageView alloc] init];
        _codeImageView.contentMode = UIViewContentModeScaleAspectFit;
        _codeImageView.image = [UIImage imageNamed:@"qrcode_img_code"];
    }
    return _codeImageView;
}
- (UILabel *)firstLabel{
    if (!_firstLabel) {
        _firstLabel = [[UILabel alloc] init];
        _firstLabel.text = @"转账方式一：";
        _firstLabel.textColor = [UIColor textBlackColor];
        _firstLabel.font = [UIFont rw_mediumFontSize:20.0];
    }
    return _firstLabel;
}

- (UILabel *)firstDLabel{
    if (!_firstDLabel) {
        _firstDLabel = [[UILabel alloc] init];
        _firstDLabel.text = @"添加朋友付款";
        _firstDLabel.textColor = [UIColor textBlackColor];
        _firstDLabel.font = [UIFont rw_mediumFontSize:15.0];
    }
    return _firstDLabel;
}
- (UILabel *)accountLabel{
    if (!_accountLabel) {
        _accountLabel = [[UILabel alloc] init];
        _accountLabel.text = @"微信号/手机号";
        _accountLabel.textColor = [UIColor textBlackColor];
        _accountLabel.font = [UIFont rw_mediumFontSize:15.0];
    }
    return _accountLabel;
}
- (UILabel *)secondLabel{
    if (!_secondLabel) {
        _secondLabel = [[UILabel alloc] init];
        _secondLabel.text = @"转账方式二：";
        _secondLabel.textColor = [UIColor textBlackColor];
        _secondLabel.font = [UIFont rw_mediumFontSize:20.0];
    }
    return _secondLabel;
}
- (UILabel *)secondDLabel{
    if (!_secondDLabel) {
        _secondDLabel = [[UILabel alloc] init];
        _secondDLabel.text = @"扫二维码付款";
        _secondDLabel.textColor = [UIColor textBlackColor];
        _secondDLabel.font = [UIFont rw_mediumFontSize:15.0];
    }
    return _secondDLabel;
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
