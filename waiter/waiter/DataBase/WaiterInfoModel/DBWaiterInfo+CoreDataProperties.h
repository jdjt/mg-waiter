//
//  DBWaiterInfo+CoreDataProperties.h
//  waiter
//
//  Created by chao liu on 2017/5/16.
//  Copyright © 2017年 liuchao. All rights reserved.
//

#import "DBWaiterInfo+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface DBWaiterInfo (CoreDataProperties)

+ (NSFetchRequest<DBWaiterInfo *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *attendStatus;
@property (nullable, nonatomic, copy) NSString *attribute;
@property (nullable, nonatomic, copy) NSString *depId;
@property (nullable, nonatomic, copy) NSString *depName;
@property (nullable, nonatomic, copy) NSString *deviceId;
@property (nullable, nonatomic, copy) NSString *deviceToken;
@property (nullable, nonatomic, copy) NSString *deviceType;
@property (nullable, nonatomic, copy) NSString *empNo;
@property (nullable, nonatomic, copy) NSString *hotelCode;
@property (nullable, nonatomic, copy) NSString *hotelName;
@property (nullable, nonatomic, copy) NSString *idNo;
@property (nullable, nonatomic, copy) NSString *imAccount;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *nowTime;
@property (nullable, nonatomic, copy) NSString *phone;
@property (nullable, nonatomic, copy) NSString *resetPwdDiv;
@property (nullable, nonatomic, copy) NSString *sex;
@property (nullable, nonatomic, copy) NSString *uploadPerSecond;
@property (nullable, nonatomic, copy) NSString *waiterId;
@property (nullable, nonatomic, copy) NSString *workStatus;
@property (nullable, nonatomic, copy) NSString *workTimeCal;
@property (nullable, nonatomic, copy) NSString *parentDepName;
@property (nullable, nonatomic, retain) HistoricalStatistics *hasHistoriceStatiscs;
@property (nullable, nonatomic, retain) NSOrderedSet<TaskList *> *hasTaskList;

@end

@interface DBWaiterInfo (CoreDataGeneratedAccessors)

- (void)insertObject:(TaskList *)value inHasTaskListAtIndex:(NSUInteger)idx;
- (void)removeObjectFromHasTaskListAtIndex:(NSUInteger)idx;
- (void)insertHasTaskList:(NSArray<TaskList *> *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeHasTaskListAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInHasTaskListAtIndex:(NSUInteger)idx withObject:(TaskList *)value;
- (void)replaceHasTaskListAtIndexes:(NSIndexSet *)indexes withHasTaskList:(NSArray<TaskList *> *)values;
- (void)addHasTaskListObject:(TaskList *)value;
- (void)removeHasTaskListObject:(TaskList *)value;
- (void)addHasTaskList:(NSOrderedSet<TaskList *> *)values;
- (void)removeHasTaskList:(NSOrderedSet<TaskList *> *)values;

@end

NS_ASSUME_NONNULL_END
