//
//  DBDeviceInfo+CoreDataProperties.m
//  waiter
//
//  Created by new on 2017/4/18.
//  Copyright © 2017年 liuchao. All rights reserved.
//

#import "DBDeviceInfo+CoreDataProperties.h"

@implementation DBDeviceInfo (CoreDataProperties)

+ (NSFetchRequest<DBDeviceInfo *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"DBDeviceInfo"];
}

@dynamic deviceId;
@dynamic deviceToken;

@end
