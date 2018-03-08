//
//  XWCollectViewCell.m
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/10.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWCollectViewCell.h"
#import "XWServiceModel.h"

@implementation XWCollectViewCell

- (void)setSmodel:(XWServiceModel *)smodel{
    _smodel = smodel;
    self.cType = smodel.category;
    self.titleLabel.text = smodel.sTitle;
    self.detailLabel0.text = [NSString stringWithFormat:@"%@:%@",self.categoryName[smodel.category-1],smodel.sketch];
    self.detailLabel1.text = smodel.orgName;
    self.moreBtn.hidden = NO;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
