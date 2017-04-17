//
//  JDMJRefreshManager.m
//  waiter
//
//  Created by new on 2017/4/17.
//  Copyright © 2017年 liuchao. All rights reserved.
//

#import "JDMJRefreshManager.h"

@implementation JDMJRefreshManager
+(MJRefreshNormalHeader *)headerWithRefreshingTarget:(id)target refreshingAction:(SEL)action view:(UITableView *)tableView{
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:target refreshingAction:action];
    
    // 设置文字
    [header setTitle:@"Pull down to refresh" forState:MJRefreshStateIdle];
    [header setTitle:@"Release to refresh" forState:MJRefreshStatePulling];
    [header setTitle:@"Loading ..." forState:MJRefreshStateRefreshing];
    
    tableView.mj_header = header;
    
    return header;

}

+(MJRefreshAutoNormalFooter *)footWithRefreshingTarget:(id)target refreshingAction:(SEL)action view:(UITableView *)tableView{
    
    MJRefreshAutoNormalFooter * footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:target refreshingAction:action];
    
    // 设置文字
    [footer setTitle:@"Click or drag up to refresh" forState:MJRefreshStateIdle];
    [footer setTitle:@"Loading more ..." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"No more data" forState:MJRefreshStateNoMoreData];
    
    // 设置字体
    //footer.stateLabel.font = [UIFont systemFontOfSize:17];
    
    // 设置颜色
    //footer.stateLabel.textColor = [UIColor blueColor];
    
    // 设置footer
    tableView.mj_footer = footer;
    
    return footer;
    
}
@end
