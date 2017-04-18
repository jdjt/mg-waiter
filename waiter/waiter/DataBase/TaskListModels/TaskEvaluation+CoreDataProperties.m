//
//  TaskEvaluation+CoreDataProperties.m
//  waiter
//
//  Created by new on 2017/4/18.
//  Copyright © 2017年 liuchao. All rights reserved.
//

#import "TaskEvaluation+CoreDataProperties.h"

@implementation TaskEvaluation (CoreDataProperties)

+ (NSFetchRequest<TaskEvaluation *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"TaskEvaluation"];
}

@dynamic scoreTime;
@dynamic scoreMod;
@dynamic scoreVal;

@end
