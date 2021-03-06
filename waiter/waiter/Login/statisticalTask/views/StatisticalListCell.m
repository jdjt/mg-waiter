//
//  StatisticalListCell.m
//  waiter
//
//  Created by new on 2017/4/14.
//  Copyright © 2017年 liuchao. All rights reserved.
//

#import "StatisticalListCell.h"

@implementation StatisticalListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.layer.masksToBounds = YES;
    self.selectionStyle =UITableViewCellSelectionStyleNone;
    
    if (IS_LESS5) {
        self.placeOrderTimeText.font = [UIFont systemFontOfSize:13];
        self.PlaceOrderTimeLable.font = self.orderTimeText.font = self.orderTimeLable.font = self.canceTimeLable.font = self.canceTimeContentLable.font = self.serviceTimeText.font = self.serviceTimeLable.font = self.guestNameLable.font = self.guseNameText.font = self.roomNumberLable.font = self.rootNumberText.font = self.areaLable.font = self.areaText.font = self.areaContentLable.font = self.areaContentText.font = [UIFont systemFontOfSize:13];
        self.chatRecordButton.titleLabel.font = [UIFont systemFontOfSize:13];
        self.chatButtonWidth.constant = 60;
    }
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setData:(TaskList *)model isSelectComplete:(NSInteger)isSelect{

    
    if (isSelect == 9) {
        //已取消
        self.evaluationLable.hidden = YES;
        self.customScoreView.hidden = YES;
        self.isScoreLable.hidden = YES;
        self.diverLineView.hidden = YES;
        self.triangleTop.constant = 17;
        self.dividerLine.constant = 17;
        self.canceTimeLable.text = @"取消时间";
        self.topButtonHeight.constant = 48;
        
    }
    if (model.isAnOpen)
        [self.triangleButton setImage:[UIImage imageNamed:@"equilateralTriangle"] forState:UIControlStateNormal];
    else
       [self.triangleButton setImage:[UIImage imageNamed:@"toTriangle"] forState:UIControlStateNormal];
    
    NSLog(@"-------  %@",model.scoreVal);
    if (isSelect == 8) {
        //已完成评星
        self.customScoreView.scoreValue = [model.scoreVal intValue];
        //完成时间
        self.canceTimeContentLable.text = [Util timeStampConversionStandardTime:model.confirmTime WithFormatter:nil];
        self.isScoreLable.text = @"待评价";
        if ([model.scoreVal intValue] > 0) {
            self.isScoreLable.text = @"已评价";
        }
        //服务时长
        self.serviceTimeLable.text = [Util timeStampsLongTime:model.produceTime nowTime:model.confirmTime];
    }else{
        //取消时间
        self.canceTimeContentLable.text = [Util timeStampConversionStandardTime:model.causeTime WithFormatter:nil];
        //服务时长
        self.serviceTimeLable.text = [Util timeStampsLongTime:model.produceTime nowTime:model.causeTime];
    }
    
    
    
     self.serialNumberLable.text = model.taskCode;
    if ([model.comeFrom isEqualToString:@"1"])
        self.orderFormLable.text = @"自主接单";
    else
        self.orderFormLable.text = @"管理员派单";
 
    //下单时间
    self.PlaceOrderTimeLable.text = [Util timeStampConversionStandardTime:model.produceTime WithFormatter:nil];
    //接单时间
    self.orderTimeLable.text = [Util timeStampConversionStandardTime:model.acceptTime WithFormatter:nil];
    //客人姓名
    self.guestNameLable.text = model.customerName;
    //房间号码
    #warning 无法判断哪个酒店
    self.roomNumberLable.text = model.customerRoomNum;
    //呼叫区域
    self.areaLable.text = model.areaName;
    //呼叫区域
    self.areaContentLable.text = model.taskContent;
    
    self.areaContentHeight.constant = model.callContentHeight;

}
@end
