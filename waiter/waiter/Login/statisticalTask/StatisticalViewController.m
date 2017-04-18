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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellIndex = @"cell";
    StatisticalListCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIndex];
    if (cell == nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"StatisticalListCell" owner:self options:nil].lastObject;
        
    }
    
    // Configure the cell...
    
    return cell;
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
