//
//  DBStatistical+CoreDataProperties.m
//  waiter
//
//  Created by new on 2017/4/13.
//  Copyright © 2017年 liuchao. All rights reserved.
//

#import "DBStatistical+CoreDataProperties.h"

@implementation DBStatistical (CoreDataProperties)

+ (NSFetchRequest<DBStatistical *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"DBStatistical"];
}


@end
