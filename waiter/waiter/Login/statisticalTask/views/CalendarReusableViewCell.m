//
//  CalendarReusableViewCell.m
//  waiter
//
//  Created by new on 2017/4/14.
//  Copyright © 2017年 liuchao. All rights reserved.
//

#import "CalendarReusableViewCell.h"

@implementation CalendarReusableViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, kScreenWidth, frame.size.height)];
        self.dateLabel.textAlignment = NSTextAlignmentLeft;
        self.dateLabel.textColor = [UIColor blackColor];
        self.dateLabel.font = [UIFont boldSystemFontOfSize:18];
        self.dateLabel.backgroundColor = RGBA(255, 255, 255,1);
        [self addSubview:self.dateLabel];
        
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height - 1, kScreenWidth, 1)];
        view.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:view];
    }
    return self;
}
@end
