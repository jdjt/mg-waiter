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
@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource,FMKLocationServiceManagerDelegate>

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
@property (weak, nonatomic) IBOutlet UILabel *messageCountLabel;

@property (strong, nonatomic) DBWaiterInfo * userInfo;
@property (strong, nonatomic) TaskList * taskList;
@property (strong, nonatomic) NSMutableArray * dataSource;
@property (nonatomic, strong) YWConversation * conversation;
@property (nonatomic, assign)BOOL isDown;

// 地图GPS相关
@property (strong, nonatomic) NSTimer * gpsTimer;
@property (strong, nonatomic) NSMutableDictionary * gpsParams;
@property (strong, nonatomic) FMZoneManager * myZoneManager;
@property (assign, nonatomic) int uploadPerSecond;
@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.uploadPerSecond = 0;
    
    self.ishiddenFoot = NO;
    self.serviceTimeView.hidden = YES;
    self.tableTop.constant = 0.0f;

    self.stateButton.layer.cornerRadius = 5;
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.messageCountLabel.layer.cornerRadius = 10.0f;
    self.messageCountLabel.layer.masksToBounds = YES;
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goMapImageAction:)];
    [self.goMapImage addGestureRecognizer:tap];
    UITapGestureRecognizer * chatTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goChatImageAction:)];
    [self.goChatImage addGestureRecognizer:chatTap];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushTypeAction:) name:WAITER_RECEIVED_PUSH object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goMapView:) name:@"goMapView" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(newMessage:) name:@"NotiNewIMMessage" object:nil];
    
    self.dataSource = [[NSMutableArray alloc]initWithCapacity:10];

//    [_timer1 setFireDate:[NSDate date]];//开始 .备用
    
    if (IS_LESS5){
        self.workTimeViewHeight.constant = 45;
        self.grayLeineViewTop.constant = 45;
        self.empNoTop.constant = 10;
        self.nameTop.constant = 10;
        self.depNameTop.constant = 10;
        self.headViewHeight.constant = 200;
        self.stateViewHeight.constant = 40;
        self.serviceTimeViewHeight.constant = 40;
        self.tableTop.constant = 54;
        self.stateButtonWidth.constant = 110;
        self.stateButtonHeight.constant = 40;
        self.footcCell.completeButtonHeight.constant = 44;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.userInfo = [[DataBaseManager defaultInstance]getWaiterInfo:nil];
    NSLog(@"time : %@",self.userInfo.workTimeCal);
    self.empNoLabel.text = self.userInfo.empNo;
    self.nameLabel.text = self.userInfo.name;
    self.depNameLabel.text = [NSString stringWithFormat:@"%@ - %@",self.userInfo.parentDepName, self.userInfo.depName];
    [self workingTime];
    if (self.conversation.conversationUnreadMessagesCount.integerValue == 0)
        self.messageCountLabel.hidden = YES;
    [self NET_attendStatus];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

#pragma mark - NSNotification

-  (void)newMessage:(NSNotification *)noti
{
    if (self.conversation)
    {
        self.messageCountLabel.text = [NSString stringWithFormat:@"%@",self.conversation.conversationUnreadMessagesCount];
        if (self.conversation.conversationUnreadMessagesCount.integerValue != 0)
            self.messageCountLabel.hidden = NO;
    }
}

#pragma mark - tableview代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"%ld",(unsigned long)self.dataSource.count);
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
    _taskListCell.roomNumber.text = self.taskList.customerRoomNum;
    _taskListCell.callArea.text = self.taskList.areaName;
    _taskListCell.callContent.text = self.taskList.taskContent;
    _taskListCell.orderTime.text = [self timeWithTimeIntervalString:self.taskList.produceTime BOOL:1];
    _taskListCell.pickSingleButton.tag = indexPath.row;
    NSLog(@"%@",self.taskList.taskStatus);
    
    //服务时长,计算下单时间和系统时间的时间间隔
    NSInteger intData = [self.taskList.nowDate longLongValue] - [self.taskList.acceptTime longLongValue];
    [self serverTime:intData/1000];
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
        [AlterViewController alterViewOwner:self WithAlterViewStype:AlterViewServiceStop WithMessageCount:nil WithAlterViewBlock:^(UIButton *button, NSInteger buttonIndex) {
            if (buttonIndex == 1)
            {
                UIColor * color = [UIColor colorWithRed:42/255.0f green:160/255.0f blue:235/255.0f alpha:1];
                [self changeWaiterStatus:@"2" statusName:@"开始接单" color:color];
            }
        }];
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
                
                //获取任务信息
                [self Net_CodeGetTaskInfo];
                
            } Failure:^(NSURLSessionTask *task, NSString *message, NSString *status, NSString *url) {
                NSLog(@"抢单失败 --- %@",message);
                UIAlertController * alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [self NET_attendStatus];
                }];
                [alert addAction:action];
                [self presentViewController:alert animated:YES completion:nil];
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
            
            [[NetworkRequestManager defaultManager] POST_Url:URI_WAITER_ConfirmTask Params:params withByUser:YES Success:^(NSURLSessionTask *task, id dataSource, NSString *message, NSString *url)
            {
                NSLog(@"dataSource --- %@",dataSource);
                
                _footcCell.completeButton.backgroundColor = [UIColor grayColor];
                _footcCell.completeButton.enabled = NO;
                //服务时长暂停计时
//                [_timer1 setFireDate:[NSDate distantFuture]];//备用

                [self NET_attendStatus];
                
                [self.stateButton setTitle:@"停止接单" forState:UIControlStateNormal];
                self.stateButton.backgroundColor = [UIColor grayColor];
                self.stateView.backgroundColor = [UIColor colorWithRed:137/255.0f green:137/255.0f blue:137/255.0f alpha:1];
               // [self.taskTableView reloadData];//此处不能刷新table，否则完成按钮颜色改变不了
            } Failure:^(NSURLSessionTask *task, NSString *message, NSString *status, NSString *url)
            {
                NSLog(@"message --- %@",message);
                [MySingleton systemAlterViewOwner:self WithMessage:message];
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
                [[SPKitExample sharedInstance] exampleLogout];
                [self performSegueWithIdentifier:@"goLogin" sender:nil];
            } Failure:^(NSURLSessionTask *task, NSString *message, NSString *status, NSString *url) {
                NSLog(@"message --- %@",message);
                [MySingleton systemAlterViewOwner:self WithMessage:message];
            }];
        }
    }];
}

#pragma mark - 方法
//切换开始接单、停止接单
- (void)changeWaiterStatus:(NSString *)waiterStatus statusName:(NSString *)statusName color:(UIColor *)color
{
    NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
    [params setObject:waiterStatus forKey:@"workStatus"];
    
    
    //切换服务员状态
    [[NetworkRequestManager defaultManager] POST_Url:URI_WAITER_SetWorkStatus Params:params withByUser:NO Success:^(NSURLSessionTask *task, id dataSource, NSString *message, NSString *url) {
//        //获取服务员信息
//        [[NetworkRequestManager defaultManager] POST_Url:URI_WAITER_WaiterInfoByWaiterId Params:nil withByUser:YES Success:^(NSURLSessionTask *task, id dataSource, NSString *message, NSString *url) {
//            _userInfo = dataSource;
//            if ([_userInfo.workStatus isEqualToString:@"2"])
//            {
//                NSLog(@"可以获取任务列表了");
//                //获取任务列表
//                [self Net_taskInfoList];
//            }
//            else
//            {
//                self.taskTableView.mj_header = nil;
//                [self.dataSource removeAllObjects];
//                [self.taskTableView reloadData];
//            }
//            [[DataBaseManager defaultInstance] saveContext];
//            self.stateButton.backgroundColor = color;
//            [self.stateButton setTitle:statusName forState:UIControlStateNormal];
//        } Failure:^(NSURLSessionTask *task, NSString *message, NSString *status, NSString *url) {
//            NSLog(@"message --- %@",message);
//            if ([message isEqualToString:@"查不到此服务员信息"])
//                [self performSegueWithIdentifier:@"goLogin" sender:nil];
//        }];
        [self NET_attendStatus];
    } Failure:^(NSURLSessionTask *task, NSString *message, NSString *status, NSString *url) {
        NSLog(@"message --- %@",message);
        [MySingleton systemAlterViewOwner:self WithMessage:message];
    }];
}

// 任务流程结束后重置conversation和消息数label
- (void)resetConversationAndNewMessage
{
    [self.conversation markConversationAsRead];
    self.messageCountLabel.hidden = YES;
}

//检查上班状态 是否上班
- (void)NET_attendStatus
{
    NSLog(@"%@",self.userInfo.attendStatus);
    if ([self.userInfo.attendStatus isEqualToString:@"0"] || self.userInfo.attendStatus == nil || [self.userInfo.resetPwdDiv isEqualToString:@"0"])
    {
        [self performSegueWithIdentifier:@"goLogin" sender:nil];
    }
    else
    {
        //获取服务员信息
        [[NetworkRequestManager defaultManager] POST_Url:URI_WAITER_WaiterInfoByWaiterId Params:nil withByUser:YES Success:^(NSURLSessionTask *task, id dataSource, NSString *message, NSString *url) {
            _userInfo = dataSource;
            [[DataBaseManager defaultInstance]saveContext];
            [self getMacAndStartLocationService];
            [self instantMessaging];
            NSLog(@"%@",_userInfo.workStatus);
            /* 0-挂起(默认); 1 任务中;2-待命 */
            if ([_userInfo.workStatus isEqualToString:@"0"])
            {
                self.stateButton.backgroundColor = [UIColor colorWithRed:42/255.0f green:160/255.0f blue:235/255.0f alpha:1];;
                [self.stateButton setTitle:@"开始接单" forState:UIControlStateNormal];
                self.isDown = NO;
                self.stateButton.enabled = YES;
                self.ishiddenFoot = NO;//隐藏foot
                self.serviceTimeView.hidden = YES;//隐藏服务时长的View
                self.taskTableView.mj_header = nil;
                self.taskingLabel.text = @"进行中任务（0）";
                self.navigationItem.leftBarButtonItem.enabled = YES;
                [self.dataSource removeAllObjects];
                [self resetConversationAndNewMessage];
                
            }else if ([_userInfo.workStatus isEqualToString:@"1"])
            {
                //获取任务信息(恢复任务）
                NSLog(@"任务进行中***********");
                [self Net_Tasking];
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
                self.taskingLabel.text = @"进行中任务（0）";
                [_timer2 setFireDate:[NSDate distantFuture]];
                self.stateButton.enabled = YES;//开始接单
                self.navigationItem.leftBarButtonItem.enabled = YES;
                self.serviceTimeView.hidden = YES;//隐藏服务时长的View
                [self resetConversationAndNewMessage];
                //获取任务列表
                [self Net_taskInfoList];
            }
            [self.taskTableView reloadData];
            
        } Failure:^(NSURLSessionTask *task, NSString *message, NSString *status, NSString *url) {
            NSLog(@"message --- %@",message);
            if ([message isEqualToString:@"查不到此服务员信息"])
                [self performSegueWithIdentifier:@"goLogin" sender:nil];
            
            [MySingleton systemAlterViewOwner:self WithMessage:message];
        }];
        
        
    }
}

//通过任务号获取任务信息
- (void)Net_CodeGetTaskInfo
{
    NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
    [params setObject:self.taskList.taskCode forKey:@"taskCode"];
    [[NetworkRequestManager defaultManager] POST_Url:URI_WAITER_GetTaskInfoByTaskCode Params:params withByUser:YES Success:^(NSURLSessionTask *task, id dataSource, NSString *message, NSString *url) {
        NSLog(@"服务员根据任务号获取任务信息成功 --- %@",dataSource);
        self.isDown = YES;
        [self.dataSource removeAllObjects];
        [self.dataSource addObject:dataSource];
        NSLog(@"%ld",self.dataSource.count);
        
        if (dataSource != nil)
        {
            self.taskList = dataSource;
            self.conversation = [YWP2PConversation fetchConversationByPerson:[[YWPerson alloc]initWithPersonId:self.taskList.cImAccount appKey:@"23758144"] creatIfNotExist:YES baseContext:[SPKitExample sharedInstance].ywIMKit.IMCore];
            self.messageCountLabel.text = [NSString stringWithFormat:@"%@",self.conversation.conversationUnreadMessagesCount];
            if (self.conversation.conversationUnreadMessagesCount.integerValue != 0)
                self.messageCountLabel.hidden = NO;
            //只能发一次默认消息
            [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"isFirstMessage"];
            [self.conversation asyncSendMessageBody:[[YWMessageBodyText alloc] initWithMessageText:[NSString stringWithFormat:@"您好，我是服务员%@，很高兴为您服务！",self.userInfo.name]] controlParameters:nil progress:nil completion:nil];
        }
        
        if (IS_LESS5) {
            self.tableTop.constant = 54;
        }
        else
        {
            self.tableTop.constant = 59.0f;
        }
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
        [MySingleton systemAlterViewOwner:self WithMessage:message];
    }];
}

//进行中的任务
- (void)Net_Tasking
{
    NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
    [params setObject:@"1" forKey:@"taskStatus"];
    [[NetworkRequestManager defaultManager] POST_Url:URI_WAITER_GetTaskInfo Params:params withByUser:YES Success:^(NSURLSessionTask *task, id dataSource, NSString *message, NSString *url) {
        NSLog(@"dataSource --- %@",dataSource);
        [self.dataSource removeAllObjects];
        [self.dataSource addObjectsFromArray:dataSource];
        
        if ([(NSArray *)dataSource count] > 0)
        {
            self.isDown = YES;
            [self.stateButton setTitle:@"停止接单" forState:UIControlStateNormal];
            if (IS_LESS5) {
                self.tableTop.constant = 54;
            }
            else
            {
                self.tableTop.constant = 59.0f;
            }
            self.serviceTimeView.hidden = NO;//显示服务时长的View
            self.ishiddenFoot = YES;//显示foot
            self.taskTableView.mj_header = nil;
            self.stateView.backgroundColor = [UIColor colorWithRed:137/255.0f green:137/255.0f blue:137/255.0f alpha:1];
            self.taskingLabel.text = @"进行中任务（1）";
            self.stateButton.backgroundColor = [UIColor colorWithRed:137/255.0f green:137/255.0f blue:137/255.0f alpha:1];
            self.stateButton.enabled = NO;
            self.navigationItem.leftBarButtonItem.enabled = NO;
            
            self.taskList = [dataSource lastObject];
            self.conversation = [YWP2PConversation fetchConversationByPerson:[[YWPerson alloc]initWithPersonId:self.taskList.cImAccount appKey:@"23758144"] creatIfNotExist:YES baseContext:[SPKitExample sharedInstance].ywIMKit.IMCore];
            self.messageCountLabel.text = [NSString stringWithFormat:@"%@",self.conversation.conversationUnreadMessagesCount];
            if (self.conversation.conversationUnreadMessagesCount.integerValue != 0)
                self.messageCountLabel.hidden = NO;
            //只能发一次默认消息
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"isFirstMessage"] isEqualToString:@"0"])
            {
                [self.conversation asyncSendMessageBody:[[YWMessageBodyText alloc] initWithMessageText:[NSString stringWithFormat:@"您好，我是服务员%@，很高兴为您服务！",self.userInfo.name]] controlParameters:nil progress:nil completion:nil];
                [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"isFirstMessage"];
            }
        }
        else
        {
            self.stateButton.backgroundColor = [UIColor colorWithRed:42/255.0f green:160/255.0f blue:235/255.0f alpha:1];;
            [self.stateButton setTitle:@"开始接单" forState:UIControlStateNormal];
            self.isDown = NO;
            self.stateButton.enabled = YES;
            self.ishiddenFoot = NO;//隐藏foot
            self.serviceTimeView.hidden = YES;//隐藏服务时长的View
            self.taskTableView.mj_header = nil;
            self.taskingLabel.text = @"进行中任务（0）";
            self.navigationItem.leftBarButtonItem.enabled = YES;
            [self.dataSource removeAllObjects];
            [self resetConversationAndNewMessage];
        }
        NSLog(@"%@",self.dataSource);
        NSLog(@"完成时间%@",[self timeWithTimeIntervalString:self.taskList.finishTime BOOL:0]);//13:32:59
        NSLog(@"%@,%@",self.taskList.finishTime,self.taskList.nowDate);
        NSLog(@"%@",self.taskList.taskStatus);
        //客人确认：不认可
        if ([self.taskList.taskStatus isEqualToString:@"7"] || [self.taskList.taskStatus isEqualToString:@"1"])
        {
            self.taskingLabel.text = @"进行中任务(1)";
            [_timer2 setFireDate:[NSDate distantFuture]];
            [self.taskTableView reloadData];
            return ;
        }
        double strData = ([self.taskList.nowDate longLongValue] - [self.taskList.finishTime longLongValue])/1000;
        [self completeCountdownTime:strData];
        [self.taskTableView reloadData];
        
    } Failure:^(NSURLSessionTask *task, NSString *message, NSString *status, NSString *url) {
        NSLog(@"message --- %@",message);
        [MySingleton systemAlterViewOwner:self WithMessage:message];
    }];
}

//时间戳转换成时间
- (NSString *)timeWithTimeIntervalString:(NSString *)timeString BOOL:(BOOL)isYMD
{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    if (isYMD == 1)
        [formatter setDateFormat:@"yyyy年MM月dd日 HH:mm:ss"];
    else
        [formatter setDateFormat:@"HH:mm:ss"];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]/ 1000.0];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}

#warning 此处有蹊跷。回去自己改
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

#pragma mark - 通知
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
        if ([self.userInfo.workStatus isEqualToString:@"2"])
        {
            [self Net_taskInfoList];
        }
    }
    if ([CusCancelTask isEqualToString:[dic objectForKey:@"messType"]])
    {
        NSLog(@"客人取消任务");
        [self NET_attendStatus];
        [self.navigationController popToRootViewControllerAnimated:YES];
        [AlterViewController alterViewOwner:self WithAlterViewStype:AlterViewGuestCancel WithMessageCount:nil WithAlterViewBlock:^(UIButton *button, NSInteger buttonIndex) {
        }];
    }
    if ([CusConfirmTaskComplete isEqualToString:[dic objectForKey:@"messType"]])
    {
        NSLog(@"客人确认，完成");
        [self NET_attendStatus];
        [self.navigationController popToRootViewControllerAnimated:YES];
        [AlterViewController alterViewOwner:self WithAlterViewStype:AlterViewGuestComplete WithMessageCount:nil WithAlterViewBlock:^(UIButton *button, NSInteger buttonIndex) {
        }];
    }
    if ([CusConfirmTaskUnComplete isEqualToString:[dic objectForKey:@"messType"]])
    {
        NSLog(@"客人确认，未完成");
        [self NET_attendStatus];
        [AlterViewController alterViewOwner:self WithAlterViewStype:AlterViewGuestUnfinished WithMessageCount:nil WithAlterViewBlock:^(UIButton *button, NSInteger buttonIndex) {
        }];
    }
    
    if ([SystemAutoConfirmTaskToWaiter isEqualToString:[dic objectForKey:@"messType"]])
    {
        NSLog(@"30分钟客人没点认可和不认可时的推送");
        [self NET_attendStatus];
        [AlterViewController alterViewOwner:self WithAlterViewStype:AlterViewGuestGiveUp WithMessageCount:nil WithAlterViewBlock:^(UIButton *button, NSInteger buttonIndex) {
        }];
    }
    if ([ManagerSendTask isEqualToString:[dic objectForKey:@"messType"]])
    {
        NSLog(@"管理员派单");
        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"isFirstMessage"];
        [self NET_attendStatus];
        [AlterViewController alterViewOwner:self WithAlterViewStype:AlterViewAdminSendSingle WithMessageCount:nil WithAlterViewBlock:^(UIButton *button, NSInteger buttonIndex) {
        }];
    }
    if ([ManagerRemindeTask isEqualToString:[dic objectForKey:@"messType"]])
    {
        NSLog(@"管理员催单");
        [AlterViewController alterViewOwner:self WithAlterViewStype:AlterViewAdminReminder WithMessageCount:[dic objectForKey:@"count"] WithAlterViewBlock:^(UIButton *button, NSInteger buttonIndex) {
            
        }];
    }
    if ([startAPP isEqualToString:[dic objectForKey:@"messType"]])
    {
        NSLog(@"启动app");
        [self NET_attendStatus];
    }
    
}

- (void)goMapView:(NSNotification *)noti
{
    [self goMapViewController];
}

#pragma mark - 获取任务列表

- (void)Net_taskInfoList
{
    //获取任务列表
    [[NetworkRequestManager defaultManager] POST_Url:URI_WAITER_TaskAfterAccept Params:nil withByUser:YES Success:^(NSURLSessionTask *task, id dataSource, NSString *message, NSString *url) {
        NSLog(@"dataSource --- %@",dataSource);
        [self.dataSource removeAllObjects];
        [self.dataSource addObjectsFromArray:dataSource];
        [JDMJRefreshManager headerWithRefreshingTarget:self refreshingAction:@selector(PullDownRefresh) view:self.taskTableView];
        NSLog(@"%@",self.dataSource);
        [self.taskTableView reloadData];
    } Failure:^(NSURLSessionTask *task, NSString *message, NSString *status, NSString *url) {
        NSLog(@"message --- %@",message);
        [MySingleton systemAlterViewOwner:self WithMessage:message];
    }];
}

#pragma mark - 工作时长

- (void)workingTime
{
    if (self.userInfo.workTimeCal != nil){
        NSLog(@"%@",self.userInfo.workTimeCal);//00：00：00
        self.second = [Util stringFormattedSeconds:self.userInfo.workTimeCal];
        self.workTimeCalLabel.text = [Util timeFormatted:(int)self.second];
        [self.timer invalidate];
        self.timer = nil;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(workingTimeTimer) userInfo:nil repeats:YES];
   }
}

- (void)workingTimeTimer
{
    self.second++;
    self.workTimeCalLabel.text = [Util timeFormatted:(int)self.second];
    self.userInfo.workTimeCal = self.workTimeCalLabel.text;
}

#pragma mark - 服务时长
- (void)serverTime:(NSInteger )dataStr
{
    if (dataStr >= 0){
        self.serviceSecond = dataStr;
        self.serviceTimeLabel.text = [Util timeFormatted:(int)self.serviceSecond];
        [self.timer1 invalidate];
        self.timer1 = nil;
        self.timer1 = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(serverTimeTimer) userInfo:nil repeats:YES];
    }
}

- (void)serverTimeTimer
{
    self.serviceSecond++;
    self.serviceTimeLabel.text = [Util timeFormatted:(int)self.serviceSecond];
}

#pragma mark - 完成服务 倒计时
- (void)completeCountdownTime:(double)strDataSum
{
    self.completeSecond = 1800 - strDataSum;
    if (self.completeSecond >= 0) {
        self.taskingLabel.text = [NSString stringWithFormat:@"完成待确认(%02ld:%02ld)",self.completeSecond/60,self.completeSecond%60];
        [self.timer2 invalidate];
        self.timer2 = nil;
        self.timer2 = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(completeTimeTimer) userInfo:nil repeats:YES];
    }
}

- (void)completeTimeTimer
{
    self.completeSecond--;
    if (self.completeSecond < 0) {
        [_timer2 setFireDate:[NSDate distantFuture]];
        return;
    }
    self.taskingLabel.text = [NSString stringWithFormat:@"完成待确认(%02ld:%02ld)",self.completeSecond/60,self.completeSecond%60];
}

#pragma mark - ------

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)goMapImageAction:(UITapGestureRecognizer *)tap
{
    [self goMapViewController];
}

- (void)goMapViewController
{
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    self.navigationItem.backBarButtonItem = barButtonItem;
    MapViewController *map = [[MapViewController alloc] init];
    map.title = @"进行中的任务";
    map.mainVC = self;
    map.currentTask = self.taskList;
    [self.navigationController pushViewController:map animated:YES];
}

- (void)goChatImageAction:(UITapGestureRecognizer *)tap
{
    [self instantMessageingFormation];
}

// 即时通讯登录
- (void)instantMessaging
{
    NSLog(@"%@",self.userInfo.imAccount);
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
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    self.navigationItem.backBarButtonItem = barButtonItem;
    YWPerson * person = [[YWPerson alloc]initWithPersonId:self.taskList.cImAccount appKey:@"23758144"];
    [[SPKitExample sharedInstance] exampleOpenConversationViewControllerWithPerson:person fromNavigationController:self.navigationController];
}

#pragma mark - MJRefresh
-(void)PullDownRefresh
{
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
        [self.taskTableView.mj_header endRefreshing];
        [MySingleton systemAlterViewOwner:self WithMessage:message];
        NSLog(@"message --- %@",message);
    }];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"goCalendar"]) {
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    }
}

//获取MAC地址并且开启定位服务
- (void)getMacAndStartLocationService
{
    NSString *_mapPath = [[NSBundle mainBundle] pathForResource:@"79980.fmap" ofType:nil];
    __block NSString *macAddress;
    FMKLocationServiceManager * locationManager = [FMKLocationServiceManager shareLocationServiceManager];
    locationManager.delegate = self;
    macAddress = [[DataBaseManager defaultInstance] getDeviceInfo].deviceId;
    if (!macAddress || [macAddress isEqualToString:@""] ||[macAddress rangeOfString:@":"].location == NSNotFound)
    {
        [[FMDHCPNetService shareDHCPNetService] localMacAddress:^(NSString *macAddr)
         {
             if (macAddr != nil && ![macAddr isEqualToString:@""])
             {
                 macAddress = macAddr;
             }
             dispatch_async(dispatch_get_main_queue(), ^{
                 [locationManager startLocateWithMacAddress:macAddress mapPath:_mapPath];
             });
         }];
    }else
    {
        [locationManager startLocateWithMacAddress:macAddress mapPath:_mapPath];
    }
}

-(void)startNSTimer
{

    if (!self.gpsTimer) {
        NSTimeInterval tr = [self.userInfo.uploadPerSecond doubleValue];
        if (tr < 1) tr = 10;
        self.gpsTimer = [NSTimer timerWithTimeInterval:tr target:self selector:@selector(locationInformation) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer: self.gpsTimer forMode:NSDefaultRunLoopMode];
    }
}

-(NSMutableDictionary *)gpsParams
{
    if (_gpsParams == nil) {
        _gpsParams = [[NSMutableDictionary alloc]init];
    }
    return _gpsParams;
}
/**
 位置回调
 
 @param mapCoord 位置
 */
- (void)didUpdatePosition:(FMKMapCoord)mapCoord success:(BOOL)success
{
    
    NSLog(@"——————————————————————%d",self.uploadPerSecond);
    
    if (self.uploadPerSecond == [self.userInfo.uploadPerSecond intValue])
    {
        [self.gpsParams setValue:[NSString stringWithFormat:@"%d",mapCoord.coord.storey] forKey:@"floorNo"];
        [self.gpsParams setValue:[NSString stringWithFormat:@"%d",mapCoord.mapID] forKey:@"mapNo"];
        [self.gpsParams setValue:[NSString stringWithFormat:@"%f",mapCoord.coord.mapPoint.x] forKey:@"positionX"];
        [self.gpsParams setValue:[NSString stringWithFormat:@"%f",mapCoord.coord.mapPoint.y] forKey:@"positionY"];
        [self.gpsParams setValue:[NSString stringWithFormat:@"%d",mapCoord.coord.storey] forKey:@"positionZ"];
        
        [self locationInformation];
        
    }else if (self.uploadPerSecond > [self.userInfo.uploadPerSecond intValue])
    {
        self.uploadPerSecond = 0;
    }
    self.uploadPerSecond++;

}
- (FMZoneManager *)myZoneManager{
    if (!_myZoneManager){
        _myZoneManager = [[FMZoneManager alloc] initWithMangroveMapView:nil];
    }
    return _myZoneManager;
}
-(void)locationInformation{
    [self.gpsParams setValue:@"2" forKey:@"hotelCode"];
    
    [self.gpsParams setValue:[self.myZoneManager getCurrentZone].zone_name forKey:@"areaName"];
    [self.gpsParams setValue:@"大堂后院" forKey:@"areaName"];
    //服务器说不需要传--areaCode--
    //[self.gpsParams setValue:[self.myZoneManager getCurrentZone].zone_code forKey:@"areaCode"];
    if (!self.userInfo) return;
    
    [[NetworkRequestManager defaultManager] POST_Url:URI_WAITER_UpdateMapInfo Params:self.gpsParams withByUser:NO Success:^(NSURLSessionTask *task, id dataSource, NSString *message, NSString *url) {
        NSLog(@"上传位置----Success-----%@",message);
    } Failure:^(NSURLSessionTask *task, NSString *message, NSString *status, NSString *url) {
        NSLog(@"上传位置----Failure-----%@",message);
    }];
}


@end
