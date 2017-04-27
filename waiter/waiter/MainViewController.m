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
#import "AlterViewController.h"
@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) TaskListCell * taskListCell;
@property (strong, nonatomic) FootCell * footcCell;
@property (weak, nonatomic) IBOutlet UITableView *taskTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableTop;
@property (weak, nonatomic) IBOutlet UIView *stateView;//状态View
@property (weak, nonatomic) IBOutlet UIView *serviceTimeView;//服务时长View
@property (weak, nonatomic) IBOutlet UILabel *empNoLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *depNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *workTimeCalLabel;

@property (weak, nonatomic) IBOutlet UILabel *taskingLabel;

@property (weak, nonatomic) IBOutlet UIButton *stateButton;//开始接单
@property (assign, nonatomic) BOOL isWorkingState;
@property (assign, nonatomic) BOOL ishiddenFoot;
@property (weak, nonatomic) IBOutlet UIImageView *goMapImage;
@property (strong, nonatomic) DBWaiterInfo * userInfo;

@property (nonatomic, strong)NSTimer *timer;
@property (nonatomic, assign)NSInteger second;
@property (nonatomic, assign)NSInteger minute;
@property (nonatomic, assign)NSInteger hour;
@property (nonatomic, strong)NSString * secondString;
@property (nonatomic, strong)NSString * minuteString;
@property (nonatomic, strong)NSString * hourString;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.ishiddenFoot = NO;
    
    self.serviceTimeView.hidden = YES;
    self.tableTop.constant = 0.0f;

    self.stateButton.layer.cornerRadius = 5;
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goMapImageAction:)];
    [self.goMapImage addGestureRecognizer:tap];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wwwwwwww:) name:WAITER_RECEIVED_PUSH object:nil];
    
    
}
-(void)wwwwwwww:(NSNotification *)notion{

    if ([CusAddTaskK isEqualToString:[notion.userInfo objectForKey:@"type"]])
    {
        
    }


}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.userInfo = [[DataBaseManager defaultInstance]getWaiterInfo:nil];
    NSLog(@"time : %@",self.userInfo.workTimeCal);
    self.empNoLabel.text = self.userInfo.empNo;
    self.nameLabel.text = self.userInfo.name;
    self.depNameLabel.text = self.userInfo.depName;
    
    
    [self NET_attendStatus];
    
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
    if ([self.userInfo.workStatus isEqualToString:@"2"])
    {
        UIColor * color = [UIColor colorWithRed:42/255.0f green:160/255.0f blue:235/255.0f alpha:1];
        [self changeWaiterStatus:@"2" statusName:@"开始接单" color:color];
        
    }
    else
    {
        UIColor * color = [UIColor colorWithRed:242/255.0f green:69/255.0f blue:41/255.0f alpha:1];
        [self changeWaiterStatus:@"1" statusName:@"停止接单" color:color];
        
    }
}

//抢单按钮
- (IBAction)pickSingleButtonAction:(id)sender
{
    [AlterViewController alterViewOwner:self WithAlterViewStype:AlterViewGrabSingle WithMessageCount:nil WithAlterViewBlock:^(UIButton *button, NSInteger buttonIndex) {
        if (buttonIndex == 1)
        {
            self.serviceTimeView.hidden = NO;
            self.tableTop.constant = 59.0f;
            self.ishiddenFoot = YES;
            _taskListCell.pickSingleButton.hidden = YES;
            _taskListCell.separatedView.hidden = YES;
            self.stateView.backgroundColor = [UIColor colorWithRed:137/255.0f green:137/255.0f blue:137/255.0f alpha:1];
            self.taskingLabel.text = @"进行中任务（1）";
            self.stateButton.backgroundColor = [UIColor colorWithRed:137/255.0f green:137/255.0f blue:137/255.0f alpha:1];
            self.stateButton.enabled = NO;
            self.navigationItem.leftBarButtonItem.enabled = NO;
            [self.taskTableView reloadData];
        }
        
    }];
    
}

//完成按钮
- (IBAction)completeTaskButton:(id)sender
{
    
    [AlterViewController alterViewOwner:self WithAlterViewStype:AlterViewServiceComplete WithMessageCount:nil WithAlterViewBlock:^(UIButton *button, NSInteger buttonIndex) {
        if (buttonIndex == 1)
        {
            self.ishiddenFoot = NO;
            _taskListCell.pickSingleButton.hidden = NO;//显示抢单按钮
            _taskListCell.separatedView.hidden = NO;
            self.serviceTimeView.hidden = YES;//隐藏服务时间View
            self.tableTop.constant = 0.0f;
            self.stateButton.enabled = YES;
            [self.stateButton setTitle:@"停止接单" forState:UIControlStateNormal];
            self.stateButton.backgroundColor = [UIColor redColor];
            self.stateView.backgroundColor = [UIColor colorWithRed:210/255.0f green:210/255.0f blue:210/255.0f alpha:1];
            self.taskingLabel.text = @"进行中任务（0）";
            self.navigationItem.leftBarButtonItem.enabled = YES;
            [self.taskTableView reloadData];
        }
    }];
}

//下班按钮
- (IBAction)goLogin:(id)sender
{
    [AlterViewController alterViewOwner:self WithAlterViewStype:AlterViewLogoOut WithMessageCount:nil WithAlterViewBlock:^(UIButton *button, NSInteger buttonIndex) {
        if (buttonIndex == 1)
        {
            NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
            [[NetworkRequestManager defaultManager] POST_Url:URI_WAITER_Logout Params:params withByUser:YES Success:^(NSURLSessionTask *task, id dataSource, NSString *message, NSString *url) {
//                self.userInfo.attendStatus = @"0";
                [[DataBaseManager defaultInstance] deleteFromCoreData:self.userInfo];
                [[DataBaseManager defaultInstance] saveContext];
                [self performSegueWithIdentifier:@"goLogin" sender:nil];
            } Failure:^(NSURLSessionTask *task, NSString *message, NSString *status, NSString *url) {
                NSLog(@"message --- %@",message);
            }];
        }
    }];
}


#pragma mark - 方法
- (void)changeWaiterStatus:(NSString *)waiterStatus statusName:(NSString *)statusName color:(UIColor *)color
{
    NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
    [params setObject:waiterStatus forKey:@"workStatus"];
    
    //切换服务员状态
    [[NetworkRequestManager defaultManager] POST_Url:URI_WAITER_SetWorkStatus Params:params withByUser:NO Success:^(NSURLSessionTask *task, id dataSource, NSString *message, NSString *url) {
        //获取服务员信息
        [[NetworkRequestManager defaultManager] POST_Url:URI_WAITER_WaiterInfoByWaiterId Params:nil withByUser:YES Success:^(NSURLSessionTask *task, id dataSource, NSString *message, NSString *url) {
            _userInfo = dataSource;
            [[DataBaseManager defaultInstance] saveContext];
            if ([_userInfo.workStatus isEqualToString:@"2"])
            {
                NSLog(@"可以获取任务列表了");
                NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
                //获取任务列表
                [[NetworkRequestManager defaultManager] POST_Url:URI_WAITER_TaskAfterAccept Params:params withByUser:YES Success:^(NSURLSessionTask *task, id dataSource, NSString *message, NSString *url) {
                    NSLog(@"dataSource --- %@",dataSource);
                } Failure:^(NSURLSessionTask *task, NSString *message, NSString *status, NSString *url) {
                    NSLog(@"message --- %@",message);
                }];
            }
            self.stateButton.backgroundColor = color;
            [self.stateButton setTitle:statusName forState:UIControlStateNormal];
        } Failure:^(NSURLSessionTask *task, NSString *message, NSString *status, NSString *url) {
            NSLog(@"message --- %@",message);
        }];
    } Failure:^(NSURLSessionTask *task, NSString *message, NSString *status, NSString *url) {
        NSLog(@"message --- %@",message);
    }];
}

//检查上班状态 是否上班
- (void)NET_attendStatus
{
    NSLog(@"%@",self.userInfo.attendStatus);
    if ([self.userInfo.attendStatus isEqualToString:@"0"] || self.userInfo.attendStatus == nil)
    {
        [self performSegueWithIdentifier:@"goLogin" sender:nil];
    }
    else
    {
        [[NetworkRequestManager defaultManager] POST_Url:URI_WAITER_WaiterInfoByWaiterId Params:nil withByUser:YES Success:^(NSURLSessionTask *task, id dataSource, NSString *message, NSString *url) {
            _userInfo = dataSource;
            [[DataBaseManager defaultInstance] saveContext];
            [self workingTime];
        } Failure:^(NSURLSessionTask *task, NSString *message, NSString *status, NSString *url) {
            NSLog(@"message --- %@",message);
        }];
    }
}

//工作时长
- (void)workingTime
{
    if (self.userInfo.workTimeCal != nil){
        NSMutableString * time=[[NSMutableString alloc]initWithString:self.userInfo.workTimeCal];
        NSRange ange={0,2};
        _hourString=[time substringWithRange:ange];//截取时
        NSRange ange1={3,2};
        _minuteString =[time substringWithRange:ange1];//截取分
        NSRange ange2={6,2};
        _secondString =[time substringWithRange:ange2];//截取秒
        self.second = [self.secondString integerValue];
        self.minute = [self.minuteString integerValue];
        self.hour   = [self.hourString integerValue];
    }
    self.workTimeCalLabel.text = self.userInfo.workTimeCal;
    [self.timer invalidate];
    self.timer = nil;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeHeadle) userInfo:nil repeats:YES];
}

- (void)timeHeadle{
    self.second++;
    if (self.second==60){
        self.second=00;
        self.minute++;
        if (self.minute==60) {
            self.minute=00;
            self.hour++;
        }
    }
    self.workTimeCalLabel.text = [NSString stringWithFormat:@"%02ld:%02ld:%02ld",(long)self.hour,(long)self.minute,(long)self.second];
    self.userInfo.workTimeCal = self.workTimeCalLabel.text;
}
#pragma mark - ------

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
