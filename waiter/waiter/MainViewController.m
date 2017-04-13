//
//  MainViewController.m
//  waiter
//
//  Created by sjlh on 2017/4/13.
//  Copyright © 2017年 liuchao. All rights reserved.
//

#import "MainViewController.h"
#import "TaskListCell.h"
@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *taskTableView;
@property (nonatomic, strong) UIView *headView;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (UIView *)headView
{
    self.headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    self.headView.backgroundColor = [UIColor greenColor];
    return _headView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * identifier = @"taskCell";
    TaskListCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return _headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
