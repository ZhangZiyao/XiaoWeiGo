//
//  XWQRCodeViewController.m
//  XiaoWeiGo
//
//  Created by dingxin on 2018/2/10.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWQRCodeViewController.h"
#import "SGQRCodeGenerateManager.h"

@interface XWQRCodeViewController ()
@property (nonatomic, strong) UIImageView *qrCodeImageView;
@end

@implementation XWQRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的二维码";
    [self showBackItem];
}
- (void)layoutSubviews{
    UIView *bgView= [[UIView alloc] init];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    bgView.layer.cornerRadius = 5.0;
    bgView.layer.masksToBounds = YES;
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(40*kScaleH);
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(600*kScaleW);
        make.width.mas_equalTo(640*kScaleH);
    }];
    UIImageView *qrcodeImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 520*kScaleW, 520*kScaleH)];
    //    qrcodeImage.image = [UIImage imageNamed:@"qrcode_img_code"];
    [bgView addSubview:qrcodeImage];
    self.qrCodeImageView = qrcodeImage;
    [qrcodeImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView).offset(60*kScaleH);
        make.centerX.equalTo(bgView);
        make.height.mas_equalTo(280*kScaleW);
        make.width.mas_equalTo(280*kScaleH);
    }];
    UIImage *image = [SGQRCodeGenerateManager SG_generateWithDefaultQRCodeData:@"12344" imageViewWidth:qrcodeImage.frame.size.width+20];
    qrcodeImage.image = image;

    NSArray *array = @[@"保存到相册",@"分享"];
    for (int i = 0; i < 2; i++) {
        
        UIButton *saveBtn = [[UIButton alloc] init];
        saveBtn.tag = i;
        [saveBtn setBackgroundColor:[UIColor whiteColor]];
        [saveBtn setTitle:array[i] forState:UIControlStateNormal];
        [saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [saveBtn.titleLabel setFont:[UIFont rw_regularFontSize:15.0]];
        [bgView addSubview:saveBtn];
        [saveBtn addTarget:self action:@selector(bottomBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            if (i == 0) {
                make.right.equalTo(bgView.mas_centerX).offset(-20*kScaleW);
            }else{
                make.left.equalTo(bgView.mas_centerX).offset(20*kScaleW);
            }
            make.top.equalTo(qrcodeImage.mas_bottom).offset(40*kScaleH);
            make.height.mas_equalTo(60*kScaleH);
            make.width.mas_equalTo(170*kScaleW);
        }];
        if (i == 0) {
            saveBtn.backgroundColor = [UIColor colorWithHex:@"01acf1"];
        }else{
            saveBtn.backgroundColor = [UIColor colorWithHex:@"cd1f20"];
        }
        saveBtn.layer.cornerRadius = 5;
        saveBtn.layer.masksToBounds = YES;
    }
    [self addalertTextView];
}
- (void)addalertTextView{
    UILabel *label0 = [RWFactionUI createLabelWith:CGRectMake(0, 0, 0, 0) text:@"“小微加油”奉化小微企业服务共享平台" textColor:[UIColor textBlackColor] textFont:[UIFont rw_regularFontSize:18.0] textAlignment:0];
    UILabel *label1 = [RWFactionUI createLabelWith:CGRectMake(0, 0, 0, 0) text:@"友情提醒" textColor:[UIColor textBlackColor] textFont:[UIFont rw_regularFontSize:16.0] textAlignment:0];
    NSString *string = @"1.手指长按二维码识别图片 \n2.在别人手机里扫描二维码 \n3.扫码成功后点击右上角的【。。。】，选择“发送给朋友”、“分享到朋友圈”、“收藏”、“分享到手机QQ”、“分享到QQ空间”";
    UILabel *label2 = [RWFactionUI createLabelWith:CGRectMake(0, 0, 0, 0) text:string textColor:[UIColor colorWithHex:@"999999"] textFont:[UIFont rw_regularFontSize:16.0] textAlignment:0];
    label2.numberOfLines = 0;
    [self.view addSubview:label0];
    [self.view addSubview:label1];
    [self.view addSubview:label2];
    [label0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(700*kScaleH);
        make.left.equalTo(self.view).offset(40*kScaleW);
        make.right.equalTo(self.view).offset(-40*kScaleW);
    }];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label0.mas_bottom).offset(20*kScaleH);
        make.left.equalTo(self.view).offset(40*kScaleW);
        make.right.equalTo(self.view).offset(-40*kScaleW);
    }];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label1.mas_bottom).offset(20*kScaleH);
        make.left.equalTo(self.view).offset(40*kScaleW);
        make.right.equalTo(self.view).offset(-40*kScaleW);
    }];
}
- (void)bottomBtnClick:(UIButton *)sender{
    if (sender.tag == 0) {
        UIImageWriteToSavedPhotosAlbum(self.qrCodeImageView.image,self,@selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:),nil);
    }else{
//        NSString *textToShare = @"要分享的文本内容";
        UIImage *imageToShare = self.qrCodeImageView.image;
//        NSURL *urlToShare = [NSURL URLWithString:@"http://www.baidu.com"];
        
        NSArray *activityItems = @[imageToShare];
        UIActivityViewController *activityVC = [[UIActivityViewController alloc]initWithActivityItems:activityItems applicationActivities:nil];
//        activityVC.excludedActivityTypes = @[UIActivityTypeMessage,UIActivityTypeAirDrop,UIActivityTypeAssignToContact,UIActivityTypeMail];
        UIActivityViewControllerCompletionWithItemsHandler myBlock = ^(UIActivityType __nullable activityType, BOOL completed, NSArray * __nullable returnedItems, NSError * __nullable activityError) {
            if (completed){
                [MBProgressHUD alertInfo:@"成功"];
            }
        };
        activityVC.completionWithItemsHandler = myBlock;
        
        [self presentViewController:activityVC animated:YES completion:nil];
        
    }
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

- (void)navLeftItemClick{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
