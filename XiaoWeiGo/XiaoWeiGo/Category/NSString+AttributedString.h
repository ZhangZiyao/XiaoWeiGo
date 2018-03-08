//
//  NSString+AttributedString.h
//  ucupay
//
//  Created by dingxin on 2017/7/11.
//  Copyright © 2017年 dingxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (AttributedString)

- (NSMutableAttributedString *)attrtbutedStringWithLineSpace:(CGFloat)lineSpace
                                                        font:(UIFont *)font
                                                       color:(UIColor *)color;
- (CGSize)sizeWithLabelWidth:(CGFloat)width font:(UIFont *)font;
//计算富文本字体高度
- (CGFloat)getSpaceLabelHeightwithSpeace:(CGFloat)lineSpeace withFont:(UIFont*)font withWidth:(CGFloat)width;
@end
