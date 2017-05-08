//
//  FootCell.h
//  waiter
//
//  Created by sjlh on 2017/4/14.
//  Copyright © 2017年 liuchao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FootCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *footView;
@property (weak, nonatomic) IBOutlet UIButton *completeButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *completeButtonHeight;
@end
