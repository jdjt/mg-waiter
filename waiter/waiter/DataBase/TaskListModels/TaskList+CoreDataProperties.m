//
//  TaskList+CoreDataProperties.m
//  waiter
//
//  Created by new on 2017/4/18.
//  Copyright © 2017年 liuchao. All rights reserved.
//

#import "TaskList+CoreDataProperties.h"

@implementation TaskList (CoreDataProperties)

+ (NSFetchRequest<TaskList *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"TaskList"];
}

@dynamic taskContent;
@dynamic taskStatus;
@dynamic hotelCode;
@dynamic areaCode;
@dynamic areaName;
@dynamic floorNo;
@dynamic mapNo;
@dynamic posionX;
@dynamic positionY;
@dynamic postionZ;
@dynamic customerId;
@dynamic cImAccount;
@dynamic waiterId;
@dynamic wImAccount;
@dynamic nowDate;
@dynamic waiteTime;
@dynamic waiterEndTime;
@dynamic acceptTime;
@dynamic finishTime;
@dynamic finishEndTime;
@dynamic cancelDetail;
@dynamic scoreDetail;

@end
