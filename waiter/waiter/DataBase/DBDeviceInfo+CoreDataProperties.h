//
//  DBDeviceInfo+CoreDataProperties.h
//  waiter
//
//  Created by new on 2017/4/18.
//  Copyright © 2017年 liuchao. All rights reserved.
//

#import "DBDeviceInfo+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface DBDeviceInfo (CoreDataProperties)

+ (NSFetchRequest<DBDeviceInfo *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *deviceId;
@property (nullable, nonatomic, copy) NSString *deviceToken;

@end

NS_ASSUME_NONNULL_END
