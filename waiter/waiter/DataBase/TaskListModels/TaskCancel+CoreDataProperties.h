//
//  TaskCancel+CoreDataProperties.h
//  waiter
//
//  Created by new on 2017/4/18.
//  Copyright © 2017年 liuchao. All rights reserved.
//

#import "TaskCancel+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface TaskCancel (CoreDataProperties)

+ (NSFetchRequest<TaskCancel *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *causeCode;
@property (nullable, nonatomic, copy) NSString *causeDesc;

@end

NS_ASSUME_NONNULL_END
