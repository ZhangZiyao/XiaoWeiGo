//
//  XWListViewCell.m
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/9.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWListViewCell.h"
#import "XWCommonModel.h"
#import "CommandModel.h"
#import "XWServiceModel.h"
#import "NSString+Date.h"

@interface XWListViewCell ()

@property (nonatomic, strong) UIImageView *line;
@end

@implementation XWListViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self createCell];
    }
    return self;
}
- (void)setSerModel:(XWServiceModel *)serModel{
    _serModel = serModel;
    self.moreBtn.hidden = YES;
    self.titleLabel.text = serModel.sTitle;
    self.detailLabel0.text = [NSString stringWithFormat:@"%@:%@",self.categoryName[serModel.category-1],serModel.serviceName];
    self.detailLabel1.text = serModel.orgName;
}
- (void)setModel:(XWCommonModel *)model{
    _model = model;
    self.moreBtn.hidden = YES;
    self.titleLabel.text = model.sTitle;
    self.detailLabel0.text = [NSString stringWithFormat:@"%@:%@",self.categoryName[model.category-1],model.serviceName];
    self.detailLabel1.text = model.orgName;
    
}
- (void)setDmodel:(CommandModel *)dmodel{
    _dmodel = dmodel;
//    self.moreBtn.hidden = YES;
//    self.titleLabel.text = dmodel.dTitle;
//    self.detailLabel0.text = [NSString stringWithFormat:@"%@:%@",self.categoryName[dmodel.category-1],dmodel.serviceName];
//    self.detailLabel1.text = dmodel.orgName;
}

- (void)resetDataWith:(CommandModel *)dmodel category:(int)category{
    _dmodel = dmodel;
    self.moreBtn.hidden = YES;
    self.titleLabel.text = dmodel.dTitle;
    self.detailLabel0.text = [NSString stringWithFormat:@"%@:%@",self.categoryName[category==0?0:category-1],dmodel.serviceName];
    self.detailLabel1.text = StringPush(@"截止时间:", dmodel.endTime, @"");
}

- (NSArray *)categoryName{
    if ([NSString ifOutOfDateTime:[NSString ymdhDateToDateString:[NSDate date]] andEndDate:kCheckDate]) {
        
        NSArray *array = @[@"我有需求",@"创业创新",@"知识产权",@"共享会计",@"法律服务",@"优惠政策",@"ISO认证",@"展会服务",@"工商注册",@"其他服务"];
        return array;
    }else{
        NSArray *array = @[@"我要贷款",@"创业创新",@"知识产权",@"共享会计",@"法律服务",@"优惠政策",@"ISO认证",@"展会服务",@"工商注册",@"其他服务"];
        return array;
    }
}
- (void)setType:(HHShowTableCellType)type{
    _type = type;
    switch (self.type) {
        case HHShowPictureCellType:
        {
            self.leftImageView.hidden = NO;
            [self.leftImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.contentView).offset(30*kScaleW);
                make.top.equalTo(self.contentView).offset(25*kScaleW);
                make.width.mas_equalTo(100*kScaleW);
                make.height.mas_equalTo(100*kScaleW);
            }];
            [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.leftImageView.mas_right).offset(20*kScaleW);
                make.top.equalTo(self.leftImageView);
                make.right.equalTo(self.contentView).offset(-20*kScaleW);
            }];
            
            [self.detailLabel1 mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.titleLabel);
                make.bottom.equalTo(self.leftImageView);
                make.right.equalTo(self.contentView).offset(-20*kScaleW);
            }];
        }
            break;
        case HHShowNoPictureCellType:
        {
            self.leftImageView.hidden = YES;
            [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.contentView).offset(30*kScaleW);
                make.top.equalTo(self.contentView).offset(20*kScaleW);
                make.right.equalTo(self.contentView).offset(-20*kScaleW);
            }];
            
            [self.detailLabel1 mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.titleLabel);
                make.bottom.equalTo(self.contentView).offset(-20*kScaleW);
                make.right.equalTo(self.contentView).offset(-20*kScaleW);
            }];
        }
            break;
        case HHShowOtherCellType:
        {
            self.leftImageView.hidden = YES;
            [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.contentView).offset(30*kScaleW);
                make.top.equalTo(self.contentView).offset(20*kScaleW);
                make.right.equalTo(self.contentView).offset(-20*kScaleW);
            }];
            
            [self.detailLabel1 mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.contentView).offset(20*kScaleW);
                make.bottom.equalTo(self.contentView).offset(20*kScaleW);
                make.right.equalTo(self.contentView).offset(-20*kScaleW);
            }];
        }
            break;
        default:
            break;
    }
}
- (void)setCType:(int)cType{
    _cType = cType;
    NSArray *imageArr = @[@"loan_img_avatar",@"innovation_img_avatar",@"property_img_avatar",@"shared_img_avatar",@"legal_img_avatar",@"discount_img_avatar",@"certification_img_avatar",@"exhibition_img_avatar",@"registered_img_avatar",@"other_img_avatar"];
    self.leftImageView.image = [UIImage imageNamed:imageArr[_cType-1]];
}
- (void)createCell{
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.detailLabel0];
    [self.contentView addSubview:self.detailLabel1];
    [self.contentView addSubview:self.leftImageView];
    [self.contentView addSubview:self.line];
    [self.contentView addSubview:self.moreBtn];
    
    [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-30*kScaleW);
        make.bottom.equalTo(self.contentView).offset(-30*kScaleH);
        make.size.mas_equalTo(CGSizeMake(18, 3));
    }];
    
    switch (self.type) {
        case HHShowPictureCellType:
        {
            self.leftImageView.hidden = NO;
            [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.contentView).offset(30*kScaleW);
                make.top.equalTo(self.contentView).offset(25*kScaleW);
                make.width.mas_equalTo(100*kScaleW);
                make.height.mas_equalTo(100*kScaleW);
            }];
            [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.leftImageView.mas_right).offset(20*kScaleW);
                make.top.equalTo(self.leftImageView);
                make.right.equalTo(self.contentView).offset(-20*kScaleW);
            }];
            
            [self.detailLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.titleLabel);
                make.bottom.equalTo(self.leftImageView);
                make.right.equalTo(self.contentView).offset(-20*kScaleW);
            }];
            [self.detailLabel0 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.titleLabel);
                make.top.equalTo(self.titleLabel.mas_bottom).offset(4*kScaleW);
                make.right.equalTo(self.contentView).offset(-20*kScaleW);
            }];
            [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.contentView).offset(30*kScaleW);
                make.right.equalTo(self.contentView).offset(-30*kScaleW);
                make.bottom.equalTo(self.contentView);
                make.height.mas_equalTo(0.5);
            }];
        }
            break;
        case HHShowNoPictureCellType:
        {
            self.leftImageView.hidden = YES;
            [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.contentView).offset(30*kScaleW);
                make.top.equalTo(self.contentView).offset(20*kScaleW);
                make.right.equalTo(self.contentView).offset(-20*kScaleW);
            }];
            
            [self.detailLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.titleLabel);
                make.bottom.equalTo(self.contentView).offset(-20*kScaleW);
                make.right.equalTo(self.contentView).offset(-20*kScaleW);
            }];
            [self.detailLabel0 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.titleLabel);
                make.bottom.equalTo(self.detailLabel1.mas_top).offset(-5*kScaleH);
                make.right.equalTo(self.contentView).offset(-20*kScaleW);
            }];
            [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.contentView).offset(30*kScaleW);
                make.right.equalTo(self.contentView).offset(-30*kScaleW);
                make.bottom.equalTo(self.contentView);
                make.height.mas_equalTo(0.5);
            }];
        }
            break;
        case HHShowOtherCellType:
        {
            self.leftImageView.hidden = YES;
            [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.contentView).offset(30*kScaleW);
                make.top.equalTo(self.contentView).offset(20*kScaleW);
                make.right.equalTo(self.contentView).offset(-20*kScaleW);
            }];
            
            [self.detailLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.contentView).offset(20*kScaleW);
                make.bottom.equalTo(self.contentView).offset(20*kScaleW);
                make.right.equalTo(self.contentView).offset(-20*kScaleW);
            }];
            [self.detailLabel0 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.contentView).offset(20*kScaleW);
                make.bottom.equalTo(self.detailLabel1.mas_top).offset(-5*kScaleH);
                make.right.equalTo(self.contentView).offset(-20*kScaleW);
            }];
            [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.contentView).offset(30*kScaleW);
                make.right.equalTo(self.contentView).offset(-30*kScaleW);
                make.bottom.equalTo(self.contentView);
                make.height.mas_equalTo(0.5);
            }];
        }
            break;
        default:
            break;
    }
}
- (UIButton *)moreBtn{
    if (!_moreBtn) {
        _moreBtn = [[UIButton alloc] init];
        [_moreBtn setImage:[UIImage imageNamed:@"def_icon_point"] forState:UIControlStateNormal];
    }
    return _moreBtn;
}
- (UIImageView *)leftImageView{
    if (!_leftImageView) {
        _leftImageView = [[UIImageView alloc] init];
        _leftImageView.contentMode = UIViewContentModeScaleAspectFit;
        _leftImageView.image = [UIImage imageNamed:@"demand_img_avatar"];
    }
    return _leftImageView;
}
- (UIImageView *)line{
    if (!_line) {
        _line = [[UIImageView alloc] init];
        _line.backgroundColor = [UIColor OCRMainColor];;
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
- (UILabel *)detailLabel0{
    if (!_detailLabel0) {
        _detailLabel0 = [[UILabel alloc] init];
        _detailLabel0.textColor = [UIColor textGrayColor];
        _detailLabel0.font = [UIFont rw_regularFontSize:10];
        _detailLabel0.text = @"工商注册：工商登记等政务代理";
    }
    return _detailLabel0;
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
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
