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
        self.triangleTop.constant = 17;
        self.dividerLine.constant = 17;
        
    }


}
@end
