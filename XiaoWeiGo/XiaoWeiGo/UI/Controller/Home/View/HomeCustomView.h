//
//  HomeCustomView.h
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/3.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HomeCustomViewDelegate <NSObject>
@optional

-(void)tapAction:(int)tag;

@end

typedef enum : NSUInteger {
    CustomLinePositionLeft,//图片在左
    CustomLinePositionRight,//图片在右
    CustomLinePositionTop,//图片在上
    CustomLinePositionBottom,//图片在下
} CustomLinePosition;
typedef enum : NSUInteger {
    CustomImagePositionFirst,
    CustomImagePositionRightEdge0,
    CustomImagePositionTopEdge0,
    CustomImagePositionCenter,//图片在下
} CustomImagePosition;



@interface HomeCustomView : UIView

@property (nonatomic, assign) CustomLinePosition linePosition;

@property (nonatomic, assign) CustomImagePosition imagePosition;

@property (nonatomic, strong)   UILabel *titleLabel;
@property (nonatomic, strong)   UILabel *detailLabel;
@property (nonatomic, strong)   UIImageView *smallImageView;
@property (strong, nonatomic)   UIImageView *line;


@property (weak, nonatomic)  id<HomeCustomViewDelegate>  delegate;

- (void)refershData:(id)data;

@end

