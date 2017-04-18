//
//  DataBaseManager+Category.h
//  waiter
//
//  Created by new on 2017/4/18.
//  Copyright © 2017年 liuchao. All rights reserved.
//

#import "DataBaseManager.h"
#import "DBDeviceInfo+CoreDataClass.h"
#import "DBLogInInfo+CoreDataClass.h"
#import "DBWaiterInfo+CoreDataClass.h"
@interface DataBaseManager (Category)
/**
 * @abstract 获取设备参数表
 */
- (DBDeviceInfo *)getDeviceInfo;
/**
 * @abstract 获取登录参数表
 */
- (DBLogInInfo *)getLogInInfo;
/**
 * @abstract 获取Waiter参数表
 */
- (DBWaiterInfo *)getWaiterInfo;
@end
