//
//  FootCell.m
//  waiter
//
//  Created by sjlh on 2017/4/14.
//  Copyright © 2017年 liuchao. All rights reserved.
//

#import "FootCell.h"

@implementation FootCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.completeButton.layer.borderWidth = 0.3f;
    self.completeButton.layer.borderColor = [UIColor grayColor].CGColor;
    self.completeButton.layer.cornerRadius = 8.0f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
