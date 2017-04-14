//
//  CalendarDataUtil.h
//  waiter
//
//  Created by new on 2017/4/14.
//  Copyright © 2017年 liuchao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalendarDataUtil : NSObject
/** 获取天 */
+ (NSInteger)day:(NSDate *)date;

/** 获取月*/
+ (NSInteger)month:(NSDate *)date;

/** 获取年*/
+ (NSInteger)year:(NSDate *)date;

/** 获取某个月的第一天是周几*/
+ (NSInteger)firstWeekdayInThisMonth:(NSDate *)date;

/** 获取某个月的所有总天数*/
+ (NSInteger)totaldaysInMonth:(NSDate *)date;

/** 获取某个月的上个月*/
+ (NSDate *)lastMonth:(NSDate *)date;

/** 获取某个月的下个月*/
+ (NSDate*)nextMonth:(NSDate *)date;

/** String 转 Date */
+ (NSDate *)dateFromString:(NSString *)dateString;

/** Date 转 String*/
+ (NSString *)stringFromDate:(NSDate *)date;

@end
