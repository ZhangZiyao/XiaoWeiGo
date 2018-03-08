//
//  XWOrgViewCell.m
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/11.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWOrgViewCell.h"
#import "XWOrgModel.h"

@implementation XWOrgViewCell

- (void)setSmodel:(XWOrgModel *)smodel{
    _smodel = smodel;
    self.titleLabel.text = _smodel.sTitle;;
    self.detailLabel0.text = StringPush(@"服务类型：", _smodel.serviceName, @"");
    self.detailLabel1.text = StringPush(@"机构名称：", _smodel.orgName, @"");
    self.leftImageView.image = [UIImage imageNamed:[NSString getImageNameWithCategory:_smodel.category]];
}
- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
