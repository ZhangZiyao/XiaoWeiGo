//
//  XWAnnounceViewController.m
//  XiaoWeiGo
//
//  Created by dingxin on 2018/4/3.
//  Copyright © 2018年 xwjy. All rights reserved.
//

#import "XWAnnounceViewController.h"

@interface XWAnnounceViewController ()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation XWAnnounceViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self showBackItem];
    self.title = @"通知公告";
    [self getAnnounceListRequest];
}
#pragma mark - 获取公告
- (void)getAnnounceListRequest{
    RequestManager *manager = [[RequestManager alloc] init];
    manager.isShowLoading = NO;
    //    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *urlString = kGetNoticeZ;
    [params setValuesForKeysWithDictionary:@{@"ID":@(self.AID)
                                             }];
    [manager POSTRequestUrlStr:urlString parms:params success:^(id responseData) {
        NSLog(@"公告详情  %@",responseData);
        self.titleLabel.text = [responseData[0] objectForKey:@"nTitle"];
        self.timeLabel.text = [responseData[0] objectForKey:@"issueTime"];
        self.contentLabel.text = [responseData[0] objectForKey:@"nContent"];
        
    } fail:^(NSError *error) {
    }];
}
- (void)layoutSubviews{
    
    
    
    
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.timeLabel];
    [self.view addSubview:self.contentLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.top.equalTo(self.view).offset(15);
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(15);
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.top.equalTo(self.timeLabel.mas_bottom).offset(15);
    }];
    
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont rw_regularFontSize:16.0];
        _titleLabel.numberOfLines = 0;
        _titleLabel.textColor = [UIColor blackColor];
    }
    return _titleLabel;
}
- (UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = [UIFont rw_regularFontSize:14.0];
        _timeLabel.textColor = UIColorFromRGB16(0x666666);
    }
    return _timeLabel;
}
- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.numberOfLines = 0;
        _contentLabel.font = [UIFont rw_regularFontSize:15.0];
        _contentLabel.textColor = [UIColor blackColor];
    }
    return _contentLabel;
}
- (void)navLeftItemClick{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
