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

    if (isSelect == 1) {
        self.evaluationLable.hidden = YES;
        self.customScoreView.hidden = YES;
        self.isScoreLable.hidden = YES;
        self.diverLineView.hidden = YES;
        self.triangleTop.constant = 17;
        self.dividerLine.constant = 17;
        self.canceTimeLable.text = @"取消时间";
        
    }
    

}
@end
