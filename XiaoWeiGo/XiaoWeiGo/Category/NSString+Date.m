//
//  NSString+Date.m
//  ucupay
//
//  Created by dingxin on 2017/9/13.
//  Copyright © 2017年 dingxin. All rights reserved.
//

#import "NSString+Date.h"

@implementation NSString (Date)

+ (NSString *)ymdhDateToDateString:(NSDate *)date{
    NSDateFormatter * formatter = [[NSDateFormatter alloc ] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *dateString =  [formatter stringFromDate:date];
    //    NSString *timeLocal = [[NSString alloc] initWithFormat:@"%@", date];
    //    NSLog(@"%@", timeLocal);
    return dateString;
}
+ (NSString *)ymdDateToDateString:(NSDate *)date{
    NSDateFormatter * formatter = [[NSDateFormatter alloc ] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString =  [formatter stringFromDate:date];
    //    NSString *timeLocal = [[NSString alloc] initWithFormat:@"%@", date];
    //    NSLog(@"%@", timeLocal);
    return dateString;
}
+ (NSString *)ymdformatterToYmdhmsFormatter:(NSString *)dateString{
    NSDateFormatter * formatter0 = [[NSDateFormatter alloc ] init];
    [formatter0 setDateFormat:@"YYYY-MM-dd"];
    NSDate *date = [formatter0 dateFromString:dateString];
    NSDateFormatter * formatter1 = [[NSDateFormatter alloc ] init];
    [formatter1 setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString *string = [formatter1 stringFromDate:date];
    return string;
}
+ (NSString *)ymdhmsformatterToYmdFormatter:(NSString *)dateString{
    NSDateFormatter * formatter0 = [[NSDateFormatter alloc ] init];
    [formatter0 setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *date = [formatter0 dateFromString:dateString];
    NSDateFormatter * formatter1 = [[NSDateFormatter alloc ] init];
    [formatter1 setDateFormat:@"YYYY-MM-dd"];
    NSString *string = [formatter1 stringFromDate:date];
    return string;
}
+ (NSString *)nowTimeString{
    NSDateFormatter * formatter = [[NSDateFormatter alloc ] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString *date =  [formatter stringFromDate:[NSDate date]];
    NSString *timeLocal = [[NSString alloc] initWithFormat:@"%@", date];
    NSLog(@"%@", timeLocal);
    return timeLocal;
}
+ (NSString *)nowDateString{
    NSDateFormatter * formatter = [[NSDateFormatter alloc ] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    NSString *date =  [formatter stringFromDate:[NSDate date]];
    NSString *timeLocal = [[NSString alloc] initWithFormat:@"%@", date];
    NSLog(@"%@", timeLocal);
    return timeLocal;
}
+ (NSString *)formatterDateString:(NSDate *)date{
    NSDateFormatter * formatter = [[NSDateFormatter alloc ] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSString *dateString =  [formatter stringFromDate:date];
    NSString *timeLocal = [[NSString alloc] initWithFormat:@"%@", dateString];
    NSLog(@"%@", timeLocal);
    return timeLocal;
}
+ (NSString *)getWeekDate{
    NSTimeInterval secondsPerDay = 24 * 60 * 60 * 6;
    NSDate * today = [NSDate date];
    //    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    //    [myDateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [NSString formatterDateString:[today dateByAddingTimeInterval:-secondsPerDay]];
    NSLog(@"dateString%@:",dateString);
    
    return dateString;
}
+ (NSString *)ymdNowDateString{
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSString *date =  [formatter stringFromDate:[NSDate date]];
    NSString *timeLocal = [[NSString alloc] initWithFormat:@"%@", date];
    NSLog(@"%@", timeLocal);
    return timeLocal;
}
+ (NSString *)ymdYesterdayDateString{
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSString *date =  [formatter stringFromDate:[NSDate dateWithTimeIntervalSinceNow:-24*3600]];
    NSString *timeLocal = [[NSString alloc] initWithFormat:@"%@", date];
    NSLog(@"%@", timeLocal);
    return timeLocal;
}
+ (NSString *)getTimestamp{
    NSDate *date = [NSDate date];
    NSTimeInterval currentTime = [date timeIntervalSince1970];
    return [NSString stringWithFormat:@"%.0f" , currentTime];
}
+ (NSString *)hmsOfDate:(NSDate *)toDate hour:(int)hour minute:(int)minute second:(int)second
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSUIntegerMax fromDate:toDate];
    components.hour = hour;
    components.minute = minute;
    components.second = second;
    
    // components.nanosecond = 0 not available in iOS
    NSTimeInterval ts = (double)(int)[[calendar dateFromComponents:components] timeIntervalSince1970];
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:ts];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:date];
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc ] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString *dateString =  [formatter stringFromDate:localeDate];
    NSString *timeLocal = [[NSString alloc] initWithFormat:@"%@", dateString];
    
    return timeLocal;
}
+ (NSArray *)getWeekDays{
    NSTimeInterval secondsPerDay = -24 * 60 * 60;
    NSDate * today = [NSDate dateWithTimeIntervalSinceNow:secondsPerDay];
    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    [myDateFormatter setDateFormat:@"dd"];
    
    NSMutableArray *dateArr = [NSMutableArray array];
    for (int i = 0; i < 7; i ++) {
        NSString *dateString = [myDateFormatter stringFromDate:[today dateByAddingTimeInterval:i * secondsPerDay]];
        NSLog(@"dateString%@:",dateString);
        [dateArr addObject:dateString];
    }
    return dateArr;
}
+ (NSArray *)getDaysWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate{
    
    NSMutableArray *dates = [NSMutableArray array];
    long long nowTime = [startDate timeIntervalSince1970], //开始时间
    endTime = [endDate timeIntervalSince1970],//结束时间
    dayTime = 24*60*60,
    time = nowTime - nowTime%dayTime;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd"];
    
    while (time <= endTime) {
        NSString *showOldDate = [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:time]];
        [dates addObject:showOldDate];
        time += dayTime;
    }
    
    return dates;
}
+ (BOOL)isOutOf7DateTime:(NSString *)startDate andEndDate:(NSString *)endDate {
    
    // 1.确定时间
    NSString *time1 = startDate;
    NSString *time2 = endDate;
    // 2.将时间转换为date
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm";
    NSDate *date1 = [formatter dateFromString:time1];
    NSDate *date2 = [formatter dateFromString:time2];
    // 3.创建日历
    //    NSCalendar *calendar = [NSCalendar currentCalendar];
    //    NSCalendarUnit type = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    //    // 4.利用日历对象比较两个时间的差值
    //    NSDateComponents *cmps = [calendar components:type fromDate:date1 toDate:date2 options:0];
    //    // 5.输出结果
    //    NSLog(@"两个时间相差%ld年%ld月%ld日%ld小时%ld分钟%ld秒", cmps.year, cmps.month, cmps.day, cmps.hour, cmps.minute, cmps.second);
    
    
    NSTimeInterval time = [date2 timeIntervalSinceDate:date1];
    NSLog(@"两个日期相差的秒数 %f",time);
    
    //根据相差的秒数，看是否大于7天
    if (time > 7 * 24 * 3600) {
        return YES;
    }
    return NO;
}
+ (BOOL)isOutOf31DateTime:(NSString *)startDate andEndDate:(NSString *)endDate {
    
    // 1.确定时间
    NSString *time1 = startDate;
    NSString *time2 = endDate;
    // 2.将时间转换为date
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *date1 = [formatter dateFromString:time1];
    NSDate *date2 = [formatter dateFromString:time2];
    // 3.创建日历
    //    NSCalendar *calendar = [NSCalendar currentCalendar];
    //    NSCalendarUnit type = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    //    // 4.利用日历对象比较两个时间的差值
    //    NSDateComponents *cmps = [calendar components:type fromDate:date1 toDate:date2 options:0];
    //    // 5.输出结果
    //    NSLog(@"两个时间相差%ld年%ld月%ld日%ld小时%ld分钟%ld秒", cmps.year, cmps.month, cmps.day, cmps.hour, cmps.minute, cmps.second);
    
    
    NSTimeInterval time = [date2 timeIntervalSinceDate:date1];
    NSLog(@"两个日期相差的秒数 %f",time);
    
    //根据相差的秒数，看是否大于7天
    if (time > 31 * 24 * 3600) {
        return YES;
    }
    return NO;
}
+ (BOOL)ifOutOfDateTime:(NSString *)startDate andEndDate:(NSString *)endDate {
    // 1.确定时间
    NSString *time1 = startDate;
    NSString *time2 = endDate;
    // 2.将时间转换为date
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm";
    NSDate *date1 = [formatter dateFromString:time1];
    NSDate *date2 = [formatter dateFromString:time2];
    // 3.创建日历
    //    NSCalendar *calendar = [NSCalendar currentCalendar];
    //    NSCalendarUnit type = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    //    // 4.利用日历对象比较两个时间的差值
    //    NSDateComponents *cmps = [calendar components:type fromDate:date1 toDate:date2 options:0];
    //    // 5.输出结果
    //    NSLog(@"两个时间相差%ld年%ld月%ld日%ld小时%ld分钟%ld秒", cmps.year, cmps.month, cmps.day, cmps.hour, cmps.minute, cmps.second);
    
    
    NSTimeInterval time = [date2 timeIntervalSinceDate:date1];
    NSLog(@"两个日期相差的秒数 %f",time);
    
    //相差的秒数，看是否大于0
    if (time >= 0) {
        return YES;
    }
    return NO;
}
+ (NSDate *)ymdhdateStringToDate:(NSString *)dateString{
    NSDateFormatter * formatter = [[NSDateFormatter alloc ] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *date =  [formatter dateFromString:dateString];
    //    NSString *timeLocal = [[NSString alloc] initWithFormat:@"%@", date];
    //    NSLog(@"%@", timeLocal);
    return date;
}
@end
