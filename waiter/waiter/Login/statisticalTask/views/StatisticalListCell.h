//
//  StatisticalListCell.h
//  waiter
//
//  Created by new on 2017/4/14.
//  Copyright © 2017年 liuchao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomScoreView.h"
#import "TaskList+CoreDataClass.h"
@interface StatisticalListCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIButton *triangleButton;//三角

@property (weak, nonatomic) IBOutlet UILabel *evaluationLable;//评价

@property (weak, nonatomic) IBOutlet CustomScoreView *customScoreView;//评星

@property (weak, nonatomic) IBOutlet UILabel *isScoreLable;//已评价
@property (weak, nonatomic) IBOutlet UILabel *canceTimeLable;//取消时间文字

@property (weak, nonatomic) IBOutlet UILabel *serialNumberLable;//编号

@property (weak, nonatomic) IBOutlet UILabel *orderFormLable;//系统派单

@property (weak, nonatomic) IBOutlet UILabel *PlaceOrderTimeLable;//下单时间

@property (weak, nonatomic) IBOutlet UILabel *orderTimeLable;//接单时间


@property (weak, nonatomic) IBOutlet UILabel *canceTimeContentLable;//取消时间

@property (weak, nonatomic) IBOutlet UILabel *serviceTimeLable;//服务时长

@property (weak, nonatomic) IBOutlet UILabel *guestNameLable;//客人姓名
@property (weak, nonatomic) IBOutlet UILabel *roomNumberLable;//房间号码

@property (weak, nonatomic) IBOutlet UILabel *areaLable;//呼叫区域

@property (weak, nonatomic) IBOutlet UILabel *areaContentLable;//呼叫内容

@property (weak, nonatomic) IBOutlet UIButton *chatRecordButton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *areaContentHeight;
-(void)setData:(TaskList *)model isSelectComplete:(NSInteger)isSelect;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *triangleTop;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dividerLine;


@end
