//
//  XWAttachmentModel.h
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/11.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWModel.h"

@interface XWAttachmentModel : XWModel
/**
 *  附件表ID
 */
@property (nonatomic, assign) int ID;
/**
 *  附件名称
 */
@property (nonatomic, copy) NSString *attName;
/**
 *  服务器上存储的名称(需在前面加上我们的网址再加上xc目录)
 */
@property (nonatomic, copy) NSString *attUrl;
@end
