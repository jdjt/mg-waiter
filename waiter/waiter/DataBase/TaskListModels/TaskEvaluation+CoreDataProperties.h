//
//  TaskEvaluation+CoreDataProperties.h
//  waiter
//
//  Created by new on 2017/4/18.
//  Copyright © 2017年 liuchao. All rights reserved.
//

#import "TaskEvaluation+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface TaskEvaluation (CoreDataProperties)

+ (NSFetchRequest<TaskEvaluation *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *scoreTime;
@property (nullable, nonatomic, copy) NSString *scoreMod;
@property (nullable, nonatomic, copy) NSString *scoreVal;

@end

NS_ASSUME_NONNULL_END
