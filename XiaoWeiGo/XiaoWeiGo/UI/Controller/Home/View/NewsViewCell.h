//
//  NewsViewCell.h
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/3.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NewsModel;

typedef NS_ENUM(NSInteger,XWNewsTableCellType) {
    XWNewsPictureCellType = 0, //cell带图片
    XWNewsNoPictureCellType = 1, //cell  没有图片
    XWNewsOtherCellType = 2 //其他
};

@interface NewsViewCell : UITableViewCell

@property (nonatomic, assign) XWNewsTableCellType cellType;

@property (nonatomic, strong) NewsModel *nmodel;

- (void)resetDataWithModel:(NewsModel *)model type:(XWNewsTableCellType)type;

@end
