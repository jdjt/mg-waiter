//
//  JDMJRefreshManager.h
//  waiter
//
//  Created by new on 2017/4/17.
//  Copyright © 2017年 liuchao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJRefresh.h"
@interface JDMJRefreshManager : NSObject
+(MJRefreshNormalHeader *)headerWithRefreshingTarget:(id)target refreshingAction:(SEL)action view:(UITableView *)tableView;
+(MJRefreshAutoNormalFooter *)footWithRefreshingTarget:(id)target refreshingAction:(SEL)action view:(UITableView *)tableView;
@end
