//
//  CalendarDataParsing.m
//  waiter
//
//  Created by new on 2017/4/14.
//  Copyright © 2017年 liuchao. All rights reserved.
//

#import "CalendarDataModel.h"

@implementation CalendarDataModel
+ (void)getCalenderStartDate:(NSDate *)startDate WithEndDate:(NSDate *)endtDate block:(CallBackBlock)block{
    NSMutableArray * array = [NSMutableArray array];

    
    NSInteger firstday = [CalendarDataUtil firstWeekdayInThisMonth:startDate]; // 本月的第一天是周几
    NSInteger totalDay = [CalendarDataUtil totaldaysInMonth:startDate];  //月份的所有天数
    
    /*起始年月*/
    NSInteger startYear = [CalendarDataUtil year:startDate];
    NSInteger startMonth = [CalendarDataUtil month:startDate];
    
    /*结束年月*/
    NSInteger endYear = [CalendarDataUtil year:endtDate];
    NSInteger endMonth = [CalendarDataUtil month:endtDate];
    NSInteger endDay = [CalendarDataUtil day:endtDate];
    
    NSInteger lastMonth = 12;//12个月，如果是本年则只显示到本月
    for (NSInteger y = startYear; y <= endYear; y ++) {
        //循环到本年，月份只到当前月
        if (y == endYear) {
            lastMonth = endMonth;
        }
        for (NSInteger i = startMonth; i <= lastMonth; i++) {
            CalendarDataModel * model = [[CalendarDataModel alloc] init];
            model.year = y;
            model.month = i;
            model.firstday = firstday;
            //循环到本年本月，天数只到当前天数
            if (y == endYear && i == lastMonth) {
                totalDay = endDay;
            }
            
            for (NSInteger j = 1; j < totalDay  +1; j ++) {
                CalenderDateSubModel * subModel = [[CalenderDateSubModel alloc] init];
                subModel.day = j;
                [model.details addObject:subModel];
            }
             
            totalDay = [CalendarDataUtil totaldaysInMonth:[CalendarDataUtil nextMonth:startDate]];
            startDate = [CalendarDataUtil nextMonth:startDate];
            firstday = [CalendarDataUtil firstWeekdayInThisMonth:startDate];
            [array addObject:model];
        }
        startMonth = 1;
    }
    
    block(array);
}

- (NSMutableArray *)details {
    if (!_details) {
        _details = [NSMutableArray array];
    }
    return _details;
}

@end


@implementation CalenderDateSubModel

@end
