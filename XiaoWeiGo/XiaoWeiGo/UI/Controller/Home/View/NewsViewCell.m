//
//  NewsViewCell.m
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/3.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "NewsViewCell.h"
#import "NewsModel.h"

@interface NewsViewCell ()
@property (nonatomic, strong)   UILabel *titleLabel;
@property (nonatomic, strong)   UILabel *detailLabel;
@property (nonatomic, strong)   UIImageView *smallImageView;
@property (strong, nonatomic)   UIImageView *line;

@end
@implementation NewsViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self createCell];
    }
    return self;
}
- (void)resetDataWithModel:(NewsModel *)model type:(XWNewsTableCellType)type{
    [self.smallImageView sd_setImageWithURL:[NSURL URLWithString:model.coverImg] placeholderImage:[UIImage imageNamed:@"news_placeholder"]];
    self.titleLabel.text = model.aTitle;
    self.detailLabel.text = model.subTitle;
//    switch (type) {
//        case XWNewsPictureCellType:
//        {
//
//        }
//            break;
//        case XWNewsNoPictureCellType:
//        {
//
//        }
//            break;
//        case XWNewsOtherCellType:
//        {
//
//        }
//            break;
//
//        default:
//            break;
//    }
}
- (void)setNmodel:(NewsModel *)nmodel{
    _nmodel = nmodel;
    
    [self.smallImageView sd_setImageWithURL:[NSURL URLWithString:nmodel.coverImg] placeholderImage:[UIImage imageNamed:@"news_placeholder"]];
    self.titleLabel.text = nmodel.aTitle;
    self.detailLabel.text = nmodel.subTitle;
    
}

- (void)createCell{
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.detailLabel];
    [self.contentView addSubview:self.smallImageView];
    [self.contentView addSubview:self.line];
    [self.smallImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(20*kScaleW);
        make.top.equalTo(self.contentView).offset(20*kScaleW);
        make.bottom.equalTo(self.contentView);
        make.width.mas_equalTo(150*kScaleW);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.smallImageView.mas_right).offset(20*kScaleW);
        make.top.equalTo(self.contentView).offset(20*kScaleW);
        make.right.equalTo(self.contentView).offset(-20*kScaleW);
    }];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.smallImageView.mas_right).offset(20*kScaleW);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10*kScaleW);
        make.right.equalTo(self.contentView).offset(-20*kScaleW);
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.smallImageView.mas_right).offset(20*kScaleW);
        make.right.equalTo(self.contentView).offset(-20*kScaleW);
        make.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(0.5);
    }];
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
        _line.backgroundColor = LineColor;
    }
    return _line;
}
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor textBlackColor];
        _titleLabel.font = [UIFont rw_regularFontSize:14];
    }
    return _titleLabel;
}
- (UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc] init];
        _detailLabel.textColor = [UIColor textGrayColor];
        _detailLabel.font = [UIFont rw_regularFontSize:13];
        _detailLabel.numberOfLines = 2;
    }
    return _detailLabel;
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
