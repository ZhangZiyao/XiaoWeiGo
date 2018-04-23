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
//@property (nonatomic, strong)   UIImageView *smallImageView;
@property (strong, nonatomic)   UIImageView *line;
//@property (strong, nonatomic)   UIButton *moreBtn;
@property (nonatomic, strong)   UIButton *funcBtn;

@end
@implementation XWCommandCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createCell];
    }
    return self;
}
- (void)setModel:(CommandModel *)model{
    _model = model;
    self.titleLabel.text = model.dTitle;
    self.detailLabel.text =StringPush(@"服务类型: ", model.serviceName, @"");
    self.detailLabel1.text = model.endTime;
    if (model.auditing == 1 || model.auditing == 0) {//审核状态(-1:所有的,0:待审核,1:审核通过,2:退回)
        self.funcBtn.hidden = NO;
        [self.funcBtn setTitle:@"撤回" forState:UIControlStateNormal];
    }else if (model.auditing == 2){
        self.funcBtn.hidden = NO;
        [self.funcBtn setTitle:@"重发" forState:UIControlStateNormal];
    }else{
        self.funcBtn.hidden = YES;
    }
}
- (void)func{
    
    if (self.model.auditing == 0 || self.model.auditing == 1) {
        RequestManager *manager = [[RequestManager alloc] init];
        manager.isShowLoading = NO;
        //    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        [params setValuesForKeysWithDictionary:@{@"uId":[USER_DEFAULT objectForKey:USERIDKEY],
                                                 @"id":@(self.model.ID),
                                                 @"rePublishOrRecall":@1,//重发或撤回(1:重发,2:撤回)
                                                 @"title":self.model.dTitle,
                                                 @"content":@"",
                                                 @"starTime":self.model.starTime,
                                                 @"endTime":self.model.endTime,
                                                 @"category":@([NSString getCategoryIDWithCategoryName:self.model.serviceName])
                                                 }];
        
        [manager POSTRequestUrlStr:kChangeDemandStatus parms:params success:^(id responseData) {
            NSLog(@"设置需求状态  %@",responseData);
            if ([responseData[0] isEqualToString:@"success"]) {
                SendNotify(@"reloadDD", nil);
            }
        } fail:^(NSError *error) {
            
        }];
    }else if(self.model.auditing == 2){
        if (self.funcBtnClickBlock) {
            self.funcBtnClickBlock(self.model, self.model.auditing);
        }
    }
}
- (void)createCell{
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.detailLabel];
    [self.contentView addSubview:self.detailLabel1];
//    [self.contentView addSubview:self.smallImageView];
    [self.contentView addSubview:self.line];
    [self.contentView addSubview:self.funcBtn];
    
//    [self.smallImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.contentView).offset(30*kScaleW);
//        make.top.equalTo(self.contentView).offset(35*kScaleW);
//        make.width.mas_equalTo(100*kScaleW);
//        make.height.mas_equalTo(100*kScaleW);
//    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(30*kScaleW);
        make.top.equalTo(self.contentView).offset(35*kScaleW);
        make.right.equalTo(self.contentView).offset(-20*kScaleW);
    }];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10*kScaleH);
        make.right.equalTo(self.contentView).offset(-20*kScaleW);
    }];
    [self.detailLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
//        make.top.equalTo(self.detailLabel.mas_bottom).offset(5*kScaleW);
        make.top.equalTo(self.detailLabel.mas_bottom).offset(5*kScaleH);
        make.right.equalTo(self.contentView).offset(-20*kScaleW);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(30*kScaleW);
        make.right.equalTo(self.contentView).offset(-30*kScaleW);
        make.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(0.5);
    }];
//    [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self.contentView).offset(-30*kScaleW);
//        make.bottom.equalTo(self.contentView).offset(-30*kScaleH);
//        make.size.mas_equalTo(CGSizeMake(18, 3));
//    }];
    [self.funcBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-30*kScaleW);
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
}
//- (UIButton *)moreBtn{
//    if (!_moreBtn) {
//        _moreBtn = [[UIButton alloc] init];
//        [_moreBtn setImage:[UIImage imageNamed:@"def_icon_point"] forState:UIControlStateNormal];
//    }
//    return _moreBtn;
//}
- (UIButton *)funcBtn{
    if (!_funcBtn) {
        _funcBtn = [[UIButton alloc] init];
//        [_funcBtn setImage:[UIImage imageNamed:@"def_icon_point"] forState:UIControlStateNormal];
        [_funcBtn setTitleColor:mainColor forState:UIControlStateNormal];
        [_funcBtn.titleLabel setFont:[UIFont rw_regularFontSize:15.0]];
        [_funcBtn addTarget:self action:@selector(func) forControlEvents:UIControlEventTouchUpInside];
    }
    return _funcBtn;
}
//- (UIImageView *)smallImageView{
//    if (!_smallImageView) {
//        _smallImageView = [[UIImageView alloc] init];
//        _smallImageView.contentMode = UIViewContentModeScaleAspectFit;
//        _smallImageView.image = [UIImage imageNamed:@"demand_img_avatar"];
//    }
//    return _smallImageView;
//}
- (UIImageView *)line{
    if (!_line) {
        _line = [[UIImageView alloc] init];
        _line.backgroundColor = [UIColor OCRMainColor];
    }
    return _line;
}
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor textBlackColor];
        _titleLabel.font = [UIFont rw_mediumFontSize:14.0];
        _titleLabel.text = @"公司注册，代理记账";
    }
    return _titleLabel;
}
- (UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc] init];
        _detailLabel.textColor = [UIColor textGrayColor];
        _detailLabel.font = [UIFont rw_regularFontSize:10];
        _detailLabel.text = @"登记注册：工商登记等政务代理";
    }
    return _detailLabel;
}
- (UILabel *)detailLabel1{
    if (!_detailLabel1) {
        _detailLabel1 = [[UILabel alloc] init];
        _detailLabel1.textColor = [UIColor textGrayColor];
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
