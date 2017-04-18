//
//  DBLogInInfo+CoreDataProperties.m
//  waiter
//
//  Created by new on 2017/4/18.
//  Copyright © 2017年 liuchao. All rights reserved.
//

#import "DBLogInInfo+CoreDataProperties.h"

@implementation DBLogInInfo (CoreDataProperties)

+ (NSFetchRequest<DBLogInInfo *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"DBLogInInfo"];
}

@dynamic waiterId;
@dynamic uploadPerSecond;
@dynamic nowTime;
@dynamic waiterInfo;

@end
