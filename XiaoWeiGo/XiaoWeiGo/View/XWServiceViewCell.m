//
//  XWServiceViewCell.m
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/28.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWServiceViewCell.h"
#import "XWServiceModel.h"
#import "CommandModel.h"

@interface XWServiceViewCell ()<UIWebViewDelegate>
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detail0Label;
@property (nonatomic, strong) UILabel *detail1Label;
@property (nonatomic, strong) UILabel *detail2Label;
@property (nonatomic, strong) UILabel *detail3Label;
@property (nonatomic, strong) UILabel *detail4Label;
@property (nonatomic, strong) UILabel *detail5Label;
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation XWServiceViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.cellheight = 440*kScaleH;
        [self createCell];
    }
    return self;
}
- (void)setDmodel:(CommandModel *)dmodel{
    _dmodel = dmodel;
    self.webView.hidden = YES;
    self.titleLabel.hidden = YES;
    self.detail0Label.hidden = NO;
    self.detail2Label.hidden = NO;
    self.detail3Label.hidden = NO;
    self.detail4Label.hidden = NO;
    self.detail5Label.hidden = NO;
    self.detail0Label.text = [NSString stringWithFormat:@"需求方：%@",dmodel.serviceName];
    self.detail1Label.text = [NSString stringWithFormat:@"简要标题：%@",dmodel.dTitle];
    self.detail2Label.text = [NSString stringWithFormat:@"简要描述：%@",dmodel.serviceName];
    self.detail3Label.text = [NSString stringWithFormat:@"详细信息：%@",dmodel.dContent];
    self.detail4Label.text = [NSString stringWithFormat:@"办贷流程：%@",dmodel.serviceName];
    self.detail5Label.text = [NSString stringWithFormat:@"申请介绍：点击下面的“我要申请”按钮，服务机构收到后1-3个工作日会电话联系，通过后，再由申请人携带相关资料（原材料或复印件已在材料清单中注明）到窗口办理正式审批手续。"];
    
}
- (void)setCmodel:(XWServiceModel *)cmodel{
    _cmodel = cmodel;
    if (cmodel == nil) {
        return;
    }
//    if (cmodel.category == 1) {
//        NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[cmodel.details dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} documentAttributes:nil error:nil];
//        self.detail0Label.attributedText = attrStr;
    self.webView.hidden = NO;
    self.titleLabel.hidden = YES;
    self.detail0Label.hidden = YES;
    self.detail2Label.hidden = YES;
    self.detail3Label.hidden = YES;
    self.detail4Label.hidden = YES;
    self.detail5Label.hidden = YES;
    
    [self.webView loadHTMLString:cmodel.details baseURL:nil];
        
//        self.detail5Label.hidden = NO;
//        self.detail0Label.text = [NSString stringWithFormat:@"适用对象：%@",@"进入工业园区的初创期中小企业"];
//        self.detail1Label.text = [NSString stringWithFormat:@"产品介绍：%@",@"抵押贷款"];
//        self.detail2Label.text = [NSString stringWithFormat:@"产品功能：%@",[NSString ifNull:cmodel.details]];
//        self.detail3Label.text = [NSString stringWithFormat:@"产品特点：%@",[NSString ifNull:cmodel.serviceName]];
//        self.detail4Label.text = [NSString stringWithFormat:@"办贷流程：%@",[NSString ifNull:cmodel.serviceName]];
//        self.detail5Label.text = [NSString stringWithFormat:@"申请介绍：点击下面的“我要申请”按钮，服务机构收到后1-3个工作日会电话联系，通过后，再由申请人携带相关资料（原材料或复印件已在材料清单中注明）到窗口办理正式审批手续。"];
//    }else{
//        self.detail5Label.hidden = YES;
//        self.detail0Label.text = [NSString stringWithFormat:@"服务主要内容：%@",[NSString ifNull:cmodel.serviceName]];
//        self.detail1Label.text = [NSString stringWithFormat:@"服务方式：%@",[NSString ifNull:cmodel.serviceName]];
//        self.detail2Label.text = [NSString stringWithFormat:@"服务对象：%@",[NSString ifNull:cmodel.contacts]];
//        self.detail3Label.text = [NSString stringWithFormat:@"服务模式：%@",[NSString ifNull:cmodel.serviceName]];
//        self.detail4Label.text = [NSString stringWithFormat:@"服务流程说明：%@",[NSString ifNull:cmodel.sketch]];
//    }
}

- (void)createCell{
//    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.detail0Label];
    [self.contentView addSubview:self.detail1Label];
    [self.contentView addSubview:self.detail2Label];
    [self.contentView addSubview:self.detail3Label];
    [self.contentView addSubview:self.detail4Label];
    [self.contentView addSubview:self.detail5Label];
    [self.contentView addSubview:self.webView];
    
    [self addFrame];
}
- (void)addFrame{
    
//    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.contentView).offset(40*kScaleW);
//        make.left.equalTo(self.contentView).offset(40*kScaleW);
//        make.right.equalTo(self.contentView).offset(-40*kScaleW);
//        make.centerX.equalTo(self.contentView);
//    }];
    
    [self.detail0Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(40*kScaleW);
        make.right.equalTo(self.contentView).offset(-40*kScaleW);
        make.top.equalTo(self.contentView).offset(30*kScaleW);
//        make.bottom.equalTo(self.contentView).offset(30*kScaleW);
        //        make.width.mas_equalTo(150*kScaleW);
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
    [self.detail5Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.detail0Label);
        make.top.equalTo(self.detail4Label.mas_bottom).offset(20*kScaleW);
        make.right.equalTo(self.contentView).offset(-40*kScaleW);
    }];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(20*kScaleW);
        make.right.equalTo(self.contentView).offset(-20*kScaleW);
        make.top.equalTo(self.contentView).offset(20*kScaleW);
        make.bottom.equalTo(self.contentView).offset(-20*kScaleW);
        //        make.width.mas_equalTo(150*kScaleW);
    }];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
//    CGSize actualSize = [webView sizeThatFits:CGSizeZero];
//
//    CGRect newFrame = webView.frame;
//
//    newFrame.size.height = actualSize.height;
//
//    webView.frame = newFrame;
//
//    self.cellheight = webView.frame.size.height+20;
//
//    self.heightBlock();

}
- (UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc] init];
//        _webView.scrollView.scrollEnabled = NO;
        _webView.delegate = self;
    }
    return _webView;
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
- (UILabel *)detail5Label{
    if (!_detail5Label) {
        _detail5Label = [[UILabel alloc] init];
        _detail5Label.textColor = UIColorFromRGB16(0X666666);
        _detail5Label.font = [UIFont rw_regularFontSize:13.0];
        _detail5Label.textAlignment = NSTextAlignmentLeft;
        _detail5Label.numberOfLines = 0;
    }
    return _detail5Label;
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
