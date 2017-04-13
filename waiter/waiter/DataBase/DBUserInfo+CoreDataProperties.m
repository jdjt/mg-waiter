//
//  DBUserInfo+CoreDataProperties.m
//  waiter
//
//  Created by new on 2017/4/13.
//  Copyright © 2017年 liuchao. All rights reserved.
//

#import "DBUserInfo+CoreDataProperties.h"

@implementation DBUserInfo (CoreDataProperties)

+ (NSFetchRequest<DBUserInfo *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"DBUserInfo"];
}


@end
