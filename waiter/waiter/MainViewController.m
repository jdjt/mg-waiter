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
@property (weak, nonatomic) FootCell * footcCell;
@property (weak, nonatomic) IBOutlet UITableView *taskTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableTop;
@property (weak, nonatomic) IBOutlet UIView *stateView;//状态View
@property (weak, nonatomic) IBOutlet UIView *serviceTimeView;//服务时长View
@property (weak, nonatomic) IBOutlet UILabel *serviceTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *empNoLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *depNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *workTimeCalLabel;

@property (weak, nonatomic) IBOutlet UILabel *taskingLabel;

@property (weak, nonatomic) IBOutlet UIButton *stateButton;//开始接单

@property (assign, nonatomic) BOOL isWorkingState;
@property (assign, nonatomic) BOOL ishiddenFoot;
@property (weak, nonatomic) IBOutlet UIImageView *goMapImage;
@property (weak, nonatomic) IBOutlet UIImageView *goChatImage;
@property (strong, nonatomic) DBWaiterInfo * userInfo;
@property (strong, nonatomic) TaskList * taskList;
@property (strong, nonatomic) NSMutableArray * dataSource;

@property (nonatomic, assign)BOOL isDown;
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
    UITapGestureRecognizer * chatTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goChatImageAction:)];
    [self.goChatImage addGestureRecognizer:chatTap];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushTypeAction:) name:WAITER_RECEIVED_PUSH object:nil];
    
    self.dataSource = [[NSMutableArray alloc]initWithCapacity:10];

//    [_timer1 setFireDate:[NSDate date]];//开始 .备用
}

-(void)pushTypeAction:(NSNotification *)notion
{
    NSLog(@"%@",notion);
    NSDictionary *dic =  notion.object;
    if ([EBCALL002 isEqualToString:[dic objectForKey:@"messType"]])
    {
        [self performSegueWithIdentifier:@"goLogin" sender:nil];
    }
    if ([CusAddTaskK isEqualToString:[dic objectForKey:@"messType"]])
    {
        NSLog(@"新任务");
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
    [self workingTime];
    [self NET_attendStatus];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

#pragma mark - tableview代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"%ld",self.dataSource.count);
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * identifier = @"taskCell";
    _taskListCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (self.dataSource.count != 0){
        self.taskList = self.dataSource[indexPath.row];
    }
    _taskListCell.userName.text = self.taskList.customerName;
    _taskListCell.roomNumber.text = [NSString stringWithFormat:@"%@-%@",self.taskList.floorNo,self.taskList.taskCode];
    _taskListCell.callArea.text = self.taskList.areaName;
    _taskListCell.callContent.text = self.taskList.taskContent;
    _taskListCell.orderTime.text = [self timeWithTimeIntervalString:self.taskList.produceTime];
    _taskListCell.pickSingleButton.tag = indexPath.row;
    NSLog(@"%@",self.taskList.taskStatus);
    
    //服务时长
    NSString * strData = [self compareTwoTime:[self.taskList.acceptTime longLongValue] time2:[self.taskList.nowDate longLongValue]];
    [self serverTime:strData];
    if (self.isDown) {
        _taskListCell.pickSingleButton.hidden = YES;//隐藏抢单按钮
        _taskListCell.separatedView.hidden = YES;//分隔符
    }
    else
    {
        _taskListCell.pickSingleButton.hidden = NO;//显示抢单按钮
        _taskListCell.separatedView.hidden = NO;//显示分隔符
    }
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
        if ([self.taskList.taskStatus isEqualToString:@"2"])//服务员点了完成
        {
            _footcCell.completeButton.backgroundColor = [UIColor grayColor];
            _footcCell.completeButton.enabled = NO;
        }
        if ([self.taskList.taskStatus isEqualToString:@"7"])//客人不认可
        {
            _footcCell.completeButton.backgroundColor = [UIColor colorWithRed:42/255.0f green:160/255.0f blue:235/255.0f alpha:1];
            _footcCell.completeButton.enabled = YES;
        }
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
    // 获取被点击抢单按钮的cell
    UIView * content = [sender superview];
    self.taskListCell = (TaskListCell *)[content superview];
    NSIndexPath * indexPath = [self.taskTableView indexPathForCell:self.taskListCell];
    self.taskList = self.dataSource[indexPath.row];
    
    [AlterViewController alterViewOwner:self WithAlterViewStype:AlterViewGrabSingle WithMessageCount:nil WithAlterViewBlock:^(UIButton *button, NSInteger buttonIndex) {
        if (buttonIndex == 1)
        {
            UIButton * btn = (UIButton *)sender;
            self.taskList = self.dataSource[btn.tag];
            NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
            [params setObject:self.taskList.taskCode forKey:@"taskCode"];
            NSLog(@"抢到的单号：%@",self.taskList.taskCode);
            [[NetworkRequestManager defaultManager] POST_Url:URI_WAITER_AcceptTask Params:params withByUser:YES Success:^(NSURLSessionTask *task, id dataSource, NSString *message, NSString *url) {
                NSLog(@"抢单成功 --- %@",dataSource);
                [[NetworkRequestManager defaultManager] POST_Url:URI_WAITER_GetTaskInfoByTaskCode Params:params withByUser:YES Success:^(NSURLSessionTask *task, id dataSource, NSString *message, NSString *url) {
                    NSLog(@"服务员根据任务号获取任务信息成功 --- %@",dataSource);
                    self.isDown = YES;
                    [self.dataSource removeAllObjects];
                    [self.dataSource addObject:dataSource];
                    NSLog(@"%ld",self.dataSource.count);
                    
                    NSLog(@"抢单时间：%@",[self timeWithTimeIntervalString:self.taskList.acceptTime]);
                    NSLog(@"系统时间:%@",[self timeWithTimeIntervalString:self.taskList.nowDate]);
                    
                    self.tableTop.constant = 59.0f;
                    self.ishiddenFoot = YES;//显示foot
                    self.serviceTimeView.hidden = NO;//显示服务时长的View
                    self.taskTableView.mj_header = nil;
                    self.stateView.backgroundColor = [UIColor colorWithRed:137/255.0f green:137/255.0f blue:137/255.0f alpha:1];
                    self.taskingLabel.text = @"进行中任务（1）";
                    self.stateButton.backgroundColor = [UIColor colorWithRed:137/255.0f green:137/255.0f blue:137/255.0f alpha:1];
                    self.stateButton.enabled = NO;
                    self.navigationItem.leftBarButtonItem.enabled = NO;
                    
                    [self.taskTableView reloadData];
                    
                } Failure:^(NSURLSessionTask *task, NSString *message, NSString *status, NSString *url) {
                    NSLog(@"服务员根据任务号获取任务信息失败 --- %@",message);
                }];
            } Failure:^(NSURLSessionTask *task, NSString *message, NSString *status, NSString *url) {
                NSLog(@"抢单失败 --- %@",message);
            }];
        }
    }];
    
}

//完成按钮
- (IBAction)completeTaskButton:(id)sender
{
    [AlterViewController alterViewOwner:self WithAlterViewStype:AlterViewServiceComplete WithMessageCount:nil WithAlterViewBlock:^(UIButton *button, NSInteger buttonIndex) {
        if (buttonIndex == 1)
        {
            DBDeviceInfo * deviceInfo = [[DataBaseManager defaultInstance] getDeviceInfo];
            NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
            NSLog(@"完成时的编号：%@",self.taskList.taskCode);
            [params setObject:_userInfo.waiterId forKey:@"waiterId"];
            [params setObject:deviceInfo.deviceId forKey:@"deviceId"];
            [params setObject:deviceInfo.deviceToken forKey:@"deviceToken"];
            [params setObject:self.taskList.taskCode forKey:@"taskCode"];
            
            [[NetworkRequestManager defaultManager] POST_Url:URI_WAITER_ConfirmTask Params:params withByUser:YES Success:^(NSURLSessionTask *task, id dataSource, NSString *message, NSString *url) {
                NSLog(@"dataSource --- %@",dataSource);
                
                _footcCell.completeButton.backgroundColor = [UIColor grayColor];
                _footcCell.completeButton.enabled = NO;
                //服务时长暂停计时
                [_timer1 setFireDate:[NSDate distantFuture]];
                
                //获取根据任务号获取信息，为了拿到完成时间，去跟系统时间对比，做30分钟倒计时功能。
                [[NetworkRequestManager defaultManager] POST_Url:URI_WAITER_GetTaskInfoByTaskCode Params:params withByUser:YES Success:^(NSURLSessionTask *task, id dataSource, NSString *message, NSString *url) {
                    NSLog(@"服务员根据任务号获取任务信息成功 --- %@",dataSource);

                    self.taskList = dataSource;
                    
                    NSLog(@"抢单时间：%@",[self timeWithTimeIntervalString:self.taskList.finishTime]);
                    NSLog(@"系统时间:%@",[self timeWithTimeIntervalString:self.taskList.nowDate]);
                    
                    
                } Failure:^(NSURLSessionTask *task, NSString *message, NSString *status, NSString *url) {
                    NSLog(@"服务员根据任务号获取任务信息失败 --- %@",message);
                }];
                
                [self.stateButton setTitle:@"停止接单" forState:UIControlStateNormal];
                self.stateButton.backgroundColor = [UIColor grayColor];
                self.stateView.backgroundColor = [UIColor colorWithRed:210/255.0f green:210/255.0f blue:210/255.0f alpha:1];
               // [self.taskTableView reloadData];//此处不能刷新table，否则完成按钮颜色改变不了
            } Failure:^(NSURLSessionTask *task, NSString *message, NSString *status, NSString *url) {
                NSLog(@"message --- %@",message);
            }];
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
            if ([_userInfo.workStatus isEqualToString:@"2"])
            {
                NSLog(@"可以获取任务列表了");
                NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
                //获取任务列表
                [[NetworkRequestManager defaultManager] POST_Url:URI_WAITER_TaskAfterAccept Params:params withByUser:YES Success:^(NSURLSessionTask *task, id dataSource, NSString *message, NSString *url) {
                    NSLog(@"dataSource --- %@",dataSource);
                    [self.dataSource removeAllObjects];
                    [self.dataSource addObjectsFromArray:dataSource];
                    [JDMJRefreshManager headerWithRefreshingTarget:self refreshingAction:@selector(PullDownRefresh) view:self.taskTableView];
                    NSLog(@"%@",self.dataSource);
                    [self.taskTableView reloadData];
                } Failure:^(NSURLSessionTask *task, NSString *message, NSString *status, NSString *url) {
                    NSLog(@"message --- %@",message);
                }];
            }
            else
            {
                self.taskTableView.mj_header = nil;
                [self.dataSource removeAllObjects];
                [self.taskTableView reloadData];
            }
            [[DataBaseManager defaultInstance] saveContext];
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
        //获取服务员信息
        [[NetworkRequestManager defaultManager] POST_Url:URI_WAITER_WaiterInfoByWaiterId Params:nil withByUser:YES Success:^(NSURLSessionTask *task, id dataSource, NSString *message, NSString *url) {
            _userInfo = dataSource;
            [[DataBaseManager defaultInstance]saveContext];
            [self instantMessaging];
            NSLog(@"%@",_userInfo.workStatus);
            /* 0-挂起(默认); 1 任务中;2-待命 */
            if ([_userInfo.workStatus isEqualToString:@"0"])
            {
                self.stateButton.backgroundColor = [UIColor colorWithRed:42/255.0f green:160/255.0f blue:235/255.0f alpha:1];;
                [self.stateButton setTitle:@"开始接单" forState:UIControlStateNormal];
                self.isDown = NO;
                self.stateButton.enabled = YES;
                self.taskTableView.mj_header = nil;
                self.navigationItem.leftBarButtonItem.enabled = YES;
                [self.dataSource removeAllObjects];
                
            }else if ([_userInfo.workStatus isEqualToString:@"1"])
            {
                //获取任务信息(恢复任务）
                self.isDown = YES;
                [self.stateButton setTitle:@"停止接单" forState:UIControlStateNormal];
                self.tableTop.constant = 59.0f;
                self.serviceTimeView.hidden = NO;//显示服务时长的View
                self.ishiddenFoot = YES;//显示foot
                self.taskTableView.mj_header = nil;
                self.stateView.backgroundColor = [UIColor colorWithRed:137/255.0f green:137/255.0f blue:137/255.0f alpha:1];
                self.taskingLabel.text = @"进行中任务（1）";
                self.stateButton.backgroundColor = [UIColor colorWithRed:137/255.0f green:137/255.0f blue:137/255.0f alpha:1];
                self.stateButton.enabled = NO;
                self.navigationItem.leftBarButtonItem.enabled = NO;
                
                NSLog(@"任务进行中***********");
                NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
                [params setObject:@"1" forKey:@"taskStatus"];
                [[NetworkRequestManager defaultManager] POST_Url:URI_WAITER_GetTaskInfo Params:params withByUser:YES Success:^(NSURLSessionTask *task, id dataSource, NSString *message, NSString *url) {
                    NSLog(@"dataSource --- %@",dataSource);
                    [self.dataSource removeAllObjects];
                    [self.dataSource addObjectsFromArray:dataSource];
                    
                    NSLog(@"%@",self.dataSource);
                    [self.taskTableView reloadData];
                    
                } Failure:^(NSURLSessionTask *task, NSString *message, NSString *status, NSString *url) {
                    NSLog(@"message --- %@",message);
                }];
            }
            else
            {
                [JDMJRefreshManager headerWithRefreshingTarget:self refreshingAction:@selector(PullDownRefresh) view:self.taskTableView];
                [self.stateButton setTitle:@"停止接单" forState:UIControlStateNormal];
                self.stateButton.backgroundColor = [UIColor colorWithRed:242/255.0f green:69/255.0f blue:41/255.0f alpha:1];
                self.stateView.backgroundColor = [UIColor colorWithRed:210/255.0f green:210/255.0f blue:210/255.0f alpha:1];
                self.isDown = NO;
                self.tableTop.constant = 0.0f;
                self.ishiddenFoot = NO;//不显示foot
                [JDMJRefreshManager headerWithRefreshingTarget:self refreshingAction:@selector(PullDownRefresh) view:self.taskTableView];
                self.stateButton.enabled = YES;//开始接单
                self.navigationItem.leftBarButtonItem.enabled = YES;
                self.serviceTimeView.hidden = YES;//隐藏服务时长的View
                NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
                //获取任务列表
                [[NetworkRequestManager defaultManager] POST_Url:URI_WAITER_TaskAfterAccept Params:params withByUser:YES Success:^(NSURLSessionTask *task, id dataSource, NSString *message, NSString *url) {
                    NSLog(@"dataSource --- %@",dataSource);
                    [self.dataSource removeAllObjects];
                    [self.dataSource addObjectsFromArray:dataSource];
                    NSLog(@"%@",self.dataSource);
                    [self.taskTableView reloadData];
                } Failure:^(NSURLSessionTask *task, NSString *message, NSString *status, NSString *url) {
                    NSLog(@"message --- %@",message);
                }];
            }
            [self.taskTableView reloadData];
            
        } Failure:^(NSURLSessionTask *task, NSString *message, NSString *status, NSString *url) {
            NSLog(@"message --- %@",message);
        }];
        
        
    }
}

//时间戳转换成时间
- (NSString *)timeWithTimeIntervalString:(NSString *)timeString
{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy年MM月dd日 HH:mm:ss"];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]/ 1000.0];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}

//两个时间戳计算间隔
- (NSString*)compareTwoTime:(long long)time1 time2:(long long)time2
{
    NSTimeInterval balance = time2 /1000- time1 /1000;
    NSString*timeString = [[NSString alloc]init];
    NSInteger hour = ((int)balance)%(3600*24)/3600;
    NSInteger mint = ((int)balance)%(3600*24)%3600/60;
    NSInteger seconds = ((int)balance)%(3600*24)%3600%60;
    timeString = [NSString stringWithFormat:@"%02ld:%02ld:%02ld",(long)hour,(long)mint,(long)seconds];
    return timeString;
}

#pragma mark - 工作时长
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
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(workingTimeTimer) userInfo:nil repeats:YES];
}

- (void)workingTimeTimer{
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

#pragma mark - 服务时长
- (void)serverTime:(NSString *)dataStr
{
    if (dataStr != nil){
        NSMutableString * time=[[NSMutableString alloc]initWithString:dataStr];
        NSRange ange={0,2};
        _serviceHourString=[time substringWithRange:ange];//截取时
        NSRange ange1={3,2};
        _serviceMinuteString =[time substringWithRange:ange1];//截取分
        NSRange ange2={6,2};
        _serviceSecondString =[time substringWithRange:ange2];//截取秒
        self.serviceSecond = [self.serviceSecondString integerValue];
        self.serviceMinute = [self.serviceMinuteString integerValue];
        self.serviceHour   = [self.serviceHourString integerValue];
    }
    self.serviceTimeLabel.text = dataStr;
    [self.timer1 invalidate];
    self.timer1 = nil;
    self.timer1 = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(serverTimeTimer) userInfo:nil repeats:YES];
}

- (void)serverTimeTimer{
    self.serviceSecond++;
    if (self.serviceSecond==60){
        self.serviceSecond=00;
        self.serviceMinute++;
        if (self.serviceMinute==60) {
            self.serviceMinute=00;
            self.serviceHour++;
        }
    }
    self.serviceTimeLabel.text = [NSString stringWithFormat:@"%02ld:%02ld:%02ld",(long)self.serviceHour,(long)self.serviceMinute,(long)self.serviceSecond];
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

- (void)goChatImageAction:(UITapGestureRecognizer *)tap
{
    [self instantMessageingFormation];
}

// 即时通讯登录
- (void)instantMessaging
{
    if (self.userInfo.imAccount != nil && ![self.userInfo.imAccount isEqualToString:@""])
    {
        [[SPKitExample sharedInstance]callThisAfterISVAccountLoginSuccessWithYWLoginId:self.userInfo.imAccount passWord:@"sjlh2017" preloginedBlock:nil successBlock:^{
            NSLog(@"即时通讯登录成功");
        } failedBlock:^(NSError * error) {
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"通讯模块登录失败" message:@"请检查网络状态重新登录" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"重试" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self instantMessaging];
            }];
            [alert addAction:action1];
            [alert addAction:action2];
            [self presentViewController:alert animated:YES completion:nil];
        }];
    }
}

// 创建及时通讯界面
- (void)instantMessageingFormation
{
    YWPerson * person = [[YWPerson alloc]initWithPersonId:self.taskList.cImAccount appKey:@"23758144"];
    [[SPKitExample sharedInstance] exampleOpenConversationViewControllerWithPerson:person fromNavigationController:self.navigationController];
}

#pragma mark - MJRefresh
-(void)PullDownRefresh{
    [self updateDataWithRef:YES withByUser:NO];
}
-(void)updateDataWithRef:(BOOL)isRef withByUser:(BOOL)byUser
{
    NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
    //获取任务列表
    [[NetworkRequestManager defaultManager] POST_Url:URI_WAITER_TaskAfterAccept Params:params withByUser:YES Success:^(NSURLSessionTask *task, id dataSource, NSString *message, NSString *url) {
        NSLog(@"dataSource --- %@",dataSource);
        [self.dataSource removeAllObjects];
        [self.dataSource addObjectsFromArray:dataSource];
        NSLog(@"%@",self.dataSource);
        [self.taskTableView.mj_header endRefreshing];
        [self.taskTableView reloadData];
    } Failure:^(NSURLSessionTask *task, NSString *message, NSString *status, NSString *url) {
        NSLog(@"message --- %@",message);
    }];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
}


@end
