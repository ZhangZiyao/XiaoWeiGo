//
//  XBTextLoopView.m
//  文字轮播
//
//  Created by 周旭斌 on 2017/4/9.
//  Copyright © 2017年 周旭斌. All rights reserved.
//

#import "XBTextLoopView.h"

@interface XBTextLoopView () <UITableViewDataSource, UITableViewDelegate>

//@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, weak) UITableView *tableView;
//@property (nonatomic, assign) NSTimeInterval interval;
@property (nonatomic, strong) NSTimer *myTimer;
@property (nonatomic, assign) NSInteger currentRowIndex;
@property (nonatomic, copy) selectTextBlock selectBlock;
@property (nonatomic, readwrite) BOOL isWalking;

@end

@implementation XBTextLoopView

#pragma mark - 初始化方法
+ (instancetype)textLoopViewWith:(NSArray *)dataSource loopInterval:(NSTimeInterval)timeInterval initWithFrame:(CGRect)frame selectBBlock:(selectTextBlock)selectBBlock {
    XBTextLoopView *loopView = [[XBTextLoopView alloc] initWithFrame:frame];
    loopView.dataSource = dataSource;
    loopView.selectBlock = selectBBlock;
    loopView.isWalking = NO;
    loopView.interval = timeInterval ? timeInterval : 1.0;
    return loopView;
}

#pragma mark - tableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = _dataSource[indexPath.row];
    cell.textLabel.font = [UIFont rw_regularFontSize:15.0];
    cell.textLabel.textColor = UIColorFromRGB16(0x666666);
    [cell.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cell.contentView).offset(100);
        make.centerY.equalTo(cell.contentView);
        make.right.equalTo(cell.contentView).offset(5);
    }];
    return cell;
}

#pragma mark - tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_selectBlock) {
        self.selectBlock(_dataSource[indexPath.row], indexPath.row);
    }
}

#pragma mark - scrollViewDelegate
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    // 以无动画的形式跳到第1组的第0行
    if (_currentRowIndex == _dataSource.count) {
        _currentRowIndex = 0;
        [_tableView setContentOffset:CGPointZero];
    }
}

#pragma mark - priviate method
- (void)setInterval:(NSTimeInterval)interval {
    _interval = interval;
    
    // 定时器
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(timer) userInfo:nil repeats:YES];
    _myTimer = timer;
    self.isWalking = YES;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        // tableView
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _tableView = tableView;
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.rowHeight = frame.size.height;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:tableView];
    }
    return self;
}

- (void)timer {
    self.currentRowIndex++;
    NSLog(@"滚动 %ld", _currentRowIndex);
    [self.tableView setContentOffset:CGPointMake(0, _currentRowIndex * _tableView.rowHeight) animated:YES];
}
- (void)pause{
//    if (self.isWalking == NO) {
//        return;
//    }
    
    [self.myTimer setFireDate:[NSDate distantFuture]];
    self.isWalking = NO;
}
- (void)walk{
//    if (self.isWalking == YES) {
//        return;
//    }
    [self.myTimer setFireDate:[NSDate distantPast]];
    self.isWalking = NO;
}
- (void)dealloc{
    [self.myTimer invalidate];
    self.myTimer = nil;
}

@end