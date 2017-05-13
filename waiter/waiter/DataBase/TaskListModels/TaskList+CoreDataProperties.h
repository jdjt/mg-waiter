//
//  TaskList+CoreDataProperties.h
//  waiter
//
//  Created by chao liu on 2017/5/12.
//  Copyright © 2017年 liuchao. All rights reserved.
//

#import "TaskList+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface TaskList (CoreDataProperties)

+ (NSFetchRequest<TaskList *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *acceptTime;
@property (nullable, nonatomic, copy) NSString *areaCode;
@property (nullable, nonatomic, copy) NSString *areaName;
@property (nonatomic) float callContentHeight;
@property (nullable, nonatomic, copy) NSString *causeCode;
@property (nullable, nonatomic, copy) NSString *causeDesc;
@property (nullable, nonatomic, copy) NSString *causePoint;
@property (nullable, nonatomic, copy) NSString *causeTime;
@property (nullable, nonatomic, copy) NSString *cImAccount;
@property (nullable, nonatomic, copy) NSString *comeFrom;
@property (nullable, nonatomic, copy) NSString *confirmTime;
@property (nullable, nonatomic, copy) NSString *customerDeviceId;
@property (nullable, nonatomic, copy) NSString *customerId;
@property (nullable, nonatomic, copy) NSString *customerName;
@property (nullable, nonatomic, copy) NSString *customerRoomNum;
@property (nullable, nonatomic, copy) NSString *finishEndTime;
@property (nullable, nonatomic, copy) NSString *finishTime;
@property (nullable, nonatomic, copy) NSString *floorNo;
@property (nullable, nonatomic, copy) NSString *hotelCode;
@property (nonatomic) BOOL isAnOpen;
@property (nullable, nonatomic, copy) NSString *mapNo;
@property (nullable, nonatomic, copy) NSString *nowDate;
@property (nullable, nonatomic, copy) NSString *positionX;
@property (nullable, nonatomic, copy) NSString *positionY;
@property (nullable, nonatomic, copy) NSString *positionZ;
@property (nullable, nonatomic, copy) NSString *produceTime;
@property (nullable, nonatomic, copy) NSString *scoreMod;
@property (nullable, nonatomic, copy) NSString *scoreTime;
@property (nullable, nonatomic, copy) NSString *scoreVal;
@property (nullable, nonatomic, copy) NSString *taskCode;
@property (nullable, nonatomic, copy) NSString *taskContent;
@property (nullable, nonatomic, copy) NSString *taskStatus;
@property (nullable, nonatomic, copy) NSString *taskTypeCustom;
@property (nullable, nonatomic, copy) NSString *waiterDeviceId;
@property (nullable, nonatomic, copy) NSString *waiterEndTime;
@property (nullable, nonatomic, copy) NSString *waiterId;
@property (nullable, nonatomic, copy) NSString *waiterName;
@property (nullable, nonatomic, copy) NSString *waiteTime;
@property (nullable, nonatomic, copy) NSString *wImAccount;
@property (nullable, nonatomic, retain) HistoricalStatistics *belongHistoricalStatics;
@property (nullable, nonatomic, retain) DBWaiterInfo *belongWaiterInfor;
@property (nullable, nonatomic, retain) NSOrderedSet<ChatMessage *> *haschatmessage;

@end

@interface TaskList (CoreDataGeneratedAccessors)

- (void)insertObject:(ChatMessage *)value inHaschatmessageAtIndex:(NSUInteger)idx;
- (void)removeObjectFromHaschatmessageAtIndex:(NSUInteger)idx;
- (void)insertHaschatmessage:(NSArray<ChatMessage *> *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeHaschatmessageAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInHaschatmessageAtIndex:(NSUInteger)idx withObject:(ChatMessage *)value;
- (void)replaceHaschatmessageAtIndexes:(NSIndexSet *)indexes withHaschatmessage:(NSArray<ChatMessage *> *)values;
- (void)addHaschatmessageObject:(ChatMessage *)value;
- (void)removeHaschatmessageObject:(ChatMessage *)value;
- (void)addHaschatmessage:(NSOrderedSet<ChatMessage *> *)values;
- (void)removeHaschatmessage:(NSOrderedSet<ChatMessage *> *)values;

@end

NS_ASSUME_NONNULL_END
