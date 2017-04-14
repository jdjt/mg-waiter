//
//  CalendarViewController.h
//  waiter
//
//  Created by new on 2017/4/14.
//  Copyright © 2017年 liuchao. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CalendarDelegate <NSObject>
-(void)calendarSelectDateString:(NSString *)dateString;
@end

@interface CalendarViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) id<CalendarDelegate> delegate;
// 日历所选择日期的字符串（xxxx-xx-xx）
@property (copy, nonatomic) NSString * selectDateString;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *collectionLayout;

@end
