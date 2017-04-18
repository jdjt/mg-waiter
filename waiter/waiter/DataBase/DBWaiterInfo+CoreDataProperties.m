//
//  DBWaiterInfo+CoreDataProperties.m
//  waiter
//
//  Created by new on 2017/4/18.
//  Copyright © 2017年 liuchao. All rights reserved.
//

#import "DBWaiterInfo+CoreDataProperties.h"

@implementation DBWaiterInfo (CoreDataProperties)

+ (NSFetchRequest<DBWaiterInfo *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"DBWaiterInfo"];
}

@dynamic hotelCode;
@dynamic hotelName;
@dynamic empNo;
@dynamic name;
@dynamic sex;
@dynamic phone;
@dynamic depId;
@dynamic depName;
@dynamic idNo;
@dynamic resetPwdDiv;
@dynamic imAccount;
@dynamic deviceId;
@dynamic deviceToken;
@dynamic deviceType;
@dynamic workStatus;
@dynamic attendStatus;
@dynamic workTimeCal;

@end
