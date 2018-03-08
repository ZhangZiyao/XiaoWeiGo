//
//  XWAnswerViewCell.h
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/21.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWBaseCell.h"
@class XWCommentModel;

@interface XWAnswerViewCell : XWBaseCell

///处理评论的文字（包括xx回复yy）
- (void)configCellWithModel:(XWCommentModel *)model;

@end
