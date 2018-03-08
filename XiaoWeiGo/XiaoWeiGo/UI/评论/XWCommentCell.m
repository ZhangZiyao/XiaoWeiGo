//
//  XWCommentCell.m
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/21.
//  Copyright © 2018年 xwjy. All rights reserved.
//
#define kGAP 10

#import "XWCommentCell.h"
#import "CopyAbleLabel.h"
#import "XWCommentInfoModel.h"
#import "XWCommentModel.h"

@interface XWCommentCell ()
@property (nonatomic, strong) UILabel *contentLabel;
@end
@implementation XWCommentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
//        UIColor *bgColor = [UIColor colorWithRed:236.0/256.0 green:236.0/256.0 blue:236.0/256.0 alpha:0.4];
//        self.backgroundColor = [UIColor blueColor];
        UIView *bgView = [[UIView alloc] init];
        bgView.backgroundColor = bgColor;
        [self.contentView addSubview:bgView];
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(35*kScaleW);
            make.right.equalTo(self.contentView).offset(-35*kScaleW);
        }];
        
        self.contentLabel = [[CopyAbleLabel alloc] init];
        self.contentLabel.backgroundColor = bgColor;
        self.contentLabel.preferredMaxLayoutWidth = ScreenWidth-40;
        self.contentLabel.lineBreakMode = NSLineBreakByCharWrapping;
        self.contentLabel.numberOfLines = 0;
        self.contentLabel.font = [UIFont systemFontOfSize:13.0];
        [bgView addSubview:self.contentLabel];

        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(bgView).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];

//        [self createCell];
    }
    return self;
}
- (void)createCell{
    self.contentLabel.text = @"回复内容";
}
-(void)setModel:(XWCommentInfoModel *)model{
//    if ([model isKindOfClass:[XWCommentInfoModel class]]) {
//        self.contentLabel.attributedText = model.attributedText;
//    }else{
//        self.contentLabel.text = @"数组";
//    }
    [self configCellWithModel:model];
}
- (void)configCellWithModel:(XWCommentInfoModel *)model {
    NSString *str  = nil;
    
//    if (model.uId != model.eId) {
//        str= [NSString stringWithFormat:@"%d回复%d：%@",
//              model.uId, model.eId, model.rContent];
//    }else{
        str= [NSString stringWithFormat:@"%d：%@",
              model.uId, model.rContent];
//    }
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:str];
    NSMutableParagraphStyle *muStyle = [[NSMutableParagraphStyle alloc] init];
    
//    if ([text.string isMoreThanOneLineWithSize:CGSizeMake(ScreenWidth-kGAP-2*kGAP, CGFLOAT_MAX) font:[UIFont systemFontOfSize:13.0] lineSpaceing:5.0]) {//margin
//        muStyle.lineSpacing = 5.0;//设置行间距离
//    }else{
        muStyle.lineSpacing = CGFLOAT_MIN;//设置行间距离
//    }
    NSString *cBy = [NSString stringWithFormat:@"%d",model.uId];
    
    [text addAttribute:NSParagraphStyleAttributeName value:muStyle range:NSMakeRange(0, text.length)];
    
    [text addAttribute:NSForegroundColorAttributeName
                 value:[UIColor orangeColor]
                 range:NSMakeRange(0, cBy.length+1)];
//    [text addAttribute:NSForegroundColorAttributeName
//                 value:[UIColor blueColor]
//                 range:NSMakeRange(1 + 2, 1)];
    
    self.contentLabel.attributedText = text;
}
#pragma mark
#pragma mark cell左边缩进64，右边缩进10
//-(void)setFrame:(CGRect)frame{
//    CGFloat leftSpace = 35*kScaleW;
//    frame.origin.x = leftSpace;
//    frame.size.width = ScreenWidth - leftSpace*2;
//    [super setFrame:frame];
//}
//-(void)setModel:(XWCommentInfoModel *)model{
//    if ([model isKindOfClass:[XWCommentInfoModel class]]) {
////        self.contentLabel.attributedText = model.attributedText;
//    }else{
//        self.contentLabel.text = @"数组";
//    }
//}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
