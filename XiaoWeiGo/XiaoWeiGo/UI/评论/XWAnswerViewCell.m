//
//  XWAnswerViewCell.m
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/21.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWAnswerViewCell.h"
#import "XWCommentModel.h"

@implementation XWAnswerViewCell

- (void)configCellWithModel:(XWCommentModel *)model{
    
    NSLog(@"replyArray replyArray replyArray %@",model.replyArray);
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
