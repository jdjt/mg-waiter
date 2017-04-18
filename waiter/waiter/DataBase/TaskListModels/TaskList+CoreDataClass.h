//
//  TaskList+CoreDataClass.h
//  waiter
//
//  Created by new on 2017/4/18.
//  Copyright © 2017年 liuchao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TaskCancel, TaskEvaluation;

NS_ASSUME_NONNULL_BEGIN

@interface TaskList : NSManagedObject

@end

NS_ASSUME_NONNULL_END

#import "TaskList+CoreDataProperties.h"
