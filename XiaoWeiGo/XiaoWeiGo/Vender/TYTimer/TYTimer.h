//
//  TYTimer.h
//  TeeYaProject
//
//  Created by fancy on 2016/11/21.
//  Copyright © 2016年 kangzhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  TYTimerProtocol <NSObject>

- (void)currenDownTime:(NSInteger)remainTime;

@end

@interface TYTimer : UIView

@property (nonatomic ,weak) id <TYTimerProtocol> delegate;

- (instancetype)initWithIdentifier:(NSString *)identifier totalTime:(NSInteger)time;

- (void)invalidTime;

@end

@interface TYTimerManager : NSObject

+ (instancetype)manager;

@property (nonatomic , strong) NSMutableDictionary  *timerManager;

@end
