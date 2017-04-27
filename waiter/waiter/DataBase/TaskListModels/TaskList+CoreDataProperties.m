//
//  TaskList+CoreDataProperties.m
//  waiter
//
//  Created by new on 2017/4/26.
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
@dynamic callContentHeight;
@dynamic causeCode;
@dynamic causeDesc;
@dynamic causePoint;
@dynamic causeTime;
@dynamic cImAccount;
@dynamic comeFrom;
@dynamic customerDeviceId;
@dynamic customerId;
@dynamic customerName;
@dynamic finishEndTime;
@dynamic finishTime;
@dynamic floorNo;
@dynamic hotelCode;
@dynamic isAnOpen;
@dynamic mapNo;
@dynamic nowDate;
@dynamic posionX;
@dynamic positionY;
@dynamic postionZ;
@dynamic produceTime;
@dynamic scoreMod;
@dynamic scoreTime;
@dynamic scoreVal;
@dynamic taskCode;
@dynamic taskContent;
@dynamic taskStatus;
@dynamic taskTypeCustom;
@dynamic waiterDeviceId;
@dynamic waiterEndTime;
@dynamic waiterId;
@dynamic waiterName;
@dynamic waiteTime;
@dynamic wImAccount;
@dynamic belongWaiterInfor;
@dynamic haschatmessage;
@dynamic belongHistoricalStatics;

@end
