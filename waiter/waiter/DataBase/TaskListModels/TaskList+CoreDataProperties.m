//
//  TaskList+CoreDataProperties.m
//  waiter
//
//  Created by new on 2017/4/24.
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
@dynamic cImAccount;
@dynamic count;
@dynamic customerId;
@dynamic finishEndTime;
@dynamic finishTime;
@dynamic floorNo;
@dynamic hotelCode;
@dynamic isAnOpen;
@dynamic mapNo;
@dynamic nowDate;
@dynamic pageNo;
@dynamic posionX;
@dynamic positionY;
@dynamic postionZ;
@dynamic scoreMod;
@dynamic scoreTime;
@dynamic scoreVal;
@dynamic taskCode;
@dynamic taskContent;
@dynamic taskStatus;
@dynamic taskTypeCustom;
@dynamic waiterEndTime;
@dynamic waiterId;
@dynamic waiteTime;
@dynamic wImAccount;
@dynamic causeTime;
@dynamic causePoint;
@dynamic customerName;
@dynamic customerDeviceId;
@dynamic waiterName;
@dynamic waiterDeviceId;
@dynamic produceTime;
@dynamic belongWaiterInfor;
@dynamic haschatmessage;

@end
