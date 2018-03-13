//
//  PrivateManager.m
//  ucupay
//
//  Created by dingxin on 2017/10/9.
//  Copyright © 2017年 dingxin. All rights reserved.
//

#import "PrivateManager.h"
#import <AVFoundation/AVFoundation.h>

@implementation PrivateManager
- (BOOL)checkCamera{
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
        
        return NO;
    }
    return YES;
}
@end
