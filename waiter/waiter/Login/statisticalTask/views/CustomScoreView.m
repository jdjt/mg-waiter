//
//  CustomScoreView.m
//  bbbb
//
//  Created by new on 2017/4/11.
//  Copyright © 2017年 com.nono. All rights reserved.
//

#import "CustomScoreView.h"

@implementation CustomScoreView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        
        
        [[NSBundle mainBundle] loadNibNamed:@"CustomScoreView" owner:self options:nil];
        [self addSubview:self.scoreView];
        self.scoreView.translatesAutoresizingMaskIntoConstraints = NO;
        NSString * hvfl = @"|-0-[view]-0-|";
        NSString * vvfl = @"V:|-0-[view]-0-|";
        NSArray * hArray =  [NSLayoutConstraint constraintsWithVisualFormat:hvfl options:NSLayoutFormatAlignAllTop|NSLayoutFormatAlignAllBottom metrics:nil views:@{@"view":self.scoreView}];
        NSArray * vArray =  [NSLayoutConstraint constraintsWithVisualFormat:vvfl options:0 metrics:nil views:@{@"view":self.scoreView}];
        [self addConstraints:hArray];
        [self addConstraints:vArray];
        
        _imageArray = [[NSArray alloc]initWithObjects:self.imageView1,self.imageView2,self.imageView3,self.imageView4,self.imageView5,nil];
        
    }
    return self;

}
-(void)setScoreValue:(NSInteger)scoreValue{
    
    _scoreValue = scoreValue;
    for (int i = 0; i < _imageArray.count; i++) {
        UIImageView * imageView = _imageArray[i];
        if (i > scoreValue-1) {
            return;
        }
        imageView.image = [UIImage imageNamed:@"orangeStars"];
    }


}
@end
