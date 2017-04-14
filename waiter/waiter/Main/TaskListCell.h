//
//  TaskListCell.h
//  waiter
//
//  Created by sjlh on 2017/4/13.
//  Copyright © 2017年 liuchao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TaskListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *borderView;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *roomNumber;
@property (weak, nonatomic) IBOutlet UILabel *callArea;
@property (weak, nonatomic) IBOutlet UILabel *callContent;
@property (weak, nonatomic) IBOutlet UILabel *orderTime;
@property (weak, nonatomic) IBOutlet UIButton *pickSingleButton;

@end
