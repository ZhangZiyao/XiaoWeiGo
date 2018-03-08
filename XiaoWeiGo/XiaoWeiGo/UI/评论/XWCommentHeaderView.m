//
//  XWCommentHeaderView.m
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/21.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWCommentHeaderView.h"
#import "XWCommentModel.h"

@interface XWCommentHeaderView ()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *accountNameLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *commentDetailLabel;

@end
@implementation XWCommentHeaderView
- (instancetype)initWithReuseIdentifier:(nullable NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.iconImageView];
        [self.contentView addSubview:self.accountNameLabel];
        [self.contentView addSubview:self.commentDetailLabel];
        [self.contentView addSubview:self.timeLabel];
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
            make.left.equalTo(self.iconImageView).offset(5*kScaleW);
            make.right.equalTo(self.contentView).offset(-30*kScaleW);
        }];
    }
    return self;
}
- (void)setModel:(XWCommentModel *)model{
    _model = model;
    self.accountNameLabel.text = [NSString stringWithFormat:@"%d",model.uId];
    self.commentDetailLabel.text = [NSString stringWithFormat:@"%@",model.eContent];
    self.timeLabel.text = [NSString stringWithFormat:@"%@",model.eTime];
    
}
- (UIImageView *)iconImageView{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.image = [UIImage imageNamed:@"comment_icon"];
    }
    return _iconImageView;
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
@end
