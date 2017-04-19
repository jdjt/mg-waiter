//
//  DBWaiterInfo+CoreDataProperties.m
//  waiter
//
//  Created by new on 2017/4/19.
//  Copyright © 2017年 liuchao. All rights reserved.
//

#import "DBWaiterInfo+CoreDataProperties.h"

@implementation DBWaiterInfo (CoreDataProperties)

+ (NSFetchRequest<DBWaiterInfo *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"DBWaiterInfo"];
}

@dynamic attendStatus;
@dynamic depId;
@dynamic depName;
@dynamic deviceId;
@dynamic deviceToken;
@dynamic deviceType;
@dynamic empNo;
@dynamic hotelCode;
@dynamic hotelName;
@dynamic idNo;
@dynamic imAccount;
@dynamic name;
@dynamic phone;
@dynamic resetPwdDiv;
@dynamic sex;
@dynamic workStatus;
@dynamic workTimeCal;
@dynamic attribute;
@dynamic nowTime;
@dynamic uploadPerSecond;
@dynamic waiterId;
@dynamic taskList;

@end
