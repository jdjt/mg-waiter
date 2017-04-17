//
//  MainViewController.m
//  waiter
//
//  Created by sjlh on 2017/4/13.
//  Copyright © 2017年 liuchao. All rights reserved.
//

#import "MainViewController.h"
#import "TaskListCell.h"
#import "FootCell.h"
#import "MapViewController.h"

@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) TaskListCell * taskListCell;
@property (strong, nonatomic) FootCell * footcCell;
@property (weak, nonatomic) IBOutlet UITableView *taskTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableTop;
@property (weak, nonatomic) IBOutlet UIView *stateView;//状态View
@property (weak, nonatomic) IBOutlet UIView *serviceTimeView;//服务时长View
@property (weak, nonatomic) IBOutlet UILabel *taskingLabel;

@property (weak, nonatomic) IBOutlet UIButton *stateButton;//开始接单
@property (assign, nonatomic) BOOL isWorkingState;
@property (assign, nonatomic) BOOL ishiddenFoot;
@property (weak, nonatomic) IBOutlet UIImageView *goMapImage;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.serviceTimeView.hidden = YES;
    self.tableTop.constant = 0.0f;

    self.stateButton.layer.cornerRadius = 5;
    self.stateView.layer.cornerRadius = 3;
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goMapImageAction:)];
    [self.goMapImage addGestureRecognizer:tap];
}

#pragma mark - tableview代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * identifier = @"taskCell";
    _taskListCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    _taskListCell.userName.text = @"王亚东";
    _taskListCell.roomNumber.text = @"椰林酒店-16001";
    _taskListCell.callArea.text = @"椰林酒店";
    _taskListCell.callContent.text = @"你好，我需要打扫房间";
    _taskListCell.orderTime.text = @"2017-03-15  10:39:32";
    return _taskListCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 190;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (self.ishiddenFoot == YES)
    {
        return 50.0f;
    }
    else
    {
        return 0.01f;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    if (self.ishiddenFoot == YES)
    {
        _footcCell = [tableView dequeueReusableCellWithIdentifier:@"footCell"];
        return _footcCell;
    }
    else
    {
        return nil;
    }
}

#pragma mark - 点击事件

//开始接单和停止接单切换
- (IBAction)workingStateButtonAction:(id)sender
{
    if (self.isWorkingState == NO)
    {
        self.stateButton.backgroundColor = [UIColor redColor];
        [self.stateButton setTitle:@"停止接单" forState:UIControlStateNormal];
        self.isWorkingState = YES;
    }
    else
    {
        self.stateButton.backgroundColor = [UIColor colorWithRed:43/255.0f green:170/255.0f blue:59/255.0f alpha:1];
        [self.stateButton setTitle:@"开始接单" forState:UIControlStateNormal];
        self.isWorkingState = NO;
    }
}

//抢单按钮
- (IBAction)pickSingleButtonAction:(id)sender
{
    self.serviceTimeView.hidden = NO;
    self.tableTop.constant = 50.0f;
    self.ishiddenFoot = YES;
    _taskListCell.pickSingleButton.hidden = YES;
//    self.stateView.backgroundColor = [UIColor colorWithRed:16/255.0f green:158/255.0f blue:252/255.0f alpha:1];
    self.stateView.backgroundColor = [UIColor grayColor];
    self.taskingLabel.text = @"进行中任务（1）";
    self.stateButton.backgroundColor = [UIColor grayColor];
    self.stateButton.enabled = NO;
    [self.taskTableView reloadData];
}

//完成按钮
- (IBAction)completeTaskButton:(id)sender
{
//    _footcCell.completeButton.backgroundColor = [UIColor grayColor];
    _footcCell.hidden = YES;
    _taskListCell.pickSingleButton.hidden = NO;
    self.serviceTimeView.hidden = YES;
    self.tableTop.constant = 0.0f;
    self.stateButton.enabled = YES;
    [self.stateButton setTitle:@"停止接单" forState:UIControlStateNormal];
    self.stateButton.backgroundColor = [UIColor redColor];
    
//    self.stateView.backgroundColor = [UIColor colorWithRed:184/255.0f green:184/255.0f blue:184/255.0f alpha:1];
    self.stateView.backgroundColor = [UIColor grayColor];
    self.taskingLabel.text = @"进行中任务（0）";
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)goMapImageAction:(UITapGestureRecognizer *)tap
{
    MapViewController *map = [[MapViewController alloc] init];
    [self.navigationController pushViewController:map animated:YES];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
}


@end
