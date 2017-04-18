//
//  TaskList+CoreDataProperties.h
//  waiter
//
//  Created by new on 2017/4/18.
//  Copyright © 2017年 liuchao. All rights reserved.
//

#import "TaskList+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface TaskList (CoreDataProperties)

+ (NSFetchRequest<TaskList *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *taskContent;
@property (nullable, nonatomic, copy) NSString *taskStatus;
@property (nullable, nonatomic, copy) NSString *hotelCode;
@property (nullable, nonatomic, copy) NSString *areaCode;
@property (nullable, nonatomic, copy) NSString *areaName;
@property (nullable, nonatomic, copy) NSString *floorNo;
@property (nullable, nonatomic, copy) NSString *mapNo;
@property (nullable, nonatomic, copy) NSString *posionX;
@property (nullable, nonatomic, copy) NSString *positionY;
@property (nullable, nonatomic, copy) NSString *postionZ;
@property (nullable, nonatomic, copy) NSString *customerId;
@property (nullable, nonatomic, copy) NSString *cImAccount;
@property (nullable, nonatomic, copy) NSString *waiterId;
@property (nullable, nonatomic, copy) NSString *wImAccount;
@property (nullable, nonatomic, copy) NSString *nowDate;
@property (nullable, nonatomic, copy) NSString *waiteTime;
@property (nullable, nonatomic, copy) NSString *waiterEndTime;
@property (nullable, nonatomic, copy) NSString *acceptTime;
@property (nullable, nonatomic, copy) NSString *finishTime;
@property (nullable, nonatomic, copy) NSString *finishEndTime;
@property (nullable, nonatomic, retain) TaskCancel *cancelDetail;
@property (nullable, nonatomic, retain) TaskEvaluation *scoreDetail;

@end

NS_ASSUME_NONNULL_END
