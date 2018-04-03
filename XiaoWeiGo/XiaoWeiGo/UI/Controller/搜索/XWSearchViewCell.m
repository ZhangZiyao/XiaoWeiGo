//
//  XWSearchViewCell.m
//  XiaoWeiGo
//
//  Created by dingxin on 2018/4/3.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWSearchViewCell.h"
#import <YYText.h>
#import "NewsModel.h"

@interface XWSearchViewCell ()
@property (nonatomic, strong)   YYLabel *titleLabel;
@property (nonatomic, strong)   UILabel *detailLabel;
@property (strong, nonatomic)   UIImageView *line;
@end
@implementation XWSearchViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createCell];
    }
    return self;
}
- (void)setModel:(NewsModel *)model{
    _model = model;
    NSArray *typeArray = @[@[@"全部", @"服务",@"需求", @"企业", @"服务商",@"政策"],@[@0,@2,@5,@4,@3,@1]];
    NSString *cTitle = [NSString stringWithFormat:@"%@-%@",typeArray[0][[typeArray[1] indexOfObject:@(model.type)]],model.aTitle];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:cTitle];
    // 2. 为文本设置属性
    str.yy_font = [UIFont rw_regularFontSize:13.0];
    str.yy_color = [UIColor blackColor];
    NSRange range = [cTitle rangeOfString:@"-"];
    [str yy_setColor:mainColor range:NSMakeRange(0, range.location+1)];
    str.yy_lineSpacing = 5;
    self.titleLabel.attributedText = str;
    self.detailLabel.text = model.aTime;
}
- (void)createCell{
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.detailLabel];
    [self.contentView addSubview:self.line];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(20*kScaleW);
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-200*kScaleW);
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(180*kScaleW);
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-20*kScaleW);
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(30*kScaleW);
        make.right.equalTo(self.contentView).offset(-30*kScaleW);
        make.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(0.5);
    }];
}
- (UIImageView *)line{
    if (!_line) {
        _line = [[UIImageView alloc] init];
        _line.backgroundColor = [UIColor lineColor];
    }
    return _line;
}
- (YYLabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[YYLabel alloc] init];
        _titleLabel.textColor = [UIColor textBlackColor];
        _titleLabel.font = [UIFont rw_mediumFontSize:14.0];
    }
    return _titleLabel;
}
- (UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc] init];
        _detailLabel.textColor = [UIColor textGrayColor];
        _detailLabel.font = [UIFont rw_regularFontSize:12.0];
        _detailLabel.textAlignment = NSTextAlignmentRight;
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
