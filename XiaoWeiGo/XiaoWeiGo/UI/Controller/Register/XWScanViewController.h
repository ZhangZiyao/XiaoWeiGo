//
//  XWScanViewController.h
//  XiaoWeiGo
//
//  Created by dingxin on 2018/3/8.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWBaseViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface XWScanViewController : XWBaseViewController
@property (strong,nonatomic)AVCaptureDevice * device;
@property (strong,nonatomic)AVCaptureDeviceInput * input;
@property (strong,nonatomic)AVCaptureMetadataOutput * output;
@property (strong,nonatomic)AVCaptureSession * session;
@property (strong,nonatomic)AVCaptureVideoPreviewLayer * preview;

@property (nonatomic, assign) int type;
@end
