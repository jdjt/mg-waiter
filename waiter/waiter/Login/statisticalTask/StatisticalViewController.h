//
//  StatisticalViewController.h
//  waiter
//
//  Created by sjlh on 2017/4/13.
//  Copyright © 2017年 liuchao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StatisticalViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *timeLable;
@property (weak, nonatomic) IBOutlet UILabel *orderLable;
@property (weak, nonatomic) IBOutlet UILabel *noOrderLable;
@property (weak, nonatomic) IBOutlet UILabel *systemPushLable;
@property (weak, nonatomic) IBOutlet UILabel *orderRateLable;

@property (weak, nonatomic) IBOutlet UIButton *completeButton;

@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@property (weak, nonatomic) IBOutlet UIButton *allButton;

@property (weak, nonatomic) IBOutlet UIButton *independentButton;

@property (weak, nonatomic) IBOutlet UIButton *systemButton;

@property(nonatomic,strong)NSArray * aisArray;//存放全部，系统，自主派单button



@end
