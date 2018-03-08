//
//  XWCommentModel.m
//  XiaoWeiGo
//
//  Created by Ziyao on 2018/2/14.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWCommentModel.h"

@implementation XWCommentModel

- (instancetype)init{
    if (self = [super init]) {
        if (self.eContent) {
            self.rowHeight = [self.eContent sizeWithLabelWidth:ScreenWidth-80*kScaleW font:[UIFont rw_regularFontSize:15.0]].height+10;
        }else{
            self.rowHeight = 30;
        }
        
    }
    return self;
}

@end
