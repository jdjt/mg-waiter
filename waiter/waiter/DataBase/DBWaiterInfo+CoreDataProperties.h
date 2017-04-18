//
//  DBWaiterInfo+CoreDataProperties.h
//  waiter
//
//  Created by new on 2017/4/18.
//  Copyright © 2017年 liuchao. All rights reserved.
//

#import "DBWaiterInfo+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface DBWaiterInfo (CoreDataProperties)

+ (NSFetchRequest<DBWaiterInfo *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *hotelCode;
@property (nullable, nonatomic, copy) NSString *hotelName;
@property (nullable, nonatomic, copy) NSString *empNo;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *sex;
@property (nullable, nonatomic, copy) NSString *phone;
@property (nullable, nonatomic, copy) NSString *depId;
@property (nullable, nonatomic, copy) NSString *depName;
@property (nullable, nonatomic, copy) NSString *idNo;
@property (nullable, nonatomic, copy) NSString *resetPwdDiv;
@property (nullable, nonatomic, copy) NSString *imAccount;
@property (nullable, nonatomic, copy) NSString *deviceId;
@property (nullable, nonatomic, copy) NSString *deviceToken;
@property (nullable, nonatomic, copy) NSString *deviceType;
@property (nullable, nonatomic, copy) NSString *workStatus;
@property (nullable, nonatomic, copy) NSString *attendStatus;
@property (nullable, nonatomic, copy) NSString *workTimeCal;

@end

NS_ASSUME_NONNULL_END
