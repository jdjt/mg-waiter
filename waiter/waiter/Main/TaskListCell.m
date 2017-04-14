//
//  TaskListCell.m
//  waiter
//
//  Created by sjlh on 2017/4/13.
//  Copyright © 2017年 liuchao. All rights reserved.
//

#import "TaskListCell.h"

@implementation TaskListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.borderView.layer.borderWidth = 1;
    self.borderView.layer.borderColor = [UIColor grayColor].CGColor;
    self.borderView.layer.cornerRadius = 10.0f;
    
    self.pickSingleButton.layer.borderWidth = 0.3f;
    self.pickSingleButton.layer.borderColor = [UIColor grayColor].CGColor;
    self.pickSingleButton.layer.cornerRadius = 5.0f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
