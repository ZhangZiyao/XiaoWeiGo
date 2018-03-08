//
//  XWOrgInfoViewCell.m
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/11.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWOrgInfoViewCell.h"
#import "XWServiceModel.h"

@interface XWOrgInfoViewCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detail0Label;
@property (nonatomic, strong) UILabel *detail1Label;
@property (nonatomic, strong) UILabel *detail2Label;
@property (nonatomic, strong) UILabel *detail3Label;
@property (nonatomic, strong) UILabel *detail4Label;
@property (nonatomic, strong) UILabel *line;

@property (nonatomic, strong) UIImageView *likeImageView;
@property (nonatomic, strong) UILabel *likeNumLabel;
@end
@implementation XWOrgInfoViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createCell];
    }
    return self;
}

- (void)setCmodel:(XWServiceModel *)cmodel{
    _cmodel = cmodel;
    if (APPDELEGATE.user.loginType == 1) {
        self.likeBtn.hidden = YES;
    }else{
        self.likeBtn.hidden = NO;
    }
    self.likeNumLabel.text = [NSString stringWithFormat:@"+%d",cmodel.like];
    self.detail1Label.text = [NSString stringWithFormat:@"服务收费：%@",cmodel.price];
    self.detail2Label.text = [NSString stringWithFormat:@"联系人：%@",cmodel.contacts];
    self.detail3Label.text = [NSString stringWithFormat:@"联系电话：%@",cmodel.tel];
    self.detail4Label.text = [NSString stringWithFormat:@"电子邮箱：%@",cmodel.email];
}
- (void)collectBtnClick{
    [self.delegate didClickCollectButton];
    
}
- (void)likeBtnClick{
    [self.delegate didClickLikeButton];
    
}
- (void)createCell{
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.detail0Label];
    [self.contentView addSubview:self.detail1Label];
    [self.contentView addSubview:self.detail2Label];
    [self.contentView addSubview:self.detail3Label];
    [self.contentView addSubview:self.detail4Label];
    [self.contentView addSubview:self.collectBtn];
    [self.contentView addSubview:self.likeBtn];
    [self.contentView addSubview:self.likeImageView];
    [self.contentView addSubview:self.likeNumLabel];
    [self.contentView addSubview:self.line];
    
    [self addFrame];
}
- (void)addFrame{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(40*kScaleW);
        make.left.equalTo(self.contentView).offset(40*kScaleW);
        make.right.equalTo(self.contentView).offset(-40*kScaleW);
        make.centerX.equalTo(self.contentView);
    }];
    [self.collectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(20*kScaleH);
        make.centerX.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(100*kScaleW, 50*kScaleH));
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-30*kScaleW);
        make.left.equalTo(self.contentView).offset(30*kScaleW);
        make.height.mas_equalTo(0.5);
        make.top.equalTo(self.collectBtn.mas_bottom).offset(30*kScaleH);
    }];
    [self.detail0Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(40*kScaleW);
        make.top.equalTo(self.line.mas_bottom).offset(30*kScaleW);
//        make.width.mas_equalTo(150*kScaleW);
    }];
    [self.likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-20*kScaleH);
        make.centerY.equalTo(self.detail0Label);
        make.size.mas_equalTo(CGSizeMake(100*kScaleW, 50*kScaleH));
    }];
    [self.likeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.detail0Label.mas_right).offset(10*kScaleW);
        make.centerY.equalTo(self.detail0Label);
        make.size.mas_equalTo(CGSizeMake(32*kScaleW, 30*kScaleH));
    }];
    [self.likeNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.likeImageView.mas_right).offset(10*kScaleW);
        make.centerY.equalTo(self.detail0Label);
        make.right.equalTo(self.contentView).offset(160*kScaleW);
    }];
    [self.detail1Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.detail0Label);
        make.top.equalTo(self.detail0Label.mas_bottom).offset(20*kScaleW);
        make.right.equalTo(self.contentView).offset(-40*kScaleW);
    }];
    [self.detail2Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.detail0Label);
        make.top.equalTo(self.detail1Label.mas_bottom).offset(20*kScaleW);
        make.right.equalTo(self.contentView).offset(-40*kScaleW);
    }];
    [self.detail3Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.detail0Label);
        make.top.equalTo(self.detail2Label.mas_bottom).offset(20*kScaleW);
        make.right.equalTo(self.contentView).offset(-40*kScaleW);
    }];
    [self.detail4Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.detail0Label);
        make.top.equalTo(self.detail3Label.mas_bottom).offset(20*kScaleW);
        make.right.equalTo(self.contentView).offset(-40*kScaleW);
    }];
}
- (UIButton *)collectBtn{
    if (!_collectBtn) {
        _collectBtn = [[UIButton alloc] init];
        [_collectBtn setTitle:@"收藏" forState:UIControlStateNormal];
        [_collectBtn.titleLabel setFont:[UIFont rw_regularFontSize:14.0]];
        [_collectBtn setBackgroundColor:[UIColor colorWithHex:@"fe7401"]];
        _collectBtn.layer.cornerRadius = 5;
        _collectBtn.layer.masksToBounds = YES;
        [_collectBtn addTarget:self action:@selector(collectBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _collectBtn;
}
- (UIButton *)likeBtn{
    if (!_likeBtn) {
        _likeBtn = [[UIButton alloc] init];
        [_likeBtn setTitle:@"点赞" forState:UIControlStateNormal];
        [_likeBtn.titleLabel setFont:[UIFont rw_regularFontSize:14.0]];
        [_likeBtn setBackgroundColor:[UIColor colorWithHex:@"fe7401"]];
        _likeBtn.layer.cornerRadius = 5;
        _likeBtn.layer.masksToBounds = YES;
        [_likeBtn addTarget:self action:@selector(likeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _likeBtn;
}

- (UIImageView *)likeImageView{
    if (!_likeImageView) {
        _likeImageView = [[UIImageView alloc] init];
        _likeImageView.image = [UIImage imageNamed:@"shared_icon_praise"];
    }
    return _likeImageView;
}
- (UILabel *)likeNumLabel{
    if (!_likeNumLabel) {
        _likeNumLabel = [[UILabel alloc] init];
        _likeNumLabel.textColor = [UIColor colorWithHex:@"fe7401"];
        _likeNumLabel.font = [UIFont rw_regularFontSize:14.0];
    }
    return _likeNumLabel;
}
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = UIColorFromRGB16(0X666666);
        _titleLabel.font = [UIFont rw_regularFontSize:20.0];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = @"企业信用服务评价";
    }
    return _titleLabel;
}
- (UILabel *)detail0Label{
    if (!_detail0Label) {
        _detail0Label = [[UILabel alloc] init];
        _detail0Label.textColor = UIColorFromRGB16(0X666666);
        _detail0Label.font = [UIFont rw_regularFontSize:15];
        _detail0Label.textAlignment = NSTextAlignmentLeft;
        _detail0Label.text = @"服务评价：";
    }
    return _detail0Label;
}
- (UILabel *)detail1Label{
    if (!_detail1Label) {
        _detail1Label = [[UILabel alloc] init];
        _detail1Label.textColor = UIColorFromRGB16(0X666666);
        _detail1Label.font = [UIFont rw_regularFontSize:15];
        _detail1Label.textAlignment = NSTextAlignmentLeft;
    }
    return _detail1Label;
}
- (UILabel *)detail2Label{
    if (!_detail2Label) {
        _detail2Label = [[UILabel alloc] init];
        _detail2Label.textColor = UIColorFromRGB16(0X666666);
        _detail2Label.font = [UIFont rw_regularFontSize:15];
        _detail2Label.textAlignment = NSTextAlignmentLeft;
    }
    return _detail2Label;
}
- (UILabel *)detail3Label{
    if (!_detail3Label) {
        _detail3Label = [[UILabel alloc] init];
        _detail3Label.textColor = UIColorFromRGB16(0X666666);
        _detail3Label.font = [UIFont rw_regularFontSize:15];
        _detail3Label.textAlignment = NSTextAlignmentLeft;
    }
    return _detail3Label;
}
- (UILabel *)detail4Label{
    if (!_detail4Label) {
        _detail4Label = [[UILabel alloc] init];
        _detail4Label.textColor = UIColorFromRGB16(0X666666);
        _detail4Label.font = [UIFont rw_regularFontSize:15];
        _detail4Label.textAlignment = NSTextAlignmentLeft;
    }
    return _detail4Label;
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
