//
//  XWCommentFooterView.m
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/21.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWCommentFooterView.h"
#import "XWCommentModel.h"

@interface XWCommentFooterView ()

@property (nonatomic, strong) UIButton *commentBtn;
@property (nonatomic, strong) UILabel *likeNumLabel;
@property (nonatomic, strong) UILabel *line;



@end
@implementation XWCommentFooterView
- (instancetype)initWithReuseIdentifier:(nullable NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.likeBtn];
        [self.contentView addSubview:self.commentBtn];
        [self.contentView addSubview:self.likeNumLabel];
        [self.contentView addSubview:self.line];
        [self.likeNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.right.equalTo(self.contentView).offset(-30*kScaleW);
        }];
        [self.likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.likeNumLabel);
            make.size.mas_equalTo(CGSizeMake(40*kScaleW, 40*kScaleH));
            make.right.equalTo(self.likeNumLabel.mas_left).offset(-10*kScaleW);
        }];
        [self.commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.likeNumLabel);
            make.size.mas_equalTo(CGSizeMake(40*kScaleW, 40*kScaleH));
            make.right.equalTo(self.likeBtn.mas_left).offset(-30*kScaleW);
        }];
        
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-30*kScaleW);
            make.left.equalTo(self.contentView).offset(30*kScaleW);
            make.bottom.equalTo(self.contentView);
            make.height.mas_equalTo(0.5);
        }];
    }
    return self;
}
-(void)commentAction:(UIButton *)sender{
    if (self.CommentBtnClickBlock) {
        self.CommentBtnClickBlock(sender,self.footerSection,self.model.ID);
    }
}
-(void)likeAction:(UIButton *)sender{
    if (self.LikeBtnClickBlock) {
        self.LikeBtnClickBlock(sender,self.footerSection,self.model.ID);
    }
}
- (void)setModel:(XWCommentModel *)model{
    _model = model;
    self.likeNumLabel.text = [NSString stringWithFormat:@"%d",model.like];
}
- (UILabel *)likeNumLabel{
    if (!_likeNumLabel) {
        _likeNumLabel = [[UILabel alloc] init];
        _likeNumLabel.textColor = [UIColor colorWithHex:@"666666"];
        _likeNumLabel.font = [UIFont rw_regularFontSize:14.0];
    }
    return _likeNumLabel;
}
- (UIButton *)likeBtn{
    if (!_likeBtn) {
        _likeBtn = [[UIButton alloc] init];
        [_likeBtn setImage:[UIImage imageNamed:@"good"] forState:UIControlStateNormal];
        [_likeBtn addTarget:self action:@selector(likeAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _likeBtn;
}
- (UIButton *)commentBtn{
    if (!_commentBtn) {
        _commentBtn = [[UIButton alloc] init];
        [_commentBtn setImage:[UIImage imageNamed:@"comments"] forState:UIControlStateNormal];
        [_commentBtn addTarget:self action:@selector(commentAction:) forControlEvents:UIControlEventTouchUpInside];
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
@end
