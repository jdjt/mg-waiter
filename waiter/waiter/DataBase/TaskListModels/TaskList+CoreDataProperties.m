//
//  TaskList+CoreDataProperties.m
//  waiter
//
//  Created by chao liu on 2017/5/12.
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
@dynamic confirmTime;
@dynamic customerDeviceId;
@dynamic customerId;
@dynamic customerName;
@dynamic customerRoomNum;
@dynamic finishEndTime;
@dynamic finishTime;
@dynamic floorNo;
@dynamic hotelCode;
@dynamic isAnOpen;
@dynamic mapNo;
@dynamic nowDate;
@dynamic positionX;
@dynamic positionY;
@dynamic positionZ;
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
@dynamic belongHistoricalStatics;
@dynamic belongWaiterInfor;
@dynamic haschatmessage;

@end
