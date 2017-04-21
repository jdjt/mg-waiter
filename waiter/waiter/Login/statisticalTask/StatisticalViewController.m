//
//  StatisticalViewController.m
//  waiter
//
//  Created by sjlh on 2017/4/13.
//  Copyright © 2017年 liuchao. All rights reserved.
//

#import "StatisticalViewController.h"
#import "StatisticalListCell.h"
#import "CalendarViewController.h"
#import "DataBaseManager+Category.h"
#import "JDMJRefreshManager.h"
@interface StatisticalViewController ()<CalendarDelegate>
// 日历所选择日期的字符串（xxxx-xx-xx）
@property(nonatomic,copy)NSString * selectDateString;
@property(nonatomic,assign)NSInteger isSelectComplete;//0已完成、1被取消
@property(nonatomic,assign)NSInteger isSelectSingle;//0全部、1自主，2系统
@property(nonatomic,strong)NSMutableArray * dataArray;
@end

@implementation StatisticalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUIandDataConfig];
    [self creatTableView];
    [self updateData];
    
    
//    DBDeviceInfo * deviceInfo = [[DataBaseManager defaultInstance] getDeviceInfo];
//    NSMutableDictionary * params = [[NSMutableDictionary alloc]init];
//    [params setObject:@"T001" forKey:@"empNo"];
//    [params setObject:@"123456" forKey:@"password"];
//    [params setObject:deviceInfo.deviceId forKey:@"deviceId"];
//    [params setObject:deviceInfo.deviceToken forKey:@"deviceToken"];
//    [params setObject:[NSNumber numberWithInt:2] forKey:@"deviceType"];
//    
//    [[NetworkRequestManager defaultManager] POST_Url:URI_WAITER_LOGIN Params:params withByUser:YES Success:^(NSURLSessionTask *task, id dataSource, NSString *message, NSString *url) {
//        NSLog(@"dataSource:----%@",dataSource);
//    } Failure:^(NSURLSessionTask *task, NSString *message, NSString *status, NSString *url) {
//        NSLog(@"message:----=== %@",message);
//    }];
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setUIandDataConfig{
    self.view.backgroundColor = RGBA(242, 242, 242, 1);
    self.isSelectComplete = 0;
    self.isSelectSingle = 0;
    self.aisArray = [NSArray arrayWithObjects:self.allButton, self.independentButton,self.systemButton,nil];
     [self completeCancelButtonUpdateLayer];
     [self allandIndependentandSystemButtonUpdateLayer];
    self.dataArray = [[NSMutableArray alloc]init];

}
-(void)updateViewConstraints{
    [super updateViewConstraints];
    [self.allButton.layer setBorderWidth:1];
    [self.independentButton.layer setBorderWidth:1];
    [self.systemButton.layer setBorderWidth:1];
    
    
}
- (IBAction)completeCancelButtonClick:(UIButton *)sender {
    if (sender.tag == 0) {
        if (self.isSelectComplete == 0) {
            return;
        }
        self.isSelectComplete = 0;
    }else{
        if (self.isSelectComplete == 1) {
            return;
        }
        self.isSelectComplete = 1;
    }
    [self completeCancelButtonUpdateLayer];
    [self.tableView reloadData];
}
-(void)completeCancelButtonUpdateLayer{
    if (self.isSelectComplete == 0) {
        self.completeButton.backgroundColor = RGBA(42, 160, 235, 1);
        self.cancelButton.backgroundColor = RGBA(137, 137, 137, 1);
    }else{
        self.cancelButton.backgroundColor = RGBA(42, 160, 235, 1);
        self.completeButton.backgroundColor = RGBA(137, 137, 137, 1);
    }

}
#pragma mark  全部、自主、系统按钮点击
- (IBAction)allandIndependentandSystemButtonClick:(UIButton *)sender {
    NSLog(@"%ld",(long)sender.tag);
    if (sender.tag == 0) {
        if (self.isSelectSingle == 0) {
            return;
        }
        self.isSelectSingle = 0;
    }else if(sender.tag == 1){
        if (self.isSelectSingle == 1) {
            return;
        }
        self.isSelectSingle = 1;
    }else{
    
        if (self.isSelectSingle == 2) {
            return;
        }
        self.isSelectSingle = 2;
    
    }
    
    [self allandIndependentandSystemButtonUpdateLayer];
}
-(void)allandIndependentandSystemButtonUpdateLayer{
     UIColor * boardColor = RGBA(208, 209, 213, 1);
    
    for (UIButton * button in self.aisArray) {
        if (button.tag == self.isSelectSingle) {
            button.backgroundColor = RGBA(42, 160, 235, 1);
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button.layer setBorderColor:self.allButton.backgroundColor.CGColor];
        }else{
            button.backgroundColor = [UIColor whiteColor];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button.layer setBorderColor:boardColor.CGColor];
        }
    }
}
-(void)updateData{
    TaskList * model =(TaskList *)  [[DataBaseManager defaultInstance] insertIntoCoreData:@"TaskList"];
    model.isAnOpen = NO;
    model.callContentHeight = 15;
    [self.dataArray addObject:model];
    
    TaskList * model2 =(TaskList *)  [[DataBaseManager defaultInstance] insertIntoCoreData:@"TaskList"];
    model2.isAnOpen = NO;
    model2.callContentHeight = 15;
    [self.dataArray addObject:model2];
    
    TaskList * model3 =(TaskList *)  [[DataBaseManager defaultInstance] insertIntoCoreData:@"TaskList"];
    model3.isAnOpen = NO;
    model3.callContentHeight = 15;
    [self.dataArray addObject:model3];
    [self.tableView reloadData];
    
    [self setOrderText:@"20" NoOrderText:@"20" SystemPushText:@"20" OrderRateText:@"20"];

}
#pragma mark 设置 接单、未接单、系统推送、接单率
-(void)setOrderText:(NSString *)orderText NoOrderText:(NSString *)noOrderText SystemPushText:(NSString *)systemText OrderRateText:(NSString *)orderRateText{
    
    self.orderLable.attributedText = [Util aVarietyOfColorFonts:[NSString stringWithFormat:@"接单任务数  %@条",orderText] WithComPer:orderText WithColor:[UIColor redColor]];
    self.noOrderLable.attributedText = [Util aVarietyOfColorFonts:[NSString stringWithFormat:@"未接单任务数  %@条",noOrderText] WithComPer:noOrderText WithColor:[UIColor redColor]];
    self.systemPushLable.attributedText = [Util aVarietyOfColorFonts:[NSString stringWithFormat:@"推送任务数  %@条",systemText] WithComPer:systemText WithColor:[UIColor redColor]];
    self.orderRateLable.attributedText = [Util aVarietyOfColorFonts:[NSString stringWithFormat:@"接单率  %@%@",orderRateText,@"%"] WithComPer:[NSString stringWithFormat:@"%@%@",orderRateText,@"%"] WithColor:[UIColor redColor]];
}
-(void)creatTableView{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = self.view.backgroundColor;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [JDMJRefreshManager headerWithRefreshingTarget:self refreshingAction:@selector(PullDownRefresh) view:self.tableView];
    [JDMJRefreshManager footWithRefreshingTarget:self refreshingAction:@selector(loadingMore) view:self.tableView];
    
}
#pragma mark - MJRefresh
-(void)PullDownRefresh{
    [self.tableView.mj_header endRefreshing];
    self.tableView.mj_footer.state = MJRefreshStateIdle;
}
-(void)loadingMore{
    [self.tableView.mj_footer endRefreshing];
    self.tableView.mj_footer.state = MJRefreshStateNoMoreData;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{    
    return 1;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    static NSString * footViewIndex = @"section";
    UITableViewHeaderFooterView * footView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:footViewIndex];
    if (footView == nil) {
        footView = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:footViewIndex];
        footView.contentView.backgroundColor = self.view.backgroundColor;
    }
    return footView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TaskList * listModel = self.dataArray[indexPath.section];
    
    if (listModel.isAnOpen) {
        NSInteger cellHeight = 263;
        if (self.isSelectComplete == 0)
        cellHeight = 280;
        return cellHeight + listModel.callContentHeight;
    }else{
    
        return self.isSelectComplete == 0 ? 65 : 48;
    }
 
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellIndex = @"cell";
    StatisticalListCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIndex];
    if (cell == nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"StatisticalListCell" owner:self options:nil].lastObject;
        [cell.chatRecordButton addTarget:self action:@selector(cellChatRecordButton:) forControlEvents:UIControlEventTouchUpInside];
        [cell.topButton addTarget:self action:@selector(topButtonAnClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    cell.topButton.tag = indexPath.section;
    cell.chatRecordButton.tag = indexPath.section;
     TaskList * listModel = self.dataArray[indexPath.section];
    [cell setData:listModel isSelectComplete:self.isSelectComplete];
    return cell;
}
-(void)topButtonAnClick:(UIButton *)button{
    TaskList * listModel = self.dataArray[button.tag];
    listModel.isAnOpen = !listModel.isAnOpen;
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:button.tag];
    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];

}
-(void)cellChatRecordButton:(UIButton *)button{
    NSLog(@"%ld",(long)button.tag);
    AlterViewController * alterVc = [AlterViewController alterViewOwner:self WithAlterViewStype:AlterViewGuestGiveUp WithMessageCount:nil WithAlterViewBlock:^(UIButton *button, NSInteger buttonIndex) {
        
    }];
    
    [self presentViewController:alterVc animated:NO completion:nil];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"calendarShow"]) {
        CalendarViewController * vc = segue.destinationViewController;
        vc.delegate = self;
        vc.selectDateString = self.selectDateString;
    }
}
#pragma mark - 统计选择日期——delegate
-(void)calendarSelectDateString:(NSString *)dateString{

    NSLog(@"%@",dateString);
    self.selectDateString = dateString;
    self.timeLable.text = [NSString stringWithFormat:@"日期  %@",self.selectDateString];
    
}

@end
