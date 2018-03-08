//
//  UIImage+RWImage.h
//  ucupay
//
//  Created by dingxin on 2017/7/13.
//  Copyright © 2017年 dingxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (RWImage)

+ (NSData *)reSizeImageData:(UIImage *)sourceImage maxImageSize:(CGFloat)maxImageSize maxSizeWithKB:(CGFloat) maxSize;

+ (UIImage *)imageWithColor:(UIColor *)color;

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

+ (NSData *)resetSizeOfImageData:(UIImage *)source_image maxSize:(NSInteger)maxSize;

@end
