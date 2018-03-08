//
//  XWCommandCell.m
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/9.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWCommandCell.h"
#import "CommandModel.h"

@interface XWCommandCell ()
@property (nonatomic, strong)   UILabel *titleLabel;
@property (nonatomic, strong)   UILabel *detailLabel;
@property (nonatomic, strong)   UILabel *detailLabel1;
@property (nonatomic, strong)   UIImageView *smallImageView;
@property (strong, nonatomic)   UIImageView *line;
@property (strong, nonatomic)   UIButton *moreBtn;

@end
@implementation XWCommandCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self createCell];
    }
    return self;
}
- (void)setModel:(CommandModel *)model{
    _model = model;
    self.titleLabel.text = model.dTitle;
    self.detailLabel.text = model.serviceName;
    self.detailLabel1.text = model.dContent;
}
- (void)createCell{
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.detailLabel];
    [self.contentView addSubview:self.detailLabel1];
    [self.contentView addSubview:self.smallImageView];
    [self.contentView addSubview:self.line];
    [self.contentView addSubview:self.moreBtn];
    
    [self.smallImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(30*kScaleW);
        make.top.equalTo(self.contentView).offset(35*kScaleW);
        make.width.mas_equalTo(100*kScaleW);
        make.height.mas_equalTo(100*kScaleW);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.smallImageView.mas_right).offset(20*kScaleW);
        make.top.equalTo(self.smallImageView);
        make.right.equalTo(self.contentView).offset(-20*kScaleW);
    }];
    
    [self.detailLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.smallImageView.mas_right).offset(20*kScaleW);
//        make.top.equalTo(self.detailLabel.mas_bottom).offset(5*kScaleW);
        make.bottom.equalTo(self.smallImageView);
        make.right.equalTo(self.contentView).offset(-20*kScaleW);
    }];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.smallImageView.mas_right).offset(20*kScaleW);
        make.bottom.equalTo(self.detailLabel1.mas_top).offset(-5*kScaleH);
        make.right.equalTo(self.contentView).offset(-20*kScaleW);
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(30*kScaleW);
        make.right.equalTo(self.contentView).offset(-30*kScaleW);
        make.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(0.5);
    }];
    [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-30*kScaleW);
        make.bottom.equalTo(self.contentView).offset(-30*kScaleH);
        make.size.mas_equalTo(CGSizeMake(18, 3));
    }];
}
- (UIButton *)moreBtn{
    if (!_moreBtn) {
        _moreBtn = [[UIButton alloc] init];
        [_moreBtn setImage:[UIImage imageNamed:@"def_icon_point"] forState:UIControlStateNormal];
    }
    return _moreBtn;
}

- (UIImageView *)smallImageView{
    if (!_smallImageView) {
        _smallImageView = [[UIImageView alloc] init];
        _smallImageView.contentMode = UIViewContentModeScaleAspectFit;
        _smallImageView.image = [UIImage imageNamed:@"demand_img_avatar"];
    }
    return _smallImageView;
}
- (UIImageView *)line{
    if (!_line) {
        _line = [[UIImageView alloc] init];
        _line.backgroundColor = [UIColor colorWithHex:@"e2e2e2"];;
    }
    return _line;
}
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor colorWithHex:@"666666"];
        _titleLabel.font = [UIFont rw_mediumFontSize:14.0];
        _titleLabel.text = @"公司注册，代理记账";
    }
    return _titleLabel;
}
- (UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc] init];
        _detailLabel.textColor = [UIColor colorWithHex:@"999999"];
        _detailLabel.font = [UIFont rw_regularFontSize:10];
        _detailLabel.text = @"工商注册：工商登记等政务代理";
    }
    return _detailLabel;
}
- (UILabel *)detailLabel1{
    if (!_detailLabel1) {
        _detailLabel1 = [[UILabel alloc] init];
        _detailLabel1.textColor = [UIColor colorWithHex:@"999999"];
        _detailLabel1.font = [UIFont rw_regularFontSize:10];
        _detailLabel1.text = @"浙江奉化去某某企业管理咨询有限公司";
    }
    return _detailLabel1;
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
