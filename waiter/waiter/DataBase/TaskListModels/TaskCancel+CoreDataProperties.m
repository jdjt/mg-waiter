//
//  TaskCancel+CoreDataProperties.m
//  waiter
//
//  Created by new on 2017/4/18.
//  Copyright © 2017年 liuchao. All rights reserved.
//

#import "TaskCancel+CoreDataProperties.h"

@implementation TaskCancel (CoreDataProperties)

+ (NSFetchRequest<TaskCancel *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"TaskCancel"];
}

@dynamic causeCode;
@dynamic causeDesc;

@end
