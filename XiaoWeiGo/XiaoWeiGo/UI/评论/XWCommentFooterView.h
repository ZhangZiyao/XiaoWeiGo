//
//  XWCommentFooterView.h
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/21.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XWCommentModel;

@interface XWCommentFooterView : UITableViewHeaderFooterView

@property (nonatomic, strong) XWCommentModel *model;
@property (nonatomic, assign) NSInteger footerSection;
@property (nonatomic, strong) UIButton *likeBtn;
/**
 *  评论按钮的block
 */
@property (nonatomic, copy)void(^CommentBtnClickBlock)(UIButton *commentBtn,NSInteger footerSection,int modelId);

/**
 *  点赞按钮的block
 */
@property (nonatomic, copy)void(^LikeBtnClickBlock)(UIButton *likeBtn,NSInteger footerSection,int modelId);

@end
