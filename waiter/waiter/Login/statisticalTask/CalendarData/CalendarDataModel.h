//
//  CalendarDataParsing.h
//  waiter
//
//  Created by new on 2017/4/14.
//  Copyright © 2017年 liuchao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CalendarDataUtil.h"
typedef void(^CallBackBlock)(NSMutableArray * result);
@interface CalendarDataModel : NSObject
@property (nonatomic, assign) NSInteger year;
@property (nonatomic, assign) NSInteger month;
@property (nonatomic, assign) NSInteger firstday; // 本月第一天是周几
@property (nonatomic, strong ) NSMutableArray * details;//存储日期


+ (void)getCalenderStartDate:(NSDate *)startDate WithEndDate:(NSDate *)endtDate block:(CallBackBlock)block;
@end



@interface CalenderDateSubModel : NSObject

@property (nonatomic, assign) NSInteger day;

@end
