//
//  DBUserInfo+CoreDataProperties.h
//  waiter
//
//  Created by new on 2017/4/13.
//  Copyright © 2017年 liuchao. All rights reserved.
//

#import "DBUserInfo+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface DBUserInfo (CoreDataProperties)

+ (NSFetchRequest<DBUserInfo *> *)fetchRequest;


@end

NS_ASSUME_NONNULL_END
