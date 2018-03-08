//
//  XWCommentViewCell.m
//  XiaoWeiGo
//
//  Created by Ziyao on 2018/2/14.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWCommentViewCell.h"
#import "XWCommentModel.h"

@interface XWCommentViewCell ()
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *accountNameLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *commentDetailLabel;
@property (nonatomic, strong) UIButton *commentBtn;
@property (nonatomic, strong) UIButton *likeBtn;
@property (nonatomic, strong) UILabel *likeNumLabel;
@property (nonatomic, strong) UILabel *line;

@end
@implementation XWCommentViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createCell];
    }
    return self;
}
- (void)setCmodel:(XWCommentModel *)cmodel{
    _cmodel = cmodel;
    self.accountNameLabel.text = [NSString stringWithFormat:@"%d",cmodel.uId];
    self.commentDetailLabel.text = [NSString stringWithFormat:@"%@",cmodel.eContent];
    self.timeLabel.text = [NSString stringWithFormat:@"%@",cmodel.eTime];
    self.likeNumLabel.text = [NSString stringWithFormat:@"%d",cmodel.like];
}
- (void)createCell{
    [self.contentView addSubview:self.iconImageView];
    [self.contentView addSubview:self.accountNameLabel];
    [self.contentView addSubview:self.commentDetailLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.likeBtn];
    [self.contentView addSubview:self.commentBtn];
    [self.contentView addSubview:self.likeNumLabel];
    [self.contentView addSubview:self.line];
    
    
    [self addFrame];
}
- (void)addFrame{
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(30*kScaleW);
        make.left.equalTo(self.contentView).offset(30*kScaleW);
        make.size.mas_equalTo(CGSizeMake(80*kScaleW, 80*kScaleH));
    }];
    [self.accountNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(30*kScaleW);
        make.left.equalTo(self.iconImageView.mas_right).offset(10*kScaleW);
        make.right.equalTo(self.contentView).offset(-30*kScaleW);
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.accountNameLabel.mas_bottom).offset(5*kScaleW);
        make.left.equalTo(self.iconImageView.mas_right).offset(10*kScaleW);
        make.right.equalTo(self.contentView).offset(-30*kScaleW);
    }];
    [self.commentDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconImageView.mas_bottom).offset(20*kScaleW);
        make.left.equalTo(self.iconImageView);
        make.right.equalTo(self.contentView).offset(-30*kScaleW);
    }];
    [self.likeNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView).offset(-30*kScaleW);
        make.right.equalTo(self.contentView).offset(-30*kScaleW);
    }];
    [self.likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.likeNumLabel);
        make.size.mas_equalTo(CGSizeMake(34*kScaleW, 31*kScaleH));
        make.right.equalTo(self.likeNumLabel.mas_left).offset(-5*kScaleW);
    }];
    [self.commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.likeNumLabel);
        make.size.mas_equalTo(CGSizeMake(34*kScaleW, 31*kScaleH));
        make.right.equalTo(self.likeBtn.mas_left).offset(-15*kScaleW);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-30*kScaleW);
        make.left.equalTo(self.contentView).offset(30*kScaleW);
        make.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(0.5);
    }];
}
- (UIImageView *)iconImageView{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.image = [UIImage imageNamed:@"comment_icon"];
    }
    return _iconImageView;
}
- (UILabel *)likeNumLabel{
    if (!_likeNumLabel) {
        _likeNumLabel = [[UILabel alloc] init];
        _likeNumLabel.textColor = [UIColor colorWithHex:@"666666"];
        _likeNumLabel.font = [UIFont rw_regularFontSize:14.0];
    }
    return _likeNumLabel;
}
- (UILabel *)accountNameLabel{
    if (!_accountNameLabel) {
        _accountNameLabel = [[UILabel alloc] init];
        _accountNameLabel.textColor = [UIColor colorWithHex:@"666666"];
        _accountNameLabel.font = [UIFont rw_regularFontSize:14.0];
    }
    return _accountNameLabel;
}
- (UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.textColor = [UIColor colorWithHex:@"999999"];
        _timeLabel.font = [UIFont rw_regularFontSize:14.0];
    }
    return _timeLabel;
}
- (UILabel *)commentDetailLabel{
    if (!_commentDetailLabel) {
        _commentDetailLabel = [[UILabel alloc] init];
        _commentDetailLabel.textColor = [UIColor colorWithHex:@"666666"];
        _commentDetailLabel.font = [UIFont rw_regularFontSize:14.0];
    }
    return _commentDetailLabel;
}
- (UIButton *)likeBtn{
    if (!_likeBtn) {
        _likeBtn = [[UIButton alloc] init];
        [_likeBtn setImage:[UIImage imageNamed:@"good"] forState:UIControlStateNormal];
//        [_likeBtn addTarget:self action:@selector(likeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _likeBtn;
}
- (UIButton *)commentBtn{
    if (!_commentBtn) {
        _commentBtn = [[UIButton alloc] init];
        [_commentBtn setImage:[UIImage imageNamed:@"comments"] forState:UIControlStateNormal];
        //        [_commentBtn addTarget:self action:@selector(likeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commentBtn;
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
