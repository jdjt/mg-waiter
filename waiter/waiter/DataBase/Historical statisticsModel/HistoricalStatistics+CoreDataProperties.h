//
//  HistoricalStatistics+CoreDataProperties.h
//  waiter
//
//  Created by new on 2017/4/26.
//  Copyright © 2017年 liuchao. All rights reserved.
//

#import "HistoricalStatistics+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface HistoricalStatistics (CoreDataProperties)

+ (NSFetchRequest<HistoricalStatistics *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *pageNo;
@property (nullable, nonatomic, copy) NSString *count;
@property (nullable, nonatomic, copy) NSString *pushTaskCount;
@property (nullable, nonatomic, copy) NSString *acceptTaskCount;
@property (nullable, nonatomic, retain) NSOrderedSet<TaskList *> *hasHisStaTaskList;
@property (nullable, nonatomic, retain) DBWaiterInfo *belongHisWaiterInfo;

@end

@interface HistoricalStatistics (CoreDataGeneratedAccessors)

- (void)insertObject:(TaskList *)value inHasHisStaTaskListAtIndex:(NSUInteger)idx;
- (void)removeObjectFromHasHisStaTaskListAtIndex:(NSUInteger)idx;
- (void)insertHasHisStaTaskList:(NSArray<TaskList *> *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeHasHisStaTaskListAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInHasHisStaTaskListAtIndex:(NSUInteger)idx withObject:(TaskList *)value;
- (void)replaceHasHisStaTaskListAtIndexes:(NSIndexSet *)indexes withHasHisStaTaskList:(NSArray<TaskList *> *)values;
- (void)addHasHisStaTaskListObject:(TaskList *)value;
- (void)removeHasHisStaTaskListObject:(TaskList *)value;
- (void)addHasHisStaTaskList:(NSOrderedSet<TaskList *> *)values;
- (void)removeHasHisStaTaskList:(NSOrderedSet<TaskList *> *)values;

@end

NS_ASSUME_NONNULL_END
