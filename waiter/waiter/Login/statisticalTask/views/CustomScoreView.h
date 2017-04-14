//
//  CustomScoreView.h
//  bbbb
//
//  Created by new on 2017/4/11.
//  Copyright © 2017年 com.nono. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomScoreView : UIView
@property (strong, nonatomic) IBOutlet UIView *scoreView;
@property (nonatomic,assign) NSInteger scoreValue;//评分分数
@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (weak, nonatomic) IBOutlet UIImageView *imageView3;
@property (weak, nonatomic) IBOutlet UIImageView *imageView4;
@property (weak, nonatomic) IBOutlet UIImageView *imageView5;
@property(nonatomic,strong,readonly)NSArray * imageArray;

@end
