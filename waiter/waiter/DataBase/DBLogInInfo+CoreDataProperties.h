//
//  DBLogInInfo+CoreDataProperties.h
//  waiter
//
//  Created by new on 2017/4/18.
//  Copyright © 2017年 liuchao. All rights reserved.
//

#import "DBLogInInfo+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface DBLogInInfo (CoreDataProperties)

+ (NSFetchRequest<DBLogInInfo *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *waiterId;
@property (nullable, nonatomic, copy) NSString *uploadPerSecond;
@property (nullable, nonatomic, copy) NSString *nowTime;
@property (nullable, nonatomic, retain) DBWaiterInfo *waiterInfo;

@end

NS_ASSUME_NONNULL_END
