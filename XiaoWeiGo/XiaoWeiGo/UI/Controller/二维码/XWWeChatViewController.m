//
//  XWWeChatViewController.m
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/11.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWWeChatViewController.h"
#import <ZBarReaderController.h>

@interface XWWeChatViewController ()
@property (nonatomic, strong) UIImageView *qrCodeImageView;
@end

@implementation XWWeChatViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的二维码";
    [self showBackItem];
}
- (void)pressGesture:(UILongPressGestureRecognizer *)press{
    
    // 保存图片到相册
    UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"保存到相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { UIImageWriteToSavedPhotosAlbum(self.qrCodeImageView.image,self,@selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:),nil);
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertControl addAction:action];
    [alertControl addAction:cancelAction];
    [self presentViewController:alertControl animated:YES completion:nil];
    
    //识别二维码
    //    ZBarReaderController* read = [ZBarReaderController new];
    //    CGImageRef cgImageRef = ((UIImageView *)press.view).image.CGImage;
    //    ZBarSymbol* symbol = nil;
    //    for(symbol in  [read scanImage:cgImageRef])
    //        break;
    //    if (symbol.data.length > 0) {
    //        NSLog(@"识别到的内容 %@",symbol.data);
    //        //打开扫描到的连接
    //        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:symbol.data]];
    //    }
}
#pragma mark 保存图片后的回调
- (void)imageSavedToPhotosAlbum:(UIImage*)image didFinishSavingWithError:  (NSError*)error contextInfo:(id)contextInfo

{
    NSString*message =@"保存失败";
    
    if(!error) {
        
        message =@"成功保存到相册";
        
        UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alertControl addAction:action];
        
        [self presentViewController:alertControl animated:YES completion:nil];
        
    }else{
        message = [error description];
        
        UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertControl addAction:action];
        
        [self presentViewController:alertControl animated:YES completion:nil];
    }
}

- (void)layoutSubviews{
    UIScrollView *scrollview = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:scrollview];
    scrollview.scrollEnabled = NO;
    UIImageView *qrcodeImage = [[UIImageView alloc] init];
    qrcodeImage.image = [UIImage imageNamed:@"qrcode_img_code"];
    [scrollview addSubview:qrcodeImage];
    qrcodeImage.userInteractionEnabled = YES;
    UILongPressGestureRecognizer *pressG = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(pressGesture:)];
    [qrcodeImage addGestureRecognizer:pressG];
    self.qrCodeImageView = qrcodeImage;
    
    UIImageView *alertImage = [[UIImageView alloc] init];
    alertImage.image = [UIImage imageNamed:@"qrcode_alert_text"];
    [scrollview addSubview:alertImage];
    [qrcodeImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(scrollview).offset(60*kScaleW);
        make.top.equalTo(scrollview).offset(20*kScaleH);
        make.right.equalTo(scrollview).offset(-60*kScaleW);
        make.height.mas_equalTo(810*kScaleH);
    }];
    [alertImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(scrollview).offset(50*kScaleW);
        make.right.equalTo(scrollview).offset(-50*kScaleW);
        make.top.equalTo(qrcodeImage.mas_bottom).offset(40*kScaleH);
        make.height.mas_equalTo(323*kScaleH);
    }];
    scrollview.contentSize = CGSizeMake(0, ScreenHeight);
}
- (void)navLeftItemClick{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
