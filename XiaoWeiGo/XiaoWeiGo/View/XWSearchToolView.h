//
//  XWSearchToolView.h
//  XiaoWeiGo
//
//  Created by dingxin on 2018/3/21.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XWSearchToolView : UIView

/** 左边Item点击 */
@property (nonatomic, copy) dispatch_block_t leftItemClickBlock;
/** 右边Item点击 */
//@property (nonatomic, copy) dispatch_block_t rightItemClickBlock;

@end
