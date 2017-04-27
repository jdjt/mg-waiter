//
//  DBWaiterInfo+CoreDataProperties.m
//  waiter
//
//  Created by new on 2017/4/26.
//  Copyright © 2017年 liuchao. All rights reserved.
//

#import "DBWaiterInfo+CoreDataProperties.h"
#import <objc/runtime.h>
@implementation DBWaiterInfo (CoreDataProperties)

+ (NSFetchRequest<DBWaiterInfo *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"DBWaiterInfo"];
}




@dynamic attendStatus;
@dynamic attribute;
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
@dynamic nowTime;
@dynamic phone;
@dynamic resetPwdDiv;
@dynamic sex;
@dynamic uploadPerSecond;
@dynamic waiterId;
@dynamic workStatus;
@dynamic workTimeCal;
@dynamic hasTaskList;
@dynamic hasHistoriceStatiscs;





@end
