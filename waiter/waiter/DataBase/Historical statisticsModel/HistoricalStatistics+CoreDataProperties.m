//
//  HistoricalStatistics+CoreDataProperties.m
//  waiter
//
//  Created by new on 2017/4/26.
//  Copyright © 2017年 liuchao. All rights reserved.
//

#import "HistoricalStatistics+CoreDataProperties.h"

@implementation HistoricalStatistics (CoreDataProperties)

+ (NSFetchRequest<HistoricalStatistics *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"HistoricalStatistics"];
}

@dynamic pageNo;
@dynamic count;
@dynamic pushTaskCount;
@dynamic acceptTaskCount;
@dynamic hasHisStaTaskList;
@dynamic belongHisWaiterInfo;
@dynamic allCount;
@dynamic selfCount;
@dynamic sysCount;
@end
