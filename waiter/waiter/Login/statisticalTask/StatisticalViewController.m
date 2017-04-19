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
@interface StatisticalViewController ()<CalendarDelegate>
// 日历所选择日期的字符串（xxxx-xx-xx）
@property(nonatomic,copy)NSString * selectDateString;
@property(nonatomic,strong)NSMutableArray * dataArray;
@end

@implementation StatisticalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    
    self.dataArray = [[NSMutableArray alloc]init];
  TaskList * model =(TaskList *)  [[DataBaseManager defaultInstance] insertIntoCoreData:@"TaskList"];
    model.isAnOpen = NO;
    [self.dataArray addObject:model];
    
    TaskList * model2 =(TaskList *)  [[DataBaseManager defaultInstance] insertIntoCoreData:@"TaskList"];
    model2.isAnOpen = NO;
    [self.dataArray addObject:model2];
    
    
    TaskList * model3 =(TaskList *)  [[DataBaseManager defaultInstance] insertIntoCoreData:@"TaskList"];
    model3.isAnOpen = NO;
    [self.dataArray addObject:model3];
    
    [self.tableView reloadData];
}
-(void)load{

   


}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
    return view;    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TaskList * listModel = self.dataArray[indexPath.section];
    if (listModel.isAnOpen) {
        return 80;
    }else{
    
        return 200;
    }

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellIndex = @"cell";
    StatisticalListCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIndex];
    if (cell == nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"StatisticalListCell" owner:self options:nil].lastObject;
        
    }

    cell.layer.masksToBounds = YES;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    TaskList * listModel = self.dataArray[indexPath.section];
    listModel.isAnOpen = !listModel.isAnOpen;
    
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:indexPath.section];
    [tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
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
    
}

@end
