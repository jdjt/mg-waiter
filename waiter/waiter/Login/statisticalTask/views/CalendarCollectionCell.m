//
//  CalendarCollectionCell.m
//  waiter
//
//  Created by new on 2017/4/14.
//  Copyright © 2017年 liuchao. All rights reserved.
//

#import "CalendarCollectionCell.h"

@implementation CalendarCollectionCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.dateLabel = [[UILabel  alloc] initWithFrame:CGRectMake(0, 0, self.width, self.width)];
        self.dateLabel.textAlignment = NSTextAlignmentCenter;
        self.dateLabel.backgroundColor = [UIColor clearColor];
        self.dateLabel.font = [UIFont systemFontOfSize:18];
        [self addSubview:self.dateLabel];
        
    }
    return self;
}
-(void)setIsSelect:(BOOL)isSelect{
    _isSelect = isSelect;
    
    if (isSelect) {
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = (kScreenWidth / 7) / 2;
        self.backgroundColor =  RGBA(65, 207, 79, 1);
    }else{
        self.layer.masksToBounds = NO;
        self.layer.cornerRadius = (kScreenWidth / 7);
        self.backgroundColor =  [UIColor clearColor];
    }

}
@end
