//
//  TYTimer.m
//  TeeYaProject
//
//  Created by fancy on 2016/11/21.
//  Copyright © 2016年 kangzhang. All rights reserved.
//

#import "TYTimer.h"

@interface TYTimer ()
{
    NSString *_identifier;
    NSInteger _totalTime;
    NSTimer *_timer;
}
@end
@implementation TYTimer


- (void)setDelegate:(id<TYTimerProtocol>)delegate
{
    _delegate = delegate;
}

- (instancetype)initWithIdentifier:(NSString *)identifier totalTime:(NSInteger)time
{
    if (self = [super init]) {
        //
        _identifier = identifier;
        _totalTime = time;
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(time:) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
        
    
    }
    return self;
}

- (void)time:(NSTimer *)time
{
    _totalTime--;
    if (_delegate && [_delegate respondsToSelector:@selector(currenDownTime:)]) {
        [_delegate currenDownTime:_totalTime];
    }
    if (_totalTime == 0) {
        [self invalidTime];
    }
    /*
    NSArray * array = [[[TYTimerManager manager] timerManager]objectForKey:_identifier];
    NSInteger totalTime = [array[0] integerValue] - 1;
    if (_delegate && [_delegate respondsToSelector:@selector(currenDownTime:)]) {
        [_delegate currenDownTime:totalTime];
    }
    if (totalTime == 0) {
        [[[TYTimerManager manager] timerManager] removeObjectForKey:_identifier];
        return ;
    }
    [[[TYTimerManager manager] timerManager] setObject:@[@(totalTime)] forKey:_identifier];
     */
    
}

- (void)invalidTime
{
    [_timer invalidate];
    _timer = nil;
}

- (void)dealloc
{
    NSLog(@"dealloc === [%@ class]",[self class]);
}

@end

@interface TYTimerManager ()


@end

@implementation TYTimerManager

+ (instancetype)manager
{
    static TYTimerManager *_manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[TYTimerManager alloc] init];
    });
    return _manager;
}

@end
