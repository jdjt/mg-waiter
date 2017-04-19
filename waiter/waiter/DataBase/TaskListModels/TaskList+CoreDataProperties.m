//
//  TaskList+CoreDataProperties.m
//  waiter
//
//  Created by new on 2017/4/19.
//  Copyright © 2017年 liuchao. All rights reserved.
//

#import "TaskList+CoreDataProperties.h"

@implementation TaskList (CoreDataProperties)

+ (NSFetchRequest<TaskList *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"TaskList"];
}

@dynamic acceptTime;
@dynamic areaCode;
@dynamic areaName;
@dynamic cImAccount;
@dynamic customerId;
@dynamic finishEndTime;
@dynamic finishTime;
@dynamic floorNo;
@dynamic hotelCode;
@dynamic mapNo;
@dynamic nowDate;
@dynamic posionX;
@dynamic positionY;
@dynamic postionZ;
@dynamic taskContent;
@dynamic taskStatus;
@dynamic waiterEndTime;
@dynamic waiterId;
@dynamic waiteTime;
@dynamic wImAccount;
@dynamic count;
@dynamic pageNo;
@dynamic causeCode;
@dynamic causeDesc;
@dynamic scoreMod;
@dynamic scoreTime;
@dynamic scoreVal;
@dynamic taskTypeCustom;
@dynamic taskCode;
@dynamic isAnOpen;

@end
