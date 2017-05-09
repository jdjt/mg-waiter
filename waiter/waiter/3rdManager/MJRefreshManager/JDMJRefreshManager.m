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
    [header setTitle:@"下拉可以刷新" forState:MJRefreshStateIdle];
    [header setTitle:@"松开立即刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"正在刷新数据中..." forState:MJRefreshStateRefreshing];
    
    if (tableView.mj_header == nil) {
        tableView.mj_header = header;
    }
    
    return header;

}

+(MJRefreshAutoNormalFooter *)footWithRefreshingTarget:(id)target refreshingAction:(SEL)action view:(UITableView *)tableView{
    
    MJRefreshAutoNormalFooter * footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:target refreshingAction:action];
    
    // 设置文字
    [footer setTitle:@"点击或上拉加载更多" forState:MJRefreshStateIdle];
    [footer setTitle:@"正在加载更多的数据..." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"已经全部加载完毕" forState:MJRefreshStateNoMoreData];
    
    // 设置字体
    //footer.stateLabel.font = [UIFont systemFontOfSize:17];
    
    // 设置颜色
    //footer.stateLabel.textColor = [UIColor blueColor];
    
    // 设置footer
    if (tableView.mj_footer == nil) {
        tableView.mj_footer = footer;
    }
    
    
    return footer;
    
}
@end
