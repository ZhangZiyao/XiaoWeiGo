//
//  NSString+Date.h
//  ucupay
//
//  Created by dingxin on 2017/9/13.
//  Copyright © 2017年 dingxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Date)
+ (NSString *)ymdhDateToDateString:(NSDate *)date;

+ (NSString *)ymdDateToDateString:(NSDate *)date;

+ (NSString *)nowTimeString;

+ (NSString *)nowDateString;

+ (NSString *)ymdNowDateString;

+ (NSString *)ymdYesterdayDateString;

+ (NSString *)getWeekDate;

+ (NSString *)getTimestamp;

+ (NSString *)hmsOfDate:(NSDate *)toDate hour:(int)hour minute:(int)minute second:(int)second;

+ (NSArray *)getWeekDays;

+ (NSArray *)getDaysWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate;

+ (BOOL)isOutOf7DateTime:(NSString *)startDate andEndDate:(NSString *)endDate;

+ (BOOL)isOutOf31DateTime:(NSString *)startDate andEndDate:(NSString *)endDate;

+ (BOOL)ifOutOfDateTime:(NSString *)startDate andEndDate:(NSString *)endDate;

+ (NSString *)ymdformatterToYmdhmsFormatter:(NSString *)dateString;

+ (NSString *)ymdhmsformatterToYmdFormatter:(NSString *)dateString;

+ (NSDate *)ymdhdateStringToDate:(NSString *)dateString;
@end
