//
//  HomeCustomView.m
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/3.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "HomeCustomView.h"

@implementation HomeCustomView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initialization];
    }
    return self;
}
- (void)refershData:(id)data
{
    NSDictionary *dict = data;
    self.titleLabel.text = dict[@"title"];
    self.detailLabel.text = dict[@"content"];
    self.smallImageView.image = [UIImage imageNamed:dict[@"image"]];
}
- (void)initialization
{
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:tap];
}
- (void)tapAction:(UITapGestureRecognizer *)tap{
    [self.delegate tapAction:(int)tap.view.tag];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self addSubview:self.smallImageView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.detailLabel];
    [self addSubview:self.line];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(35*kScaleW);
        make.top.equalTo(self).offset(20*kScaleW);
    }];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(35*kScaleW);
        make.top.equalTo(self.titleLabel.mas_bottom);
    }];
    switch (_imagePosition) {
        case CustomImagePositionCenter:
            {
                [self.smallImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(self).offset(-20*kScaleW);
                    make.centerY.equalTo(self);
//                    make.top.equalTo(self).offset(-20*kScaleW);
//                    make.bottom.equalTo(self).offset(-20*kScaleW);
                    make.size.mas_equalTo(CGSizeMake(98*kScaleW, 82*kScaleH));
                }];
            }
            break;
        case CustomImagePositionTopEdge0:
        {
            [self.smallImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self);
                make.centerY.equalTo(self);
                make.top.equalTo(self);
                make.bottom.equalTo(self);
//                make.size.mas_equalTo(CGSizeMake(98*kScaleW, 82*kScaleH));
            }];
        }
            break;
        case CustomImagePositionRightEdge0:
        {
            [self.smallImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self).offset(-10*kScaleW);
                make.centerY.equalTo(self);
                make.top.equalTo(self);
                make.bottom.equalTo(self);
//                make.size.mas_equalTo(CGSizeMake(98*kScaleW, 82*kScaleH));
            }];
        }
            break;
        case CustomImagePositionFirst:
        {
            [self.smallImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self).offset(-10*kScaleW);
                make.centerY.equalTo(self).offset(10*kScaleW);
                make.size.mas_equalTo(CGSizeMake(188*kScaleW, 118*kScaleH));
            }];
        }
            break;
        default:
        {
            [self.smallImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self).offset(-10*kScaleW);
                make.centerY.equalTo(self);
                make.top.equalTo(self);
                make.bottom.equalTo(self);
//                make.size.mas_equalTo(CGSizeMake(98*kScaleW, 82*kScaleH));
            }];
        }
            break;
    }
    switch (_linePosition) {
        case CustomLinePositionTop:
        {
            [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self);
                make.right.equalTo(self);
                make.top.equalTo(self);
                make.height.mas_equalTo(0.5);
            }];
        }
            break;
        case CustomLinePositionLeft:
        {
            [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self);
                make.bottom.equalTo(self);
                make.top.equalTo(self);
                make.width.mas_equalTo(0.5);
            }];
        }
            break;
        case CustomLinePositionRight:
        {
            [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self);
                make.right.equalTo(self);
                make.top.equalTo(self);
                make.width.mas_equalTo(0.5);
            }];
        }
            break;
        case CustomLinePositionBottom:
        {
            [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self);
                make.right.equalTo(self);
                make.bottom.equalTo(self);
                make.height.mas_equalTo(0.5);
            }];
        }
            break;
            
        default:
        {
            self.line.hidden = YES;
        }
            break;
    }
}
- (void)setImagePosition:(CustomImagePosition)imagePosition{
    _imagePosition = imagePosition;
}
- (void)setLinePosition:(CustomLinePosition)linePosition
{
    _linePosition = linePosition;
    [self setNeedsLayout];
}
- (UIImageView *)smallImageView{
    if (!_smallImageView) {
        _smallImageView = [[UIImageView alloc] init];
        _smallImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _smallImageView;
}
- (UIImageView *)line{
    if (!_line) {
        _line = [[UIImageView alloc] init];
        _line.backgroundColor = UIColorFromRGB16(0xd2d2d2);
    }
    return _line;
}
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
//        _titleLabel.textColor = [UIColor textBlackColor];
        _titleLabel.font = [UIFont rw_regularFontSize:15];
    }
    return _titleLabel;
}
- (UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc] init];
        _detailLabel.textColor = [UIColor textGrayColor];
        _detailLabel.font = [UIFont rw_regularFontSize:12];
        _detailLabel.numberOfLines = 2;
    }
    return _detailLabel;
}
@end
