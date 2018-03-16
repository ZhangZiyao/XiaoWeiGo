//
//  XWScanViewController.m
//  XiaoWeiGo
//
//  Created by dingxin on 2018/3/8.
//  Copyright © 2018年 xwjy. All rights reserved.
//
#define TOP 260*kScaleH
#define LEFT (ScreenWidth-520*kScaleW)/2
#define SMWIDTH 520*kScaleW
#define SMHEIGHT 465*kScaleH
#define kScanRect CGRectMake(LEFT, TOP, 520*kScaleW, 465*kScaleH)

#import "XWScanViewController.h"
#import "PrivateManager.h"
#import "RWSoundManager.h"
#import "XWRegisterSecStepController.h"

@interface XWScanViewController ()<AVCaptureMetadataOutputObjectsDelegate>
{
    int num;
    BOOL upOrdown;
    
    CAShapeLayer *cropLayer;
    PrivateManager *cameraM;
}

@property (nonatomic, strong) UIImageView * line;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation XWScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    [self showBackItem];
    
    cameraM = [PrivateManager new];
    if (![cameraM checkCamera]) {
        UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"" message:@"请在iPhone的“设置”-“隐私”-“相机”功能中，找到“奉化小微加油”打开相机访问权限" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return;
    }
    [self setupCamera];
}
#pragma mark - delegeta AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    NSString *stringValue;
    if ([metadataObjects count] >0)
    {
//        WS(weakSelf);
        [RWSoundManager palySoundName:@"saomiao.wav"];
        
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
        NSLog(@"扫描结果：%@",stringValue);
        NSLog(@"扫描结果 metadataObjects：%@",metadataObjects);
        /**
         统一社会信用代码：91330281677691616Q,企业注册号:330203000039277;企业名称:宁波恒拓物联网有限公司;登记机关:余姚市市场监督管理局;登记时间:2017-03-02;经营范围:物联网技术的软硬件设计、开发，软件外包，智能化电子、电器设备的设计开发、销售、维护。;详询信用公示系统:http://gsxt.zjaic.gov.cn
         */
        if ([stringValue containsString:@"统一社会信用代码"]) {
            //停止扫描
            [self stopRunning];
            
            NSArray *array = [stringValue componentsSeparatedByString:@";"];
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            for (int i = 0; i < array.count; i++) {
                NSString *string = array[i];
                if ([string containsString:@"统一社会信用代码"]) {
                    [dict setObject:[[string componentsSeparatedByString:@","][0] componentsSeparatedByString:@"："][1] forKey:@"code"];
                    [dict setObject:[[string componentsSeparatedByString:@","][1] componentsSeparatedByString:@":"][1] forKey:@"rcode"];
                }
                if ([string containsString:@"企业名称"]) {
                    [dict setObject:[string componentsSeparatedByString:@":"][1] forKey:@"name"];
                }
                if ([string containsString:@"登记机关"]) {
                    [dict setObject:[string componentsSeparatedByString:@":"][1] forKey:@"rcompany"];
                }
                if ([string containsString:@"登记时间"]) {
                    [dict setObject:[string componentsSeparatedByString:@":"][1] forKey:@"rtime"];
                }
                if ([string containsString:@"经营范围"]) {
                    [dict setObject:[string componentsSeparatedByString:@":"][1] forKey:@"fanwei"];
                }
                if ([string containsString:@"信用公示"]) {
                    [dict setObject:[string substringFromIndex:8] forKey:@"xinyong"];
                }
            }
//            SendNotify(@"scanSuccess", dict);
//            [self.navigationController popViewControllerAnimated:YES];
            
            XWRegisterSecStepController *registerVc = [[XWRegisterSecStepController alloc] init];
            registerVc.dict = dict;
            registerVc.type = self.type;
            [self.navigationController pushViewController:registerVc animated:YES];
            
        }else{
            [MBProgressHUD alertInfo:@"扫描信息有误"];
        }
        
    } else {
        NSLog(@"无扫描信息");
        return;
    }
    
}
- (void)startRunning{
    
    if (_session != nil) {
        [_session startRunning];
        [self.timer setFireDate:[NSDate distantPast]];
    }
}
- (void)stopRunning{
    [_session stopRunning];
    if ([self.timer isValid]) {
        [self.timer setFireDate:[NSDate distantFuture]];
    }
}

- (void)layoutSubviews{
    [self setCropRect:kScanRect];
    
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:kScanRect];
    imageView.image = [UIImage imageNamed:@"sm"];
    [self.view addSubview:imageView];
    
    upOrdown = NO;
    num =0;
    _line = [[UIImageView alloc] initWithFrame:CGRectMake(LEFT, TOP+10, SMWIDTH, 20*kScaleH)];
    _line.image = [UIImage imageNamed:@"sm-t"];
    [self.view addSubview:_line];
    
    UILabel *textLabel = [[UILabel alloc] init];
    textLabel.text = @"请将二维码放入扫描框";
    textLabel.textColor = [UIColor whiteColor];
    textLabel.font = [UIFont rw_regularFontSize:16];
    [self.view addSubview:textLabel];
    [textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView.mas_bottom).offset(50*kScaleH);
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(15);
    }];
    
}

-(void)animation1
{
    if (upOrdown == NO) {
        num ++;
        _line.frame = CGRectMake(LEFT, TOP+10+2*num, SMWIDTH, 20*kScaleH);
        if (2*num == 200) {
            upOrdown = YES;
        }
    }
    else {
        num --;
        _line.frame = CGRectMake(LEFT, TOP+10+2*num, SMWIDTH, 20*kScaleH);
        if (num == 0) {
            upOrdown = NO;
        }
    }
}

- (void)setCropRect:(CGRect)cropRect{
    cropLayer = [[CAShapeLayer alloc] init];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, nil, cropRect);
    CGPathAddRect(path, nil, self.view.bounds);
    
    [cropLayer setFillRule:kCAFillRuleEvenOdd];
    [cropLayer setPath:path];
    [cropLayer setFillColor:[UIColor blackColor].CGColor];
    [cropLayer setOpacity:0.6];
    
    [cropLayer setNeedsDisplay];
    
    [self.view.layer addSublayer:cropLayer];
}

- (void)setupCamera
{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device==nil) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"设备没有摄像头" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    // Device
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // Input
    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    
    // Output
    _output = [[AVCaptureMetadataOutput alloc]init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    //设置扫描区域
    CGFloat top = TOP/ScreenHeight;
    CGFloat left = LEFT/ScreenWidth;
    CGFloat width = 220/ScreenWidth;
    CGFloat height = 220/ScreenHeight;
    ///top 与 left 互换  width 与 height 互换
    [_output setRectOfInterest:CGRectMake(top,left, height, width)];
    
    // Session
    _session = [[AVCaptureSession alloc]init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([_session canAddInput:self.input])
    {
        [_session addInput:self.input];
    }
    
    if ([_session canAddOutput:self.output])
    {
        [_session addOutput:self.output];
    }
    
    
    // 条码类型 AVMetadataObjectTypeQRCode
    [_output setMetadataObjectTypes:[NSArray arrayWithObjects:AVMetadataObjectTypeQRCode, nil]];
    
    // Preview
    _preview =[AVCaptureVideoPreviewLayer layerWithSession:_session];
    _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _preview.frame =self.view.layer.bounds;
    [self.view.layer insertSublayer:_preview atIndex:0];
    
    // Start
    //    [_session startRunning];
    
    [self startRunning];
}
- (NSTimer *)timer{
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(animation1) userInfo:nil repeats:YES];
    }
    return _timer;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([cameraM checkCamera]) {
        [self startRunning];
    }
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.timer invalidate];
    self.timer = nil;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self stopRunning];
}

- (void)navLeftItemClick{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
